## phpmyadmin 基于 nginx1.12.2 php5.6.32 xcache3.2.0 phpMyAdmin4.7.5 源码安装
``` shell
 git clone https://github.com/greatwl/phpmyadmin.git
 cd openvpn/
 docker build -t phpmyadmin ./
```

### 启动
``` shell
docker stop phpmyadmin 
docker rm phpmyadmin 
docker run -d --name  --hostname phpmyadmin --privileged \
  -p 80:80 -p 443:443 \
  -v /data/phpmyadmin/ssl:/etc/nginx/ssl \
  -e MYSQL_HOST="x.x.x.x" \
phpmyadmin
```
