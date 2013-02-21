#|
  This file is a part of random-boolean-network project.
  Copyright (c) 2013 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage random-boolean-network-test-asd
  (:use :cl :asdf))
(in-package :random-boolean-network-test-asd)

(defsystem random-boolean-network-test
  :author "Masataro Asai"
  :license "LLGPL"
  :depends-on (:random-boolean-network
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "random-boolean-network"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
