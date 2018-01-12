#!/usr/bin/env python
from scapy.all import *
import time
import sys
clientlist = []
APMac = sys.argv[1]
APMac = APMac.lower()
packet = 0;
def PacketHandler(p):
	global APMac,clientlist,packet
	packet = packet + 1;
	if (packet > 10000):
		os.system('rm /root/Desktop/JAMMER/client.tmp')
		clientlist = []
		packet = 0
	print len(clientlist)
	if p.haslayer(Dot11):
		if p.addr1 and p.addr2:
			if APMac in [p.addr1,p.addr2]:
				if p.type in [1,2]:
					if ((p.addr1 in clientlist) or (p.addr2 in clientlist)) or noise_filter(p.addr1,p.addr2):
						return
					if APMac == p.addr1:
						clientlist.append(p.addr2)
						append_file(p.addr2)
					elif APMac == p.addr2:
						clientlist.append(p.addr1)
						append_file(p.addr1)
def noise_filter(addr1, addr2):
	ignore = [
        'ff:ff:ff:ff:ff:ff',
        '00:00:00:00:00:00',
        '33:33:00:', '33:33:ff:',
        '01:80:c2:00:00:00',
        '01:00:5e:'
    ]
	for i in ignore:
		if i in addr1 or i in addr2:
			return True

def append_file(text):
	with open('/root/Desktop/JAMMER/client.tmp', 'a') as file:
		file.write(text + "\n")
sniff(iface="mon0",prn = PacketHandler,store=0)
