module Cake_TS where

import Development.Cake3
import Development.Cake3.Ext.UrWeb as UW
import qualified Cake_Bootstrap as Bootstrap hiding(main)
import qualified Cake_Prelude as Prelude hiding(main)
import qualified Cake_MonadPack as MonadPack hiding(main)
import qualified Cake_UTF8 as UTF8 hiding(main)
import Cake_TS_P

(app,db) = uwapp_postgres (file "TS.urp") $ do
  library Prelude.lib
  library Bootstrap.lib
  library MonadPack.lib
  library UTF8.lib
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
  rewrite UW.all "TS/main"
  css (file "TS.css")
  ur (sys "list")
  ur (sys "option")
  ur (sys "string")
  ur (sys "char")
  ur (file "StyleSoup.ur")
  ur (file "XmlGen.ur")
  ur (file "TS.ur", file "TS.urs")

main = writeDefaultMakefiles $ do
  rule $ do
    phony "dropdb"
    depend db
  rule $ do
    phony "run"
    shell [cmd|$app|]
  rule $ do
    phony "all"
    depend app
