#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network
  (:use :cl :annot :annot.doc :iterate))
(in-package :random-boolean-network)

;; blah blah blah.

;; @doc "the number of inputs on each node"
;; (defparameter *k* 2)

;; @doc "the number of nodes"
;; (defparameter *n* 4)

;; (defun make-bit-array (k)
;;   (make-array k :element-type 'bit :initial-element 0))

;; (defun make-random-bit-array (k)
;;   (let ((a (make-bit-array k)))
;; 	(iter (for i below k)
;; 		  (setf (aref a i) (random 2) ))
;; 	a))

