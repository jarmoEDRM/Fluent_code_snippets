; Execute text commands without console output
(define (m-quiet command)
  (let ((psst))
    (set! psst (with-output-to-string
      (lambda ()
        (ti-menu-load-string command))))))