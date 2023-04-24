#!/usr/bin/env python3

# Kraken Rest API
#
# Usage: ./krakenapi.py endpoint [parameters] [-pretty]
# Example: ./krakenapi.py Time
# Example: ./krakenapi.py OHLC pair=xbtusd interval=1440 -pretty
# Example: ./krakenapi.py Balance
# Example: ./krakenapi.py TradeBalance asset=xdg -pretty
# Example: ./krakenapi.py OpenPositions -pretty
# Example: ./krakenapi.py AddOrder pair=xxbtzusd type=buy ordertype=market volume=0.003 leverage=5

import sys
import time
import base64
import hashlib
import hmac
import urllib.request
import json
import os

api_public = {"Time", "Assets", "AssetPairs", "Ticker", "OHLC", "Depth", "Trades", "Spread", "SystemStatus"}
api_private = {"Balance", "BalanceEx", "TradeBalance", "OpenOrders", "ClosedOrders", "QueryOrders", "TradesHistory", "QueryTrades", "OpenPositions", "Ledgers", "QueryLedgers", "TradeVolume", "AddExport", "ExportStatus", "RetrieveExport", "RemoveExport", "GetWebSocketsToken"}
api_trading = {"AddOrder", "AddOrderBatch", "EditOrder", "CancelOrder", "CancelAll", "CancelAllOrdersAfter"}
api_funding = {"DepositMethods", "DepositAddresses", "DepositStatus", "WithdrawInfo", "Withdraw", "WithdrawStatus", "WithdrawCancel", "WalletTransfer"}
api_staking = {"Staking/Assets", "Stake", "Unstake", "Staking/Pending", "Staking/Transactions"}

api_domain = "https://api.kraken.com"
api_data = ""

output_format = 0

if len(sys.argv) < 2:
	api_method = "Time"
elif len(sys.argv) == 2:
	api_method = sys.argv[1]
else:
	api_method = sys.argv[1]
	for count in range(2, len(sys.argv)):
		if sys.argv[count] == '-pretty':
			output_format = 1
			continue
		if count == 2:
			api_data = sys.argv[count]
		else:
			api_data = api_data + "&" + sys.argv[count]

if api_method in api_private or api_method in api_trading or api_method in api_funding or api_method in api_staking:
	api_path = "/0/private/"
	api_nonce = str(int(time.time()*1000))
	try:
		api_key = open(os.path.expanduser('~') + "/.config/kraken/public.key").read().strip()
		api_secret = base64.b64decode(open(os.path.expanduser('~') + "/.config/kraken/private.key").read().strip())
	except:
		print("API public key and API private (secret) key must be in plain text files called API_Public_Key and API_Private_Key")
		sys.exit(1)
	api_postdata = api_data + "&nonce=" + api_nonce
	api_postdata = api_postdata.encode('utf-8')
	api_sha256 = hashlib.sha256(api_nonce.encode('utf-8') + api_postdata).digest()
	api_hmacsha512 = hmac.new(api_secret, api_path.encode('utf-8') + api_method.encode('utf-8') + api_sha256, hashlib.sha512)
	api_request = urllib.request.Request(api_domain + api_path + api_method, api_postdata)
	api_request.add_header("API-Key", api_key)
	api_request.add_header("API-Sign", base64.b64encode(api_hmacsha512.digest()))
	api_request.add_header("User-Agent", "Kraken REST API")
elif api_method in api_public:
	api_path = "/0/public/"
	api_request = urllib.request.Request(api_domain + api_path + api_method + '?' + api_data)
	api_request.add_header("User-Agent", "Kraken REST API")
else:
	print("Usage: %s method [parameters]" % sys.argv[0])
	print("Example: %s OHLC pair=xbtusd interval=1440" % sys.argv[0])
	sys.exit(1)

try:
	api_reply = urllib.request.urlopen(api_request).read()
except Exception as error:
	print("API call failed (%s)" % error)
	sys.exit(1)

try:
	api_reply = api_reply.decode()
except Exception as error:
	if api_method == 'RetrieveExport':
		sys.stdout.buffer.write(api_reply)
		sys.exit(0)
	print("API response invalid (%s)" % error)
	sys.exit(1)

if '"error":[]' in api_reply:
	print(api_reply if output_format == 0 else json.dumps(json.loads(api_reply), indent = 4))
	sys.exit(0)
else:
	print(api_reply if output_format == 0 else json.dumps(json.loads(api_reply), indent = 4))
	sys.exit(1)
