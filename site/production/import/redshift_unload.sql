--- 影片被觀看次數 view
unload ('
    select vid, count(1) as view_count, date_trunc(\'hour\', c_time) as view_date
    from log_cn
    where datatype = \'view\'
        and watch_hash != \'\'
        and is_init = true
        and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp)
    group by vid, view_date order by vid, view_date
    ')
to 's3://event-log-cn/unload/log_cn_view_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 影片有效觀看次數 viewed
unload ('
    select vid, count(1) as viewed_count, date_trunc(\'hour\', c_time) as view_date
    from log_cn
    where datatype = \'view\'
        and watch_hash != \'\'
        and is_init = true
        and viewed = true
        and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp)
    group by vid, view_date order by vid, view_date
    ')
to 's3://event-log-cn/unload/log_cn_viewed_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 影片最長觀看時間 maxviewtime
unload('
    select vid, watch_hash, max(max_v_time) as max, date_trunc(\'hour\', c_time) as view_date from log_cn where datatype = \'view\' and watch_hash != \'\' and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) group by vid, watch_hash, view_date order by vid, watch_hash, view_date
    ')
to 's3://event-log-cn/unload/log_cn_maxviewtime_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 按鈕點擊 click
unload('
select vid, func_name, v_time as click_time, date_trunc(\'hour\', c_time) as view_date from log_cn where datatype = \'click\' and watch_hash != \'\' and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (func_name is not null and func_name != \'\')') to 's3://event-log-cn/unload/log_cn_click_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 地區 region
unload('
    select vid, country as region, count(1) as region_count, date_trunc(\'hour\', c_time) as view_date from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) group by vid, region, view_date order by vid, region, view_date
') to 's3://event-log-cn/unload/log_cn_region_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 城市 city
unload('
    select vid, city, count(1) as city_count, date_trunc(\'hour\', c_time) as view_date from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) group by vid, city, view_date order by vid, city, view_date;
') to 's3://event-log-cn/unload/log_cn_city_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 瀏覽器 browser
unload('
    select distinct a.vid, b.ie, c.wechat, d.chrome, e.safari, f.opera, g.firefox, h.all_browsers, date_trunc(\'hour\', current_timestamp) as count_time
    from log_cn a
    left join (
        select vid, count(1) as ie from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (user_agent like (\'%MSIE%\') or user_agent like (\'%Trident%\'))  group by vid
    ) b on a.vid = b.vid
    left join (
        select vid, count(1) as wechat from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and user_agent like (\'%MicroMessenger%\') group by vid
    ) c on a.vid = c.vid
    left join (
        select vid, count(1) as chrome from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and user_agent like (\'%Chrome%\') and user_agent not like (\'%MicroMessenger%\') group by vid
    ) d on a.vid = d.vid
    left join (
        select vid, count(1) as safari from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (user_agent like (\'%Safari%\') and user_agent not like (\'%MicroMessenger%\') and user_agent not like (\'%Chrome%\') and user_agent not like (\'%Line%\')) group by vid
    ) e on a.vid = e.vid
    left join (
        select vid, count(1) as opera from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (user_agent like (\'%Opera%\') and user_agent not like(\'%Firefox%\')) group by vid
    ) f on a.vid = f.vid
    left join (
        select vid, count(1) as firefox from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and ((user_agent like (\'%Firefox%\') or user_agent like (\'%FxiOS%\')) and user_agent not like(\'%Opera%\')) group by vid
    ) g on a.vid = g.vid
    left join (
        select vid, count(1) as all_browsers from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and user_agent is not null and user_agent != \'\' group by vid
    ) h on a.vid = h.vid
') to 's3://event-log-cn/unload/log_cn_browser_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 裝置 device
unload('
select distinct a.vid, b.iphone, c.ipad, d.tablet, e.mobile, f.desktop, date_trunc(\'hour\', current_timestamp) as count_time
from log_cn a
left join (
    select vid, count(1) as iphone from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (user_agent like (\'%iPhone%\') or user_agent like (\'%CriOS%\')) group by vid
) b on a.vid = b.vid
left join (
    select vid, count(1) as ipad from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and  user_agent like (\'%iPad%\') group by vid
) c on a.vid = c.vid
left join (
    select vid, count(1) as tablet from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and (user_agent like (\'%Tablet%\') or (user_agent not like (\'%Windows%\') and user_agent not like (\'%Macintosh%\') and user_agent not like (\'%Linux%\') and user_agent not like (\'%iPhone%\') and user_agent not like (\'%iPad%\'))) group by vid
) d on a.vid = d.vid
left join (
    select vid, count(1) as mobile from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and user_agent like
    (\'%Mobile%\') and user_agent not like (\'%iPhone%\') and user_agent not like (\'%iPad%\') group by vid
) e on a.vid = e.vid
left join (
    select vid, count(1) as desktop from log_cn where datatype = \'view\' and is_init = true and c_time between date_trunc(\'hour\', current_timestamp - interval \'1 hour\') and date_trunc(\'hour\', current_timestamp) and ((user_agent like (\'%Windows%\') or user_agent like (\'%Macintosh%\') or user_agent like (\'%Linux%\')) and user_agent not like (\'%Android%\')) group by vid
) f on a.vid = f.vid
') to 's3://event-log-cn/unload/log_cn_device_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;
