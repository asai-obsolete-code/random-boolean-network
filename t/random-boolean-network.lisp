#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network-test
  (:use :cl
        :random-boolean-network
		:cl-csv
        :cl-test-more
		:annot :annot.doc :iterate :guicho-utilities))
(in-package :random-boolean-network-test)
(enable-annot-syntax)

(plan nil)


@doc "the number of inputs on each node"
(defparameter *k* 3)
@doc "the number of nodes"
(defparameter *n* 4)

; #B1010

(defclass rbn-node-tester (rbn-node)
  ((input-mask :initform (make-random-mask *n* *k*))
   (array :initform (random (expt 2 *n*)))))

(defparameter *nodes* (initialize *n* 'rbn-node-tester))

(investigate-rbn *nodes*)



(finalize)
