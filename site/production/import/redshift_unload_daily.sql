--- 不重複：每個 fingerprint 的一天只能算一次

--- 每日不重複觀看次數（每天撈一次）
unload ('
    select vid, fingerprint, c_time::date as view_date
    from log_cn
    where datatype = \'view\'
        and watch_hash != \'\'
        and is_init = true
        and fingerprint is not null and fingerprint != \'\'
        and c_time between date_trunc(\'day\', current_timestamp - interval \'1 day\') and date_trunc(\'day\', current_timestamp)
    group by vid, fingerprint, view_date
    ')
to 's3://event-log-cn/unload_daily/log_cn_view_daily_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;

--- 每日不重複按鈕點擊次數
unload('
select vid, fingerprint, func_name, c_time::date as view_date
from log_cn
where datatype = \'click\'
    and watch_hash != \'\'
    and fingerprint is not null and fingerprint != \'\'
    and func_name is not null and func_name != \'\'
    and c_time between date_trunc(\'day\', current_timestamp - interval \'1 day\') and date_trunc(\'day\', current_timestamp)
group by vid, fingerprint, func_name, view_date') to 's3://event-log-cn/unload_daily/log_cn_click_daily_' delimiter ',' credentials 'aws_access_key_id=AKIAIJUXL6UGFW5WXADA;aws_secret_access_key=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' bzip2;
