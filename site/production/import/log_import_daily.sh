#!/bin/sh

DB_HOST=adsdbinstance.cssnnqnalkkp.ap-northeast-1.rds.amazonaws.com
DB_USER=ky
DB_PASSWORD=vntrade168
DB_NAME=lebesgue

S3_BUCKET=event-log-cn
REDSHIFT_URL=log-cn-instance.c2dnshlwndhd.us-east-1.redshift.amazonaws.com
REDSHIFT_USER=ky
REDSHIFT_PORT=5439
REDSHIFT_DB=vlogger

export AWS_ACCESS_KEY_ID="AKIAIJUXL6UGFW5WXADA"
export AWS_SECRET_ACCESS_KEY="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"

date

psql -h ${REDSHIFT_URL} -U ${REDSHIFT_USER} -p ${REDSHIFT_PORT} -d ${REDSHIFT_DB} -f /scripts/redshift_unload_daily.sql
/usr/bin/aws s3 cp --recursive s3://${S3_BUCKET}/unload_daily/ /unload_daily
cd /unload_daily
find . -name "*.bz2" -print -exec bzip2 -d {} \;

# combine files belonging to the same table into one file
cat log_cn_view_daily_* > log_cn_view_daily.data
cat log_cn_click_daily_* > log_cn_click_daily.data

cd /

psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_view_daily(vid, fingerprint, created_at) from '/unload_daily/log_cn_view_daily.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_click_daily(vid, fingerprint, func_name, created_at) from '/unload_daily/log_cn_click_daily.data' CSV";

rm -fr /unload_daily
/usr/bin/aws s3 rm --recursive s3://${S3_BUCKET}/unload_daily/
touch unload_daily.tmp
/usr/bin/aws s3 mv unload.tmp s3://${S3_BUCKET}/unload_daily/

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
