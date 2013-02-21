#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network-test
  (:use :cl
        :random-boolean-network
        :cl-test-more
		:annot :annot.doc :iterate :guicho-utilities))
(in-package :random-boolean-network-test)
(enable-annot-syntax)

(plan nil)

; #B1010

(defun task (dir examples-per-parameter
			 &optional (n1 4) (n2 7) (k1 2) (k2 4))
  (let ((dir (merge-pathnames
			  (cl-fad:pathname-as-directory dir)
			  *default-pathname-defaults*)))
	(ensure-directories-exist dir)
	(iter
	  (for n from n1 to n2)
	  (iter
		(for k from k1 to k2)
		(for dirname = (merge-pathnames
						(format nil "result-~a-~a/" n k)
						dir))
		(format t "entered ~a~%" dirname)
		(ensure-directories-exist dirname)
		(iter
		  (for i below examples-per-parameter)
		  (for nodes = (initialize
						n 'rbn-node
						:nodes n :inputs k))
		  (output-nodes-to-csv
		   nodes
		   (merge-pathnames 
			(format nil "nodes-~a.csv" i)
			dirname))
		  (output-graph-to-csv
		   (investigate-rbn nodes)
		   (merge-pathnames 
			(format nil "graph-~a.csv" i)
			dirname)))))))


;(investigate-rbn *nodes*)

(finalize)
