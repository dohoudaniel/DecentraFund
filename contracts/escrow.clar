
;; title: escrow
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

;; Escrow Contract
(use-trait ft-trait .reward-token.ft-trait)

;; Storage
(define-map escrow-funds 
  { project-id: uint }
  { 
    total-raised: uint, 
    released-amount: uint, 
    milestone-met: bool 
  }
)

;; Errors
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-FUNDS (err u2))
(define-constant ERR-MILESTONE-NOT-MET (err u3))

;; Create Escrow
(define-public (create-escrow (project-id uint))
  (begin
    (map-set escrow-funds 
      { project-id: project-id }
      { 
        total-raised: u0, 
        released-amount: u0, 
        milestone-met: false 
      }
    )
    (ok true)
  )
)

;; Contribute to Project
(define-public (contribute (project-id uint) (amount uint))
  (let 
    ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
    (map-set escrow-funds 
      { project-id: project-id }
      (merge current-funds { total-raised: (+ (get total-raised current-funds) amount) })
    )
    (ok true)
  )
)

;; Release Funds (only project owner)
(define-public (release-funds (project-id uint) (amount uint))
  (let 
    ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
    (asserts! (get milestone-met current-funds) ERR-MILESTONE-NOT-MET)
    (map-set escrow-funds 
      { project-id: project-id }
      (merge current-funds { 
        released-amount: (+ (get released-amount current-funds) amount) 
      })
    )
    (ok true)
  )
)

;; Get Project Funds
(define-read-only (get-project-funds (project-id uint))
  (map-get? escrow-funds { project-id: project-id })
)