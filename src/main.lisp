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
  "mencari dengan nama kota untuk mengambil id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get
	    (format nil
		    "https://api.myquran.com/v1/sholat/kota/cari/~a"
		    kota)))))
	(cdadr response)))

;; /{idkota}/{tahun}/{bulan}/{tanggal}
(defun jadwal-hariini (id)
  "menampilkan jadwal hari ini dengan id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/sholat/jadwal/~d/~d/~d/~d"
			    id (caddr *today*) (cadr *today*) (car *today*))))))
    (cadddr (cddadr response))))
