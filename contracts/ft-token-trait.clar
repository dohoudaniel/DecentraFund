
;; ;; title: ft-token-trait
;; ;; version:
;; ;; summary:
;; ;; description:

;; ;; traits
;; ;;

;; ;; token definitions
;; ;;

;; ;; constants
;; ;;

;; ;; data vars
;; ;;

;; ;; data maps
;; ;;

;; ;; public functions
;; ;;

;; ;; read only functions
;; ;;

;; ;; private functions
;; ;;
;; ;; (define-trait ft-token-trait
;; ;;   (
;; ;;     (transfer (uint principal principal) (response bool uint))
;; ;;     (get-balance (principal) (response uint uint))
;; ;;     (get-total-supply () (response uint uint))
;; ;;     (mint (uint principal) (response bool uint))
;; ;;   )
;; ;; )
;; ;; (define-trait ft-token-trait 
;; ;;   (
;; ;;     (transfer (uint principal principal) (response bool uint))
;; ;;     (get-balance (principal) (response uint uint))
;; ;;     (get-total-supply () (response uint uint))
;; ;;     (mint (uint principal) (response bool uint))
;; ;;   )
;; ;; )
;; ;; (define-trait ft-token-trait
;; ;;   (
;; ;;     (transfer (uint principal principal) (response bool uint))
;; ;;     (get-balance (principal) (response uint uint))
;; ;;     (get-total-supply () (response uint uint))
;; ;;     (mint (uint principal) (response bool uint))
;; ;;   )
;; ;; )

;; (define-trait ft-token-trait
;;   (
;;     (transfer (uint principal principal) (response bool uint))
;;     (get-balance (principal) (response uint uint))
;;     (get-total-supply () (response uint uint))
;;     (mint (uint principal) (response bool uint))
;;   )
;; )
;; (define-trait ft-token-trait
;;   (
;;     (transfer (uint principal principal) (response bool uint))
;;     (get-balance (principal) (response uint uint))
;;     (get-total-supply () (response uint uint))
;;     (mint (uint principal) (response bool uint))
;;   )
;; )
;; (define-trait ft-token-trait
;;   (
;;     (transfer (uint principal principal) (response bool uint))
;;     (get-balance (principal) (response uint uint))
;;     (get-total-supply () (response uint uint))
;;     (mint (uint principal) (response bool uint))
;;   )
;; )
(define-trait ft-token-trait
  (
    (transfer (uint principal principal) (response bool uint))
    (get-balance (principal) (response uint uint))
    (get-total-supply () (response uint uint))
    (mint (uint principal) (response bool uint))
  )
)