#|
  This file is a part of themuse project.
  Copyright (c) 2016 Matt Novenstern (matt.novenstern@gmail.com)
|#

#|
  Take home challenge for The Muse

  Author: Matt Novenstern (matt.novenstern@gmail.com)
|#

(in-package :cl-user)
(defpackage themuse-asd
  (:use :cl :asdf))
(in-package :themuse-asd)

(defsystem themuse
  :version "0.1"
  :author "Matt Novenstern"
  :license "Secret"
  :depends-on (:nest
               :function-cache
               :dexador)
  :components ((:module "src"
                :components
                ((:file "api-proxy")
                 (:file "themuse")
                 (:file "api"))))
  :description "Take home challenge for The Muse"
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
  :in-order-to ((test-op (test-op themuse-test))))
