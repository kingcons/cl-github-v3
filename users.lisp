(defpackage #:github-user
  (:use :cl)
  (:import-from :cl-github #:define-github-command))

(in-package #:github-user)

(define-github-command get-user (id)
    (:docs "Retreive a single user, ID.")
  (cl-github:api-command (cl-github:rel-path "/users/~A" id) :method :get))
