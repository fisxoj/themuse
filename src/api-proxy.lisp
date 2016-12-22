(defpackage #:themuse.api-proxy
  (:use #:cl #:alexandria #:function-cache)
  (:export #:jobs
           #:invalid-request
           #:rate-limited))

(in-package #:themuse.api-proxy)

(defparameter +api-base+ (quri:make-uri :scheme "https" :host "api-v2.themuse.com"))
(defparameter +jobs-endpoint+ (quri:merge-uris (quri:make-uri :path "/jobs") +api-base+))


(define-condition invalid-request (simple-condition)
  ((message :initarg :message))
  (:report (lambda (e stream)
             (format stream "An invalid request was sent to the API.  It responded with ~S" (slot-value e 'message)))))

(define-condition rate-limited (simple-condition)
  ((reset-time :initarg :reset-time))
  (:report (lambda (e stream)
             (format stream "The rate limit for the API has been exceede.  It resets in ~d seconds." (slot-value e 'reset-time)))))


(defcached (jobs :cache-class 'lru-cache :capacity 20)
    (&key (page 1) (descending nil) (company "") (category nil) (level nil) location)
  "Queries the Muse API for job results.  Caches 20 queries since some might be repeated often and aren't likely to change that often."

  (let ((query (quri:copy-uri +jobs-endpoint+))
        ;; Create an alist with the simple params
        (params `(("page" . ,page)
                  ("descending" . ,descending)
                  ("api_key" . ,(nest:config :themuse-api-key)))))

    (when (not (emptyp company))
      (push (cons "company" company) params))

    ;; Helper to add mutiple value fields to the request
    (flet ((append-multival-param (field list)
             (dolist (el list)
               (push (cons field el) params))))

      (append-multival-param "category" category)
      (append-multival-param "level" level)
      (append-multival-param "location" location))

    (setf (quri:uri-query-params query) params)
    (multiple-value-bind (resp status-code headers) (dex:get (print query))
      (ecase status-code
        (200 (jojo:parse resp))
        (400 (error 'invalid-request :error (getf (jojo:parse resp) :|error|)))
        (403 (error 'rate-limited :reset-time (gethash "X-RateLimit-Reset" headers)))))))


(defparameter +valid-levels+ '("Internship" "Mid Level" "Entry Level" "Senior Level"))

(defun test-jobs (&key (page 1) (descending nil) (company "") (category nil) (level nil) location)
  (let ((query (quri:copy-uri +jobs-endpoint+))
        ;; Create an alist with the simple params
        (params `(("page" . ,page)
                  ("descending" . ,descending)
                  ("api_key" . ,(nest:config :themuse-api-key)))))

    (when (not (emptyp company))
      (push (cons "company" company) params))

    ;; Helper to add mutiple value fields to the request
    (flet ((append-multival-param (field list)
             (dolist (el list)
               (push (cons field el) params))))

      (append-multival-param "category" category)
      (append-multival-param "level" level)
      (append-multival-param "location" location))

    (setf (quri:uri-query-params query) params)
    (multiple-value-bind (resp status-code headers) (dex:get (print query))
      (ecase status-code
        (200 (jojo:parse resp))
        (400 (error 'invalid-request :error (getf (jojo:parse resp) :|error|)))
        (403 (error 'rate-limited :reset-time (gethash "X-RateLimit-Reset" headers)))))))
