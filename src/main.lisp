(defpackage #:myquran-client
  (:use :cl))

;; use C ~  for slime
(in-package #:myquran-client)

(ql:quickload :cl-json) ;; json parser
(ql:quickload :dexador) ;; https client

;; (list day month year)
(defvar *today*
  (let ((times
	  (multiple-value-list
	   (decode-universal-time (get-universal-time)))))
    (list (fourth times)
	  (fifth times)
	  (sixth times))))

(defun cari-kota (kota)
  "mencari kota yang diberikan oleh api my quran"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get
	    (format nil "https://api.myquran.com/v1/sholat/kota/cari/~a" kota)))))
	(cdadr response)))

