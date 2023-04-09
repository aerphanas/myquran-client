(defpackage #:myquran-client
  (:use :cl))

(ql:quickload :cl-json)
(ql:quickload :dexador)

;; compile time type check
(declaim (type list *today*))
(declaim (ftype (function (string) list) cari-kota))
(declaim (ftype (function (number) list) jadwal-hariini))
(declaim (ftype (function (number) list) jadwal-bulanini))
(declaim (ftype (function (number) list) tafsir))

;; (list day month year)
(defvar *today*
  (let ((times
	  (multiple-value-list
	   (decode-universal-time (get-universal-time)))))
    (list (fourth times)
	  (fifth times)
	  (sixth times))))

;; /sholat/kota/cari/{keyword}
(defun cari-kota (kota)
  "mencari dengan nama kota untuk mengambil id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get
	    (format nil
		    "https://api.myquran.com/v1/sholat/kota/cari/~a"
		    kota)))))
	(cdadr response)))

;; /sholat/jadwal/{idkota}/{tahun}/{bulan}/{tanggal}
(defun jadwal-hariini (id)
  "menampilkan jadwal hari ini dengan id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/sholat/jadwal/~d/~d/~d/~d"
			    id (caddr *today*) (cadr *today*) (car *today*))))))
    (cadddr (cddadr response))))

;; /v1/sholat/jadwal/{idkota}/{tahun}/{bulan}
(defun jadwal-bulanini (id)
  "menampilkan jadwal bulan ini dengan id"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/sholat/jadwal/~d/~d/~d/"
			    id (caddr *today*) (cadr *today*))))))
    (cdr (cadddr (cddadr response)))))

;; /tafsir/quran/kemenag/id/{id}
(defun tafsir (id)
  "menampilkan tafsir yang berasal dari kemenag"
  (let ((response
	  (json:decode-json-from-string
	   (dex:get (format nil "https://api.myquran.com/v1/tafsir/quran/kemenag/id/~d"
			    id)))))
    (cdadr response)))

(in-package #:myquran-client)
