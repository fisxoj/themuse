(defpackage #:themuse.api
  (:use #:cl #:alexandria #:nest)
  (:import-from #:themuse
                #:app))

(in-package #:themuse.api)

(defroute app "/api/jobs"
  (with-params (page descending company categories levels locations)
    (respond-json (themuse.api-proxy:jobs
                   :page (or page 1)
                   :descending descending
                   :company company
                   :category categories
                   :level levels
                   :location locations))))
