
;; contributors
;; <add a description here>

;; constants
;;

;; data maps and vars
;;

;; private functions
;;

;; public functions
;;

(define-map contributors principal uint)

(define-public (add-contribution (amount uint))
  (map-set contributors tx-sender (+ (default-to 0 (map-get? contributors tx-sender)) amount))
  (ok amount)
)

(define-read-only (get-contribution (address principal))
  (default-to 0 (map-get? contributors address))
)