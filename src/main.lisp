(defpackage #:myquran-client
  (:use :cl)
  (:export #:cari-kota
	   #:jadwal-hariini
	   #:jadwal-bulanini
	   #:tafsir))

(in-package #:myquran-client)

;; (list day month year)
(declaim (type list *today*))
(defvar *today*
  (let ((times
	  (multiple-value-list
	   (decode-universal-time (get-universal-time)))))
    (list (fourth times)
	  (fifth times)
	  (sixth times))))

(declaim (ftype (function (string) list) cari-kota))
(defun cari-kota (kota)
  "mencari dengan nama kota untuk mengambil id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get
	    (format nil
		    "https://api.myquran.com/v1/sholat/kota/cari/~a"
		    kota)))))
	(cdadr response)))

(declaim (ftype (function (number) list) jadwal-hariini))
(defun jadwal-hariini (id)
  "menampilkan jadwal hari ini dengan id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/sholat/jadwal/~d/~d/~d/~d"
			    id (caddr *today*) (cadr *today*) (car *today*))))))
    (cadddr (cddadr response))))

(declaim (ftype (function (number) list) jadwal-bulanini))
(defun jadwal-bulanini (id)
  "menampilkan jadwal bulan ini dengan id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/sholat/jadwal/~d/~d/~d/"
			    id (caddr *today*) (cadr *today*))))))
    (cdr (cadddr (cddadr response)))))

(declaim (ftype (function (number) list) tafsir))
(defun tafsir (id)
  "menampilkan tafsir yang berasal dari kemenag"
  (let ((response
          (json:decode-json-from-string
           (dex:get (format nil "https://api.myquran.com/v1/tafsir/quran/kemenag/id/~d"
                            id)))))
    (cdadr response)))

