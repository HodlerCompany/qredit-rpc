
### RPC server implementation to easily connect to Qredit blockchain

# Security Warning
All calls should be made from the server where RPC is running at ( i.e., `localhost` or `127.0.0.1` ). The RPC server should never be publicly accessible. If you wish to access qredit-rpc from a remote address, you can whitelist the address with `--allow <address>`. Addresses allow you to use wildcards, eg. `192.168.1.*` or `10.0.*.*`.

If you do want to allow access from all remotes, start qredit-rpc with the `--allow-remote` commandline switch. This can be dangerous.

# How To Use It
- install Node.JS ( https://nodejs.org/en/download/package-manager/)
- install forever `npm install -g forever`
- install qredit-rpc: `npm install HodlerCompany/qredit-rpc#master`
- start RPC server: `node server.js --port 8000` (default port is 8080)
- start RPC with remote server: `node server.js --port 8000 --allow-remote --allow 123.123.123.123`

## Docker ##
If you would like to run from a docker environment, you will first need to build the container by running:
```
docker build -t qredit-rpc .
```
You will need to run the container with the `--allow-remote` option to allow the host machine to access the container.
```
docker run -d -p 8080:8080 qredit-rpc --allow-remote
```

## Accounts
- Get account balance from address: 
```
$curl -X GET "127.0.0.1:8080/mainnet/account/$ADDRESS"
```

- Create account from passphrase: (params: `passphrase`)
```
$curl -X POST "127.0.0.1:8080/mainnet/account" --data "passphrase=$PASSPHRASE"
```

- Create (or get if already existing) account and encrypt using bip38: (params: `bip38` (password for encrypted WIF), `userid` (to identify a user))
```
$curl -X POST "127.0.0.1:8080/mainnet/account/bip38" --data "bip38=$BIP38&userid=$USERID"
```

- Get backup from userid:
```
$curl -X GET "127.0.0.1:8080/mainnet/account/bip38/$USERID"
```

If you want to create several accounts for one user, you need to use a different userid.

## Transactions
- Get last 50 transactions from address:
```
$curl -X GET "127.0.0.1:8080/mainnet/transactions/$ADDRESS"
```

- Create a transaction:  (params: `recipientId`, `amount` in satoshis, `passphrase`)
```
$curl -X POST "127.0.0.1:8080/mainnet/transaction/" --data "recipientId=$RECIPIENTID&amount=$AMOUNT$passphrase=$PASSPHRASE"
```

- Create a transaction using `bip38` for `userid`: (params: `recipientId`, `amount` in satoshis, `bip38` (password to encode wif), `userid`)
```
$curl -X POST "127.0.0.1:8080/mainnet/transaction/bip38" --data "recipientId=$RECIPIENTID&amount=$AMOUNT$bip38=$BIP38$userid=USERID"
```

- Broadcast transaction: (params: `id` of the transaction)
```
$curl -X POST "127.0.0.1:8080/mainnet/broadcast" --data "id=$ID"
```

Note that if the transaction has been created via the RPC it has been stored internally, as such only the transaction `id` is needed to broadcast/rebroadcast it. Otherwise if created outside of this RPC server, pass the whole transaction body as the POST payload.

## Security

If you discover a security vulnerability within this project, please send an e-mail to nayiem@qredit.io. All security vulnerabilities will be promptly addressed.

## License

The MIT License (MIT)

## Thanks

Special thanks to the ARK team.
