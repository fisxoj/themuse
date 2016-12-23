(defpackage #:themuse.api
  (:use #:cl #:alexandria #:nest)
  (:import-from #:themuse
                #:app))

(in-package #:themuse.api)

(defroute app "/api/jobs"
  (with-params (page descending company category level location)
    (respond-json (themuse.api-proxy:jobs
                   :page (or page 1)
                   :descending descending
                   :company company
                   :category (jojo:parse category)
                   :level (jojo:parse level)
                   :location (jojo:parse location)))))
