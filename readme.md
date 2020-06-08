# A link to a Youtube video of a short presentation about the project and demonstrating it.

https://www.youtube.com/watch?v=0VGi6Z9-eM4

#Short description of the project

This app allows you to generate the address of the AVA network, and you can use this address to get the AVA token from the AVA faucet. This address can also create your own assets, and you can also send your own assets to others.

1. Create User：Create a new user with username and password

2. Create Address：Create an address that using username and password

3. AVA Faucet：Obtain test AVA

4. Balance AVA：Inquire how many AVA

5. Send AVA：Give AVA to others

6. Create Asset：Create your own assets

7. Balance Asset：Check your own assets

8. Send Asset：Give your own assets to others


# Install gecko
AVA Client
https://github.com/ava-labs/gecko
```
$ brew install openssl libuv cmake make curl gcc
$ brew install go
```
Check the GOPATH directory, then gecko will be placed in GOPATH
```
$ go env
$ go get -v -d github.com/ava-labs/gecko/
$ cd go/src/github.com/ava-labs/gecko
$ ./scripts/build.sh
$ ./build/ava --public-ip=127.0.0.1 --snow-sample-size=1 --snow-quorum-size=1 --staking-tls-enabled=false --network-id=local
```

# Install faucet
The faucet is installed to obtain the tested AVA token
https://github.com/ava-labs/ava-faucet
```
$ git clone https://github.com/ava-labs/faucet-site.git
$ cd faucet-site
$ nvm use 12.14.1
$ npm i
```
copy .env.example to .env
.env
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
CAPTCHA_SECRET and VUE_APP_CAPTCHA_SITE_KEY need to go to https://www.google.com/recaptcha/intro/v3.html and apply relevant key from Google
```
$ npm run serve
```

# Install this project
```
$ docker-compose --project-directory . -f docker/dev/docker-compose.yaml up -d
$ sudo vi /etc/hosts
Add ava.localhost at the end of line 127.0.0.1
```
copy .env.example to .env
GECKO_HOST is AVA Client IP


