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

psql -h ${REDSHIFT_URL} -U ${REDSHIFT_USER} -p ${REDSHIFT_PORT} -d ${REDSHIFT_DB} -f /scripts/redshift_unload.sql
/usr/bin/aws s3 cp --recursive s3://${S3_BUCKET}/unload/ /unload
cd /unload
find . -name "*.bz2" -print -exec bzip2 -d {} \;

# combine files belonging to the same table into one file
cat log_cn_view_* > log_cn_view.data
cat log_cn_viewed_* > log_cn_viewed.data
cat log_cn_maxviewtime_* > log_cn_maxviewtime.data
cat log_cn_click_* > log_cn_click.data
cat log_cn_region_* > log_cn_region.data
cat log_cn_city_* > log_cn_city.data
cat log_cn_browser_* > log_cn_browser.data
cat log_cn_device_* > log_cn_device.data

cd /

# import to target db
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_view(vid, view_count, created_at) FROM '/unload/log_cn_view.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_viewed(vid, view_count, created_at) FROM '/unload/log_cn_viewed.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_maxviewtime(vid, watch_hash, max, created_at) FROM '/unload/log_cn_maxviewtime.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_click(vid, func_name, click_time, created_at) FROM '/unload/log_cn_click.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_region(vid, region, region_count, created_at) FROM
'/unload/log_cn_region.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_city(vid, city, city_count, created_at) FROM
'/unload/log_cn_city.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_browser(vid, ie, wechat, chrome, safari, opera, firefox, all_browsers, created_at) FROM
'/unload/log_cn_browser.data' CSV";
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "\copy log_device(vid, iphone, ipad, tablet, mobile, desktop, created_at) FROM
'/unload/log_cn_device.data' CSV";

rm -fr /unload
/usr/bin/aws s3 rm --recursive s3://${S3_BUCKET}/unload/
touch unload.tmp
/usr/bin/aws s3 mv unload.tmp s3://${S3_BUCKET}/unload/

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
