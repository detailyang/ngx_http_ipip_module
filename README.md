[ipip]: https://www.ipip.net/

# ngx_http_ipip_module
![Branch master](https://img.shields.io/badge/branch-master-brightgreen.svg?style=flat-square) [![Build](https://api.travis-ci.org/detailyang/ngx_http_ipip_module.svg)](https://travis-ci.org/detailyang/ngx_http_ipip_module) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/detailyang/ngx_http_ipip_module/master/LICENSE) [![release](https://img.shields.io/github/release/detailyang/ngx_http_ipip_module.svg)](https://github.com/detailyang/ngx_http_ipip_module/releases)


ngx_http_ipip_module is an addon for nginx to [ipip]

Table of Contents
-----------------
* [How-To-Use](#how-to-use)
* [How-To-Autoupdate](#how-to-autoupdate)
* [Requirements](#requirements)
* [Direction](#direction)
* [Contributing](#contributing)
* [Author](#author)
* [License](#license)


How-To-Use
----------------
Set the nginx config for ngx_http_ipip_module as the following:

```bash
http {
    ipip_ip_datx /xx/real_ip.datx;
    ipip_phone_txt /xx/real_phone.txt;

    server {
        listen 1999;

        location / {
                ipip on;
        }
    }
}
```

now you can get the ip info as the following:

```bash
[root@localhost ~]# curl "http://127.0.0.1:1999/ip?ip=8.8.8.8"
{
    "ret":  "ok",
    "data": ["GOOGLE", "GOOGLE", "", "google.com", "level3.com", "", "", "", "", "", "", "*", "*"]
}
```
or you can get the phone info as the following:

```bash
[root@localhost ~]# curl "http://127.0.0.1:1999/phone?phone=13000000101"
{
    "ret":  "ok",
    "data": ["北京", "北京", "中国联通网络"]
}
```

How-To-Autoupdate
----------------

According the check-version api of [ipip], we can check the ip and phone version automaticly. We're recommanded to use crontab to autoupdate as the following:

```bash
1 3 * * * xx flock -n /xx/ipip.lock /path/to/ngx_http_ipip_module/scripts/autoupdate.sh &> /data/logs/ipinfo.log
```

By the way, you must set the private data which is the token on [ipip] to the scripts/var file as the following:

```bash
export IPTOKEN=aaaaaaaaaaaaaaaaaaaaaaaaaaa
export PHONETOKEN=bbbbbbbbbbbbbbbbbbbbbbbbbbbb
export PATH=/opt/nginx/sbin:$PATH
```

Requirements
------------

ngx_http_ipip_module requires the following to run:

 * [nginx](http://nginx.org/) or other version like [openresty](http://openresty.org/)、[tengine](http://tengine.taobao.org/)
 * [ipip] ip datx and phone number txt file

Direction
------------

* ipip_ip_datx: sepcify the ip datx file
Syntax:     ipip_ip_datx /path/to/file
Default:    -
Context:    main

```bash
http {
    ipip_ip_datx /xx/real_ip.datx;
}
```

* ipip_phone_txt: sepcify the phone txt file
Syntax:     ipip_phone_txt /path/to/file
Default:    -
Context:    main

```bash
http {
    ipip_phone_txt /xx/real_phone.txt;
}
```

* ipip: enable the ngx_http_ipip_module
Syntax:     ipip on|false
Default:    -
Context:    loc

```bash
loc {
    ipip on;
}
```

Contributing
------------

To contribute to ngx_http_ipip_module, clone this repo locally and commit your code on a separate branch.


Author
------

> GitHub [@detailyang](https://github.com/detailyang)


License
-------
ngx_http_ipip_module is licensed under the [MIT] license.

[MIT]: https://github.com/detailyang/ybw/blob/master/licenses/MIT
