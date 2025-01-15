
;; crowdfunding
;; <add a description here>

;; constants
;;

;; data maps and vars
;;

;; private functions
;;

;; public functions
;;
(define-public (contribute (amount uint))
  (let ((current-funds (var-get total-funds)))
    (begin
      (var-set total-funds (+ current-funds amount))
      (ok current-funds)
    )
  )
)