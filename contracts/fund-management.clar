;; fund-management

(define-data-var total-funds uint 0)

(define-read-only (get-total-funds)
  (var-get total-funds)
)