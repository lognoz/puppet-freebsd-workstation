#lang racket/base

(require racket/cmdline
         racket/system
         racket/string
         racket/file)

(require "./commit-convention.rkt")

(define path
  (command-line #:args (filename) filename))

(define message
  (car (string-split (string-trim (file->string path)) "\n")))

(define (component-regex component)
  (regexp-match (regexp (string-append "^" component ": .+")) message))

(define (marker-regex component marker)
  (regexp-match (regexp (string-append "^" component ": " marker " .+")) message))

(define (raise-error error-message)
  (displayln "Invalid commit message, please fix:")
  (displayln (string-append error-message "\n"))
  (displayln (string-append "Example:\n " default-component ": " (car markers) " new feature in file"))
  (exit 1))

(define matched-component
  (let ([available-components ""]
        [component null]
        [name null])
    (map (λ (parameters)
           (set! name (car parameters))
           (set! available-components
                 (string-append available-components name ", "))
           (when (component-regex name)
             (set! component name)))
         components)
    (set! available-components (string-trim available-components ", "))
    (when (component-regex default-component)
      (set! component default-component))
    (cond
      [(not (null? component)) component]
      [else
        (raise-error
          (string-append "You need to define a component (" available-components ")."))])))

(define matched-marker
  (let ([available-markers ""]
        [marker null])
    (map (λ (name)
           (set! available-markers
                 (string-append available-markers name ", "))
           (when (marker-regex matched-component name)
             (set! marker name)))
         markers)
    (set! available-markers (string-trim available-markers ", "))
    (cond
      [(not (null? marker)) marker]
      [else
       (raise-error
        (string-append "You need to define a marker (" available-markers ")."))])))
