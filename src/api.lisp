(defpackage #:themuse.api
  (:use #:cl #:alexandria #:nest)
  (:import-from #:themuse
                #:app))

(in-package #:themuse.api)

(defroute app "/api/jobs"
  (with-params (page descending companies categories levels locations)
    (respond-json (themuse.api-proxy:jobs
                   :page (or page 1)
                   :descending descending
                   :company companies
                   :category categories
                   :level levels
                   :location locations))))
