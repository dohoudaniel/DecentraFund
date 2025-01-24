;; ;; ;; ;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; ;; ;; ;; (define-trait ft-token-trait 
;; ;; ;; ;;   (
;; ;; ;; ;;     (transfer (uint principal principal) (response bool uint))
;; ;; ;; ;;     (get-balance (principal) (response uint uint))
;; ;; ;; ;;     (get-total-supply () (response uint uint))
;; ;; ;; ;;     (mint (uint principal) (response bool uint))
;; ;; ;; ;;   )
;; ;; ;; ;; )

;; ;; ;; ;; ;; Storage
;; ;; ;; ;; (define-map escrow-funds 
;; ;; ;; ;;   { project-id: uint }
;; ;; ;; ;;   { 
;; ;; ;; ;;     total-raised: uint, 
;; ;; ;; ;;     released-amount: uint, 
;; ;; ;; ;;     milestone-met: bool 
;; ;; ;; ;;   }
;; ;; ;; ;; )

;; ;; ;; ;; ;; Errors
;; ;; ;; ;; (define-constant ERR-NOT-AUTHORIZED (err u1))
;; ;; ;; ;; (define-constant ERR-INSUFFICIENT-FUNDS (err u2))
;; ;; ;; ;; (define-constant ERR-MILESTONE-NOT-MET (err u3))

;; ;; ;; ;; ;; Create Escrow
;; ;; ;; ;; (define-public (create-escrow (project-id uint))
;; ;; ;; ;;   (begin
;; ;; ;; ;;     (map-set escrow-funds 
;; ;; ;; ;;       { project-id: project-id }
;; ;; ;; ;;       { 
;; ;; ;; ;;         total-raised: u0, 
;; ;; ;; ;;         released-amount: u0, 
;; ;; ;; ;;         milestone-met: false 
;; ;; ;; ;;       }
;; ;; ;; ;;     )
;; ;; ;; ;;     (ok true)
;; ;; ;; ;;   )
;; ;; ;; ;; )

;; ;; ;; ;; ;; Contribute to Project
;; ;; ;; ;; (define-public (contribute (project-id uint) (amount uint))
;; ;; ;; ;;   (let 
;; ;; ;; ;;     ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
;; ;; ;; ;;     (map-set escrow-funds 
;; ;; ;; ;;       { project-id: project-id }
;; ;; ;; ;;       (merge current-funds { total-raised: (+ (get total-raised current-funds) amount) })
;; ;; ;; ;;     )
;; ;; ;; ;;     (ok true)
;; ;; ;; ;;   )
;; ;; ;; ;; )

;; ;; ;; ;; ;; Release Funds (only project owner)
;; ;; ;; ;; (define-public (release-funds (project-id uint) (amount uint))
;; ;; ;; ;;   (let 
;; ;; ;; ;;     ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
;; ;; ;; ;;     (asserts! (get milestone-met current-funds) ERR-MILESTONE-NOT-MET)
;; ;; ;; ;;     (map-set escrow-funds 
;; ;; ;; ;;       { project-id: project-id }
;; ;; ;; ;;       (merge current-funds { 
;; ;; ;; ;;         released-amount: (+ (get released-amount current-funds) amount) 
;; ;; ;; ;;       })
;; ;; ;; ;;     )
;; ;; ;; ;;     (ok true)
;; ;; ;; ;;   )
;; ;; ;; ;; )

;; ;; ;; ;; ;; Get Project Funds
;; ;; ;; ;; (define-read-only (get-project-funds (project-id uint))
;; ;; ;; ;;   (map-get? escrow-funds { project-id: project-id })
;; ;; ;; ;; )

;; ;; ;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; ;; ;; ;; Storage
;; ;; ;; (define-map escrow-funds 
;; ;; ;;   { project-id: uint }
;; ;; ;;   { 
;; ;; ;;     total-raised: uint, 
;; ;; ;;     released-amount: uint, 
;; ;; ;;     milestone-met: bool 
;; ;; ;;   }
;; ;; ;; )

;; ;; ;; ;; Errors
;; ;; ;; (define-constant ERR-NOT-AUTHORIZED (err u1))
;; ;; ;; (define-constant ERR-INSUFFICIENT-FUNDS (err u2))
;; ;; ;; (define-constant ERR-MILESTONE-NOT-MET (err u3))

;; ;; ;; ;; Create Escrow
;; ;; ;; (define-public (create-escrow (project-id uint))
;; ;; ;;   (begin
;; ;; ;;     (map-set escrow-funds 
;; ;; ;;       { project-id: project-id }
;; ;; ;;       { 
;; ;; ;;         total-raised: u0, 
;; ;; ;;         released-amount: u0, 
;; ;; ;;         milestone-met: false 
;; ;; ;;       }
;; ;; ;;     )
;; ;; ;;     (ok true)
;; ;; ;;   )
;; ;; ;; )

;; ;; ;; ;; Get Project Funds
;; ;; ;; (define-read-only (get-project-funds (project-id uint))
;; ;; ;;   (map-get? escrow-funds { project-id: project-id })
;; ;; ;; )

;; ;; ;; ;; Mark Milestone
;; ;; ;; (define-public (mark-milestone (project-id uint))
;; ;; ;;   (let 
;; ;; ;;     ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
;; ;; ;;     (map-set escrow-funds 
;; ;; ;;       { project-id: project-id }
;; ;; ;;       (merge current-funds { milestone-met: true })
;; ;; ;;     )
;; ;; ;;     (ok true)
;; ;; ;;   )
;; ;; ;; )

;; ;; ;; Project Struct

;; ;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; ;; (define-map projects
;; ;;   { project-id: uint }
;; ;;   {
;; ;;     creator: principal,
;; ;;     goal-amount: uint,
;; ;;     deadline: uint,
;; ;;     total-raised: uint,
;; ;;     reward-tier-1: uint,
;; ;;     reward-tier-2: uint,
;; ;;     reward-tier-3: uint
;; ;;   }
;; ;; )

;; ;; ;; Contributions Tracking
;; ;; (define-map contributions 
;; ;;   { project-id: uint, contributor: principal }
;; ;;   { amount: uint, reward-tier: uint }
;; ;; )

;; ;; ;; Errors
;; ;; (define-constant ERR-PROJECT-NOT-FOUND (err u1))
;; ;; (define-constant ERR-INSUFFICIENT-CONTRIBUTION (err u2))
;; ;; (define-constant ERR-DEADLINE-PASSED (err u3))

;; ;; ;; Create Project
;; ;; (define-public (create-project 
;; ;;   (goal-amount uint) 
;; ;;   (deadline uint)
;; ;;   (reward-tier-1 uint)
;; ;;   (reward-tier-2 uint)
;; ;;   (reward-tier-3 uint)
;; ;; )
;; ;;   (let 
;; ;;     ((project-id (var-get next-project-id)))
;; ;;     (map-set projects 
;; ;;       { project-id: project-id }
;; ;;       {
;; ;;         creator: tx-sender,
;; ;;         goal-amount: goal-amount,
;; ;;         deadline: deadline,
;; ;;         total-raised: u0,
;; ;;         reward-tier-1: reward-tier-1,
;; ;;         reward-tier-2: reward-tier-2,
;; ;;         reward-tier-3: reward-tier-3
;; ;;       }
;; ;;     )
;; ;;     (var-set next-project-id (+ project-id u1))
;; ;;     (ok project-id)
;; ;;   )
;; ;; )

;; ;; ;; Contribute to Project
;; ;; (define-public (contribute (project-id uint) (amount uint))
;; ;;   (let 
;; ;;     ((project (unwrap! (map-get? projects { project-id: project-id }) ERR-PROJECT-NOT-FOUND))
;; ;;      (current-time block-height)
;; ;;      (reward-tier 
;; ;;        (cond 
;; ;;          ((>= amount (get reward-tier-3 project)) u3)
;; ;;          ((>= amount (get reward-tier-2 project)) u2)
;; ;;          ((>= amount (get reward-tier-1 project)) u1)
;; ;;          (true u0)
;; ;;        )
;; ;;      )
;; ;;     )
;; ;;     ;; Check deadline not passed
;; ;;     (asserts! (< current-time (get deadline project)) ERR-DEADLINE-PASSED)
    
;; ;;     ;; Update project total raised
;; ;;     (map-set projects 
;; ;;       { project-id: project-id }
;; ;;       (merge project { 
;; ;;         total-raised: (+ (get total-raised project) amount) 
;; ;;       })
;; ;;     )
    
;; ;;     ;; Track individual contribution
;; ;;     (map-set contributions 
;; ;;       { project-id: project-id, contributor: tx-sender }
;; ;;       { amount: amount, reward-tier: reward-tier }
;; ;;     )
    
;; ;;     (ok reward-tier)
;; ;;   )
;; ;; )

;; ;; ;; Variables
;; ;; (define-data-var next-project-id uint u1)

;; (use-trait ft-token-trait .ft-token-trait.ft-token-trait)

;; (define-map escrow-funds 
;;   { project-id: uint }
;;   { 
;;     total-raised: uint, 
;;     released-amount: uint, 
;;     milestone-met: bool 
;;   }
;; )

;; (define-constant ERR-INSUFFICIENT-FUNDS (err u1))
;; (define-constant ERR-MILESTONE-NOT-MET (err u2))

;; (define-public (create-escrow (project-id uint))
;;   (begin
;;     (map-set escrow-funds 
;;       { project-id: project-id }
;;       { 
;;         total-raised: u0, 
;;         released-amount: u0, 
;;         milestone-met: false 
;;       }
;;     )
;;     (ok true)
;;   )
;; )

;; (define-read-only (get-project-funds (project-id uint))
;;   (map-get? escrow-funds { project-id: project-id })
;; )

;; (define-public (mark-milestone (project-id uint))
;;   (let 
;;     ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
;;     (map-set escrow-funds 
;;       { project-id: project-id }
;;       (merge current-funds { milestone-met: true })
;;     )
;;     (ok true)
;;   )
;; )

(use-trait ft-token-trait .ft-token-trait.ft-token-trait)

(define-map escrow-funds 
  { project-id: uint }
  { 
    total-raised: uint, 
    released-amount: uint, 
    milestone-met: bool 
  }
)

(define-constant ERR-INSUFFICIENT-FUNDS (err u1))
(define-constant ERR-MILESTONE-NOT-MET (err u2))

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

(define-read-only (get-project-funds (project-id uint))
  (map-get? escrow-funds { project-id: project-id })
)

(define-public (mark-milestone (project-id uint))
  (let 
    ((current-funds (unwrap! (get-project-funds project-id) ERR-INSUFFICIENT-FUNDS)))
    (map-set escrow-funds 
      { project-id: project-id }
      (merge current-funds { milestone-met: true })
    )
    (ok true)
  )
)
