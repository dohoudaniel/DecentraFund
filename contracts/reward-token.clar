
;; ;; ;; title: reward-token
;; ;; ;; version:
;; ;; ;; summary:
;; ;; ;; description:

;; ;; ;; traits
;; ;; ;;

;; ;; ;; token definitions
;; ;; ;;

;; ;; ;; constants
;; ;; ;;

;; ;; ;; data vars
;; ;; ;;

;; ;; ;; data maps
;; ;; ;;

;; ;; ;; public functions
;; ;; ;;

;; ;; ;; read only functions
;; ;; ;;

;; ;; ;; private functions
;; ;; ;;

;; ;; ;; Reward Token Contract
;; ;; ;; (define-fungible-token reward-token)

;; ;; ;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; ;; ;; ;; Trait definition
;; ;; ;; (define-trait ft-trait
;; ;; ;;   ((transfer (uint principal principal) (response bool uint))
;; ;; ;;    (get-balance (principal) (response uint uint))
;; ;; ;;    (get-total-supply () (response uint uint))
;; ;; ;;    (mint (uint principal) (response bool uint))
;; ;; ;;   )
;; ;; ;; )

;; ;; ;; ;; Constants
;; ;; ;; (define-constant CONTRACT-OWNER tx-sender)
;; ;; ;; (define-constant ERR-NOT-AUTHORIZED (err u1))
;; ;; ;; (define-constant ERR-INSUFFICIENT-BALANCE (err u2))

;; ;; ;; ;; Read-only Functions
;; ;; ;; (define-read-only (get-balance (account principal))
;; ;; ;;   (ft-get-balance reward-token account)
;; ;; ;; )

;; ;; ;; (define-read-only (get-total-supply)
;; ;; ;;   (ft-get-total-supply reward-token)
;; ;; ;; )

;; ;; ;; ;; Mint function (only contract owner can mint)
;; ;; ;; (define-public (mint (amount uint) (recipient principal))
;; ;; ;;   (begin
;; ;; ;;     (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
;; ;; ;;     (ft-mint? reward-token amount recipient)
;; ;; ;;   )
;; ;; ;; )

;; ;; ;; ;; Transfer function
;; ;; ;; (define-public (transfer (amount uint) (sender principal) (recipient principal))
;; ;; ;;   (begin
;; ;; ;;     (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
;; ;; ;;     (ft-transfer? reward-token amount sender recipient)
;; ;; ;;   )
;; ;; ;; )

;; ;; ;; (impl-trait .ft-token-trait.ft-token-trait)
;; ;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; ;; (define-fungible-token reward-token)

;; ;; ;; Constants
;; ;; (define-constant CONTRACT-OWNER tx-sender)
;; ;; (define-constant ERR-NOT-AUTHORIZED (err u1))
;; ;; (define-constant ERR-INSUFFICIENT-BALANCE (err u2))

;; ;; ;; Read-only Functions
;; ;; (define-read-only (get-balance (account principal))
;; ;;   (ok (ft-get-balance reward-token account))
;; ;; )

;; ;; (define-read-only (get-total-supply)
;; ;;   (ok (ft-get-total-supply reward-token))
;; ;; )

;; ;; ;; Mint function (only contract owner can mint)
;; ;; (define-public (mint (amount uint) (recipient principal))
;; ;;   (begin
;; ;;     (try! (check-is-owner))
;; ;;     (ft-mint? reward-token amount recipient)
;; ;;   )
;; ;; )

;; ;; ;; Transfer function
;; ;; (define-public (transfer (amount uint) (sender principal) (recipient principal))
;; ;;   (begin
;; ;;     (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
;; ;;     (ft-transfer? reward-token amount sender recipient)
;; ;;   )
;; ;; )

;; ;; ;; Owner check helper
;; ;; (define-private (check-is-owner)
;; ;;   (begin
;; ;;     (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
;; ;;     (ok true)
;; ;;   )
;; ;; )

;; (impl-trait .ft-token-trait.ft-token-trait)

;; (define-fungible-token reward-token)

;; (define-constant CONTRACT-OWNER tx-sender)
;; (define-constant ERR-NOT-AUTHORIZED (err u1))
;; (define-constant ERR-INSUFFICIENT-BALANCE (err u2))

;; (define-read-only (get-balance (account principal))
;;   (ok (ft-get-balance reward-token account))
;; )

;; (define-read-only (get-total-supply)
;;   (ok (ft-get-total-supply reward-token))
;; )

;; (define-public (mint (amount uint) (recipient principal))
;;   (begin
;;     (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
;;     (ft-mint? reward-token amount recipient)
;;   )
;; )

;; (define-public (transfer (amount uint) (sender principal) (recipient principal))
;;   (begin
;;     (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
;;     (ft-transfer? reward-token amount sender recipient)
;;   )
;; )

(impl-trait .ft-token-trait.ft-token-trait)

(define-fungible-token reward-token)

(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance reward-token account))
)

(define-read-only (get-total-supply)
  (ok (ft-get-total-supply reward-token))
)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (ft-mint? reward-token amount recipient)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
    (ft-transfer? reward-token amount sender recipient)
  )
)
