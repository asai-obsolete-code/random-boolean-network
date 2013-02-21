#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network
  (:use :cl :annot :annot.doc :iterate :guicho-utilities))
(in-package :random-boolean-network)

;; blah blah blah.

@doc "the number of inputs on each node"
(defparameter *k* 3)

@doc "the number of nodes"
(defparameter *n* 4)

(defun make-bit-array (n)
  (make-array n :element-type 'bit :initial-element 0))

(defun make-random-bit-array (n)
  (let ((a (make-bit-array n)))
	(iter (for i below n)
		  (setf (aref a i) (random 2) ))
	a))

(defun make-random-mask (n k)
  (let ((a 0))
	(iter (generating j to (- k 2))
		  (for i = (random n))
		  (unless (logbitp i a)
			(setf (ldb (byte 1 i) a) 1)
			(next j)))
	a))

(defclass rbn-node ()
  ((input-mask :initform (make-random-mask *n* *k*))
   (array :initform (random *n*))))

(defun propagate (node states)
  (with-slots (array input-mask) node
	
  


(defmethod propagate ((node rbn-node))
  (with-slots (state nodes array input-indexes) node
	(setf state (aref array (%parse-indexes nodes input-indexes))))

(%parse-indexes (vector (new 'rbn-node :input-indexes '(1) :state 1)
						(new 'rbn-node :input-indexes '(0) :state 1))
					'(0 1))