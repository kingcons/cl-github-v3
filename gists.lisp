(defpackage #:github-gist
  (:use :cl)
  (:import-from :cl-github #:define-github-command))

(in-package #:github-gist)

(define-github-command list-gists (user)
    (:docs "List the public gists for USER if provided, or the authenticated user.")
  (cl-github:api-command (if user
                             (cl-github:rel-path "/users/~A/gists" user)
                             "/gists") :method :get))

(define-github-command get-gist (id)
    (:docs "Retrieve a single gist, ID.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A" id) :method :get))

(define-github-command create-gist (description public files)
    (:docs "Create a new gist containing CONTENT with privacy based on PUBLIC.
FILES should be a plist of filename keys containing a '(:content 'content-str').")
  (cl-github:booleanize-parameters parameters :public)
  (cl-github:api-command "/gists" :method :post :body parameters))

(define-github-command star-gist (id)
    (:docs "Star the gist with the given ID.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A/star" id) :method :put))

(define-github-command unstar-gist (id)
    (:docs "Unstar the gist with the given ID.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A/star" id) :method :delete))

(define-github-command gist-starred-p (id)
    (:docs "Check to see if the gist ID is starred.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A/star" id) :method :get))

(define-github-command fork-gist (id)
    (:docs "Fork the gist ID.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A/forks" id) :method :post))

(define-github-command delete-gist (id)
    (:docs "Delete the gist with the given ID.")
  (cl-github:api-command (cl-github:rel-path "/gists/~A" id) :method :delete))
