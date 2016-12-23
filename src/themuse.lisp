(in-package :cl-user)
(defpackage themuse
  (:use #:cl #:alexandria #:nest))
(in-package :themuse)


(defapp museapp
    :middlewares (lack.middleware.backtrace:*lack-middleware-backtrace*
                  lack.middleware.session:*lack-middleware-session*
                  (clack-static-asset-middleware:*clack-static-asset-middleware*
                    :root (asdf:system-relative-pathname :themuse "static/"))
                  nest.middlewares.csrf:*csrf-middleware*))

(defroute app "/"
  (render "index.html"))

(defmethod nest:not-found ((app museapp))
  (render "index.html"))
