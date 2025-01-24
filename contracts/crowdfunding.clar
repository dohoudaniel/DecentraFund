
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
;; Crowdfunding Platform Contract
(use-trait ft-trait .reward-token.ft-trait)

;; Project Struct
(define-map projects
  { project-id: uint }
  {
    creator: principal,
    goal-amount: uint,
    deadline: uint,
    total-raised: uint,
    reward-tier-1: uint,
    reward-tier-2: uint,
    reward-tier-3: uint
  }
)

;; Contributions Tracking
(define-map contributions 
  { project-id: uint, contributor: principal }
  { amount: uint, reward-tier: uint }
)

;; Errors
(define-constant ERR-PROJECT-NOT-FOUND (err u1))
(define-constant ERR-INSUFFICIENT-CONTRIBUTION (err u2))
(define-constant ERR-DEADLINE-PASSED (err u3))

;; Create Project
(define-public (create-project 
  (goal-amount uint) 
  (deadline uint)
  (reward-tier-1 uint)
  (reward-tier-2 uint)
  (reward-tier-3 uint)
)
  (let 
    ((project-id (var-get next-project-id)))
    (map-set projects 
      { project-id: project-id }
      {
        creator: tx-sender,
        goal-amount: goal-amount,
        deadline: deadline,
        total-raised: u0,
        reward-tier-1: reward-tier-1,
        reward-tier-2: reward-tier-2,
        reward-tier-3: reward-tier-3
      }
    )
    (var-set next-project-id (+ project-id u1))
    (ok project-id)
  )
)

;; Contribute to Project
(define-public (contribute (project-id uint) (amount uint))
  (let 
    ((project (unwrap! (map-get? projects { project-id: project-id }) ERR-PROJECT-NOT-FOUND))
     (current-time block-height)
     (reward-tier 
       (cond 
         ((>= amount (get reward-tier-3 project)) u3)
         ((>= amount (get reward-tier-2 project)) u2)
         ((>= amount (get reward-tier-1 project)) u1)
         (true u0)
       )
     )
    )
    ;; Check deadline not passed
    (asserts! (< current-time (get deadline project)) ERR-DEADLINE-PASSED)
    
    ;; Update project total raised
    (map-set projects 
      { project-id: project-id }
      (merge project { 
        total-raised: (+ (get total-raised project) amount) 
      })
    )
    
    ;; Track individual contribution
    (map-set contributions 
      { project-id: project-id, contributor: tx-sender }
      { amount: amount, reward-tier: reward-tier }
    )
    
    (ok reward-tier)
  )
)

;; Variables
(define-data-var next-project-id uint u1)
