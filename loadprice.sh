#!/bin/sh

die() { echo $@ >&2 ; exit 1; }
err() { echo $@ >&2 ; }

FILE=$1

isprice() {
  case $1 in
    *руб*) return 0;;
    *) return 1;;
  esac
}

cid=0
id=0
echo "DELETE FROM uw_ts_store;" | psql TS
echo "DELETE FROM uw_ts_category;" | psql TS

SL=`grep -Tn -B 2 руб $FILE | head -n 1 | awk '{print $1}'`
cat $FILE | tail -n +$SL | { IFS=':' ; while read x nm price qty ; do

  nm=`echo $nm | tr -d "\"';"`
  if isprice $price ; then
    I="INSERT INTO uw_ts_store(uw_id,uw_nam,uw_price,uw_cid) VALUES($id, '$nm', '$price', $cid);"
    echo $I
    id=`expr $id '+' 1`
  else
    I="INSERT INTO uw_ts_category(uw_id,uw_cnam) VALUES($cid, '$nm');"
    echo $I
    cid=`expr $cid '+' 1`
  fi

done; } | psql TS



