(in-package :cl-user)
(defpackage themuse
  (:use #:cl #:alexandria #:nest))
(in-package :themuse)


(defapp museapp)

(defroute app "/"
  (render "index.html"))

(defmethod nest:not-found ((app museapp))
  (render "index.html"))
