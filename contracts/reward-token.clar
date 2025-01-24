
;; title: reward-token
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
;;

;; data vars
;;

;; data maps
;;

;; public functions
;;

;; read only functions
;;

;; private functions
;;

;; Reward Token Contract
(define-fungible-token reward-token)

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))

;; Read-only Functions
(define-read-only (get-balance (account principal))
  (ft-get-balance reward-token account)
)

(define-read-only (get-total-supply)
  (ft-get-total-supply reward-token)
)

;; Mint function (only contract owner can mint)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (ft-mint? reward-token amount recipient)
  )
)

;; Transfer function
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
    (ft-transfer? reward-token amount sender recipient)
  )
)