(define-data-var milestones-met uint 0)
(define-constant milestone-target 10000)

(define-public (release-funds (milestone-number uint))
  (let ((milestones (var-get milestones-met)))
    (if (>= milestone-number milestones)
      (begin
        (var-set milestones-met milestone-number)
        (ok milestone-number)
      )
      (err u100)
    )
  )
)