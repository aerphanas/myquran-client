(defsystem "myquran-client"
  :description "get current data from myquran api"
  :version "0.1.0"
  :author "Muhammad Aviv Burhanudin <muhamadaviv14@gmail.com>"
  :license "GPLv3"
  :depends-on (#:cl-json
               #:dexador)
  :components ((:module "src"
               :components ((:file "main")))))
