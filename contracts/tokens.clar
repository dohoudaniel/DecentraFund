
;; tokens
(define-map reward-tokens principal uint)

(define-public (issue-reward-tokens)
  (let ((funds-contributed (map-get? contributors tx-sender)))
    (if funds-contributed
      (begin
        (map-set reward-tokens tx-sender funds-contributed)
        (ok funds-contributed)
      )
      (err u101)
    )
  )
)

(define-read-only (get-reward-token-balance (address principal))
  (default-to 0 (map-get? reward-tokens address))
)
