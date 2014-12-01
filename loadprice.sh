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

cid=-1
id=0
pid=-1
nrec=0
cat=""
echo "DELETE FROM uw_ts_store;" | psql TS
echo "DELETE FROM uw_ts_category;" | psql TS

SL=`grep -Tn -B 2 руб $FILE | head -n 1 | awk '{print $1}'`
cat $FILE | tail -n +$SL | { IFS=':' ; while read x nm price qty ; do

  nm=`echo $nm | tr -d "\"';"`
  if isprice $price ; then
    if test -n "$cat" ; then
      cid=`expr $cid '+' 1`
      I="INSERT INTO uw_ts_category(uw_id,uw_parentid,uw_cnam) VALUES($cid, $pid, '$cat');"
      echo $I
      cat=""
    fi

    I="INSERT INTO uw_ts_store(uw_id,uw_nam,uw_price,uw_cid) VALUES($id, '$nm', '$price', $cid);"
    echo $I
    id=`expr $id '+' 1`
    nrec=`expr $nrec '+' 1`
  else
    if test -n "$cat" ; then
      cid=`expr $cid '+' 1`
      I="INSERT INTO uw_ts_category(uw_id,uw_parentid,uw_cnam) VALUES($cid, -1, '$cat');"
      pid=$cid
      echo $I
      cat=""
    fi
    cat=$nm
  fi

done; } | psql TS



