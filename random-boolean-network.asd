#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

#|
  a simple implementation of random boolean network.

  Author: Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network-asd
  (:use :cl :asdf))
(in-package :random-boolean-network-asd)

(defsystem random-boolean-network
  :version "0.1"
  :author "Masataro Asai"
  :license "LLGPL"
  :depends-on (:iterate
               :alexandria
               :cl-annot
			   :fare-csv
               :anaphora
			   :guicho-utilities)
  :components ((:module "src" :serial t
                :components
                ((:file :random-boolean-network)
				 (:file :csv-writer))))
  :description "a simple implementation of random boolean network."
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op random-boolean-network-test))))
