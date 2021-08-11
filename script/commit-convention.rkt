#lang racket/base

(provide (all-defined-out))


;;; Project components and markers

(define default-component "Build")

(define components
  '(("Make" . #rx"^Makefile$")
    ("Doc" . #rx"^README.md$")
    ("Example" . #rx"^example.pp$")
    ("Files" . #rx"^files/.+")
    ("Script" . #rx"^script/.+")
    ("Templates" . #rx"^templates/.+")
    ("Manifests" . #rx"^manifests/.+")))

(define markers
  '("Add"
    "Change"
    "Bump"
    "Remove"
    "Fix"
    "Move"
    "Rephrase"))
