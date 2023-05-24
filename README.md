# my quran client

my quran client api

in order to use this library you need sbcl and asdf installed and configured properly

## how to use
- download/clone this repo
- copy folder to `~/common-lisp`
- load libraries with `(require "myquran-client")` or `(ql:quickload "myquran-client")`

## function
- cari-kota: string -> list
- jadwal-hariini: number -> list
- jadwal-bulanini: number -> list
- tafsir: number -> list

## thanks to
- [myquran api](https://api.myquran.com/)
