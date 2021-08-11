#lang racket/base

(require racket/cmdline
         racket/string
         racket/system
         racket/port
         racket/file)

(require "./commit-convention.rkt")


;;; System variables

(define staged-files
  (string-split
    (with-output-to-string
      (λ ()
        (system "git diff --name-only --cached")))
    "\n"))

(define matched-component
  (let ([component null]
        [staged-files-length (length staged-files)])
    (map (λ (parameters)
          (let ([name (car parameters)]
                [regex (cdr parameters)]
                [matched-length 0])
            (map (λ (f)
                   (when (regexp-match regex f)
                     (set! matched-length (+ matched-length 1))))
                 staged-files)
            (when (= matched-length staged-files-length)
              (set! component name))))
         components)
    (cond
      [(not (null? component)) component]
      [else default-component])))


;;; Write to file

(define path
  (car (vector->list (current-command-line-arguments))))

(define file-content
  (file->string path))

(call-with-output-file path #:exists 'replace
  (λ (out)
    (write-string (string-append matched-component ": " file-content) out)))