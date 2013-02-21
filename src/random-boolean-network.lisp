#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network
  (:use :cl :annot :annot.doc :annot.class :iterate :guicho-utilities
		:fare-csv
		:alexandria))
(in-package :random-boolean-network)
(enable-annot-syntax)
;; blah blah blah.

(defun make-bit-array (n)
  (make-array n :element-type 'bit :initial-element 0))

(defun make-random-bit-array (n)
  (let ((a (make-bit-array n)))
	(iter (for i below n)
		  (setf (aref a i) (random 2) ))
	a))

;; bit formatter
;; (format t "~16,'0b" (make-random-mask 5 2))

@export
@doc "print an integer in binary format"
(defun print-integer-binary (a)
  (format t "~16,'0b" a))

@export
@doc "returns an (integer 0 n) which has only K bits ON."
(defun make-random-mask (n k)
  (let ((a 0))
	(iter (generating j to (- k 2))
		  (for i = (random n))
		  (unless (logbitp i a)
			(setf (ldb (byte 1 i) a) 1)
			(next j)))
	a))

@export
@export-slots
@doc "The Random-Boolean Network class."
(defclass rbn-node ()
  ((input-mask :type integer :initarg :input-mask)
   (array :type integer :initarg :array)))

(defmethod initialize-instance :after ((node rbn-node)
									   &rest args
									   &key nodes inputs
									   &allow-other-keys)
  @ignore args
  (with-slots (input-mask array) node
	(setf input-mask (make-random-mask nodes inputs)
		  array      (random (expt 2 nodes)))))

@export
(defun inputs (rbn-node)
  (with-slots (input-mask) rbn-node
	(let ((l (integer-length input-mask)))
	  (iter (for i below l)
			(when (logbitp i input-mask)
			  (collect i))))))

@export
@doc "returns N rbn-node instances in an array."
(defun initialize (n class &rest args)
  (let ((nodes (make-array n)))
	(iter (for i below n)
		  (setf (aref nodes i) (apply #'new class args)))
	nodes))

@export
@doc "propagates each node. Uses global set of states as its input."
(defun propagate (node states)
  (with-slots (array input-mask) node
	(ldb (byte 1 (logand states input-mask)) array)))

@export
(defun bit-vector-to-integer (bits)
  @type (array bit) bits
  (reduce #'(lambda (a b)
			  @type fixnum a
			  @type bit b
			  (+ (ash a 1) b))
		  bits))

@export
@doc "propagates all nodes and return a global state in the form of integer (bit-vector)."
(defun propagate-all (nodes states)
  (bit-vector-to-integer
   (map 'bit-vector (rcurry #'propagate states) nodes)))

@export @doc "create the container of the graph which represents the
propagation of states. n is a number of nodes. returns array of size =
2^n ."
(defun make-rbn-graph (2^n)
  (make-array 2^n :element-type 'integer :initial-element -1))

@export
@doc "returns an (integer 0 n) which is randomized for the initial state."
(defun make-random-global-states (2^n)
  (random 2^n))

(defun %investigate-rbn (2^n investigated nodes graph)
  (if (= 2^n investigated)
	  (values graph investigated)
	  (let ((states (make-random-global-states 2^n)))
		(if (not (minusp (aref graph states)))
			(%investigate-rbn 2^n investigated nodes graph) ;;もう一度
			(let ((new-states (propagate-all nodes states)))
			  (setf (aref graph states) new-states)
			  ;; (format t "~10d ~10d ~10d ~%" investigated states new-states)
			  (%investigate-rbn 2^n (1+ investigated) nodes graph))))))

@export
@doc "creates a graph"
(defun investigate-rbn (nodes)
  (let ((2^n (expt 2 (array-dimension nodes 0))))
	(%investigate-rbn 2^n 0 nodes (make-rbn-graph 2^n))))