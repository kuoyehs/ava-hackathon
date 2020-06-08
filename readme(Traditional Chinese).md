# 安裝 gecko
AVA Client
https://github.com/ava-labs/gecko
```
$ brew install openssl libuv cmake make curl gcc
$ brew install go
```
查看GOPATH目錄，接下來go相關的檔案會放在GOPATH
```
$ go env
$ go get -v -d github.com/ava-labs/gecko/
$ cd go/src/github.com/ava-labs/gecko
$ ./scripts/build.sh
$ ./build/ava --public-ip=127.0.0.1 --snow-sample-size=1 --snow-quorum-size=1 --staking-tls-enabled=false --network-id=local
```

# 安裝 faucet
安裝 faucet 是為了獲得測試的 AVA token
https://github.com/ava-labs/ava-faucet
```
$ git clone https://github.com/ava-labs/faucet-site.git
$ cd faucet-site
$ nvm use 12.14.1
$ npm i
```
複製.env.example到.env
.env內容
```
AVA_IP=localhost
AVA_PORT=9650
AVA_PROTOCOL=http
AVA_NETWORK_ID=12345
AVA_CHAIN_ID=X

CAPTCHA_SECRET=
VUE_APP_CAPTCHA_SITE_KEY=

ASSET_ID=AVA

PRIVATE_KEY_X=ewoqjP7PxY4yr3iLTpLisriqt94hdyDFNgchSxGGztUrTXtNN
PRIVATE_KEY_C=0xabd71b35d559563fea757f0f5edbde286fb8c043105b15abb7cd57189306d7d1

DROP_SIZE_X=20000
DROP_SIZE_C=200000000000000000
```
CAPTCHA_SECRET 和 VUE_APP_CAPTCHA_SITE_KEY 需要去 https://www.google.com/recaptcha/intro/v3.html 向google
申請並取得相關 key
```
$ npm run serve
```

# 安裝此專案
```
$ docker-compose --project-directory . -f docker/dev/docker-compose.yaml up -d
$ sudo vi /etc/hosts
在 127.0.0.1 行末加入 ava.localhost
```
複製.env.example到.env
GECKO_HOST 是 AVA Client 的 IP
