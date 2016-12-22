#|
  This file is a part of themuse project.
  Copyright (c) 2016 Matt Novenstern (matt.novenstern@gmail.com)
|#

(in-package :cl-user)
(defpackage themuse-test-asd
  (:use :cl :asdf))
(in-package :themuse-test-asd)

(defsystem themuse-test
  :author "Matt Novenstern"
  :license "Secret"
  :depends-on (:themuse
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "themuse"))))
  :description "Test system for themuse"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
