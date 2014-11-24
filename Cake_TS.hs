module Cake_TS where

import Development.Cake3
import Development.Cake3.Ext.UrWeb as UW
import qualified Cake_Bootstrap as Bootstrap hiding(main)
import qualified Cake_Prelude as Prelude hiding(main)
import qualified Cake_MonadPack as MonadPack hiding(main)
import Cake_TS_P

-- instance IsString File where fromString = file

project = do

  let pn = file "TS.urp"

  p <- Prelude.thelib
  b <- Bootstrap.lib
  m <- MonadPack.lib

  a <- uwapp "-dbms postgres" pn $ do
    allow mime "text/javascript";
    allow mime "text/css";
    allow mime "image/jpeg";
    allow mime "image/png";
    allow mime "image/gif";
    allow mime "application/octet-stream";
    allow url "/TS/*"
    allow url "http://github.com*"
    allow url "http://impredicative.com*"
    allow url "http://hit.msk.ru*"
    debug
    library b
    library m
    library p
    sql (pn.="sql")
    database ("dbname="++(takeBaseName pn))
    rewrite UW.all "TS/main"
    ur (sys "list")
    ur (sys "option")
    ur (sys "string")
    ur (single $ file "StyleSoup.ur")
    ur (single $ file "XmlGen.ur")
    ur (pair $ file "TS.ur")

  db <- rule $ do
    let sql = urpSql (toUrp a)
    let dbn = takeBaseName sql
    shell [cmd|dropdb --if-exists $(string dbn)|]
    shell [cmd|createdb $(string dbn)|]
    shell [cmd|psql -f $(sql) $(string dbn)|]
    shell [cmd|touch @(sql.="db")|]

  rule $ do
    phony "dropdb"
    depend db

  rule $ do
    phony "all"
    depend db
    depend a

main = do
  writeMake (file "Makefile") (project)
