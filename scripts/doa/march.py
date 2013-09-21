# -*- coding: utf-8 -*-
import json
import urllib.request, urllib.parse
import http.client
from urllib.error import URLError, HTTPError
import time
import hashlib
import math
import os

dragon_heart="f8452a2fa102608f0c1ce6945694194a8b30029b"
session_id="c5bd6b5c337642f85738ea21f53c7eac"
user_id=18113601
realm_number=354
c=10
cookie="__utma=113356292.1545172947.1367122147.1371621599.1371659023.37; __utmc=113356292; __utmz=113356292.1371659023.37.37.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; __utma=54346615.1911431419.1367089712.1371666439.1371668529.253; __utmb=54346615.6.10.1371668529; __utmc=54346615; __utmz=54346615.1371668529.253.253.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; dragons=c5bd6b5c337642f85738ea21f53c7eac"
version="overarch"

march_rotation= [["DimensionalRuiner",500], ["WindTroop", 8000], ["WindDragon", 1], ["GreatDragon", 1], ["WaterDragon", 1], ["FireDragon", 1], ["StoneDragon", 1]]
march_type  = "attack"

general_ids = [801618381, 801620343, 801623583, 801623946, 801626446, 801627404, 801632866, 801650744, 801668755]#, 801721004
city_id = 802590281

#mountains
minimum_speed = 325
dragonry = 6
rd = 9

# banshees
# d  : 2.23, 6.32, 8.94, 10.2, 10.0, 5.00, 4.12, 1.00
# d1 : 3, 8, 12, 14, 14, 5, 5, 1
# wd : 35, 46, 52, 56, 55, 42, 40, 32
# wd1: 37, 50, 60, 65, 65, 42, 4, 322
# w  : 36, 45, 51, 54, 54, 42, 40, 33

# battle dragons
# d  : 2.23, 6.32, 8.94, 10.2, 10.0, 5.00, 4.12, 1.00, 72.45
# d1 : 3, 8, 12, 14, 14, 5, 5, 1, 97
#w   : , , , , 73, , 48, 34, 336
#wd  : , , , , 75, 52, 48, 34, 
#wd1 : , , , , 94, 52, 52, 34,

# mountain rotation
#xy_rotation = [[372,74], [375,70], [377, 68], [378, 67], [379, 68], [373, 81], [372, 80], [372, 76]]
# lake rotation 
#xy_rotation = [[372,76], [371, 77], [370, 76], [371,73], [375, 73], [377,72], [376, 76], [373, 78]]
# forest rotation
#xy_rotation = [[371, 76], [371,75], [369,78], [368,83], [376, 69], [377, 69], [376,78], [376,80]]
# hill rotation
#xy_rotation = [[370, 77], [375, 72], [379, 70], [381, 69], [380, 71]]
# plain
# xy_rotation = [[375,77], [369,76], [369,69], [368,80], [367,81], [373,82]]
# Everything
#xy_rotation = [[375,77], [369,76], [369,69], [368,80], [367,81], [373,82], [372,74], [375,70], [377, 68], [378, 67], [379, 68], [373, 81], [372, 80], [372, 76], [372,76], [371, 77], [370, 76], [371,73], [375, 73], [377,72], [376, 76], [373, 78], [375,72], [371, 76], [371,75], [369,78], [368,83], [376, 69], [377, 69], [376,78], [376,80]]
#mountain/lake
xy_rotation = [[372,74], [375,70], [377, 68], [378, 67], [379, 68], [373, 81], [372, 80], [372, 76], [372,76], [371, 77], [370, 76], [371,73], [375, 73], [377,72], [376, 76], [373, 78]]


# Great dragon
# for 405,11 we have 13m13 = 793
# Fire dragon
#  13m + 13
# it seems like all dragons are 13m 13s
# All dragons seem to have a marching speed of 325
#march_x = 372
#march_y = 74
base_x = 373
base_y = 76

# This only calculates small distances correctly (Probably a bug somewhere)
def calc_time( x, y ):
	xd = 0
	if math.fabs(x - base_x) > 375:
		xd = math.fabs(x-base_x)-750
	else:
		xd = x-base_x

	yd = 0
	if math.fabs(y - base_y) > 375:
		yd = math.fabs(y-base_y)-750
	else:
		yd = y-base_y

	d = math.sqrt(yd**2 + xd**2)
	
	d1 = math.fabs(yd) + math.fabs(xd)

	#w1 =  d1/((minimum_speed* (1+(rd+dragonry)*0.05))/6000)+30
	#w1 =  d/((minimum_speed* (1+(float)(rd)*0.05))/6000)+30
	#w2 =  d/((minimum_speed* (1+(float)(rd+dragonry)*0.05))/6000)+30

	#print ("D: %f:%f" % (d, d1) )
	#print("W: %i:%i" % (w1, w2) )
	#print("W: %i" % w2)

	return d/((minimum_speed* (1+(rd+dragonry)*0.05))/6000)+30


def attack(general_id, unit_type, unit_count, march_x, march_y):
	params="march%%5By%%5D=%i&march%%5Bx%%5D=%i&version=%s&march%%5Bgeneral%%5Fid%%5D=%i&dragon%%5Fheart=%s&%%5Fmethod=post&%%5Fsession%%5Fid=%s&timestamp=%i&march%%5Bunits%%5D=%%7B%%22%s%%22%%3A%i%%7D&user%%5Fid=%i&march%%5Bmarch%%5Ftype%%5D=%s" % (march_y, march_x, version, general_id, dragon_heart, session_id, int(time.time()), unit_type, unit_count, user_id, march_type )
#	params="user%%5Fid=%d&%%5Fmethod=post&%%5Fsession%%5Fid=%s&timestamp=%d&version=%s&dragon%%5Fheart=%s" % (user_id, session_id, int(time.time()), version, dragon_heart, unit_type, unit_count, user_id)
	print("%s:%i -> %i:%i" % (unit_type, unit_count, march_x, march_y))
	url="http://%s/api/cities/%d/marches.json" % (realm, city_id)
	cadena= "Draoumculiasis" + params + "LandCrocodile" + url + "Bevar-Asp"
	cadenau=cadena.encode('utf8')
	m=hashlib.sha1(cadenau)
	xs3=m.hexdigest()
	headers= { 'Host': realm , 'Connection': 'keep-alive', 'Content-Length': len(params), 'Origin': 'https://realm354.c10.castle.wonderhill.com', 'x-s3-aws': xs3, 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11', 'content-type': 'application/x-www-form-urlencoded', 'Accept': '*/*', 'Accept-Encoding': 'gzip,deflate,sdch', 'Accept-Language': 'es-ES,es;q=0.8', 'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'DNT': 1, 'Cookie': cookie }
	conn=http.client.HTTPConnection(realm,80)
	conn.request("POST",url,params, headers)
	response=conn.getresponse()
#	print(response.read())

try:
	realm="realm%d.c%d.castle.wonderhill.com" % (realm_number, c)
	
	while True:
		for x,y in xy_rotation:
			wait = calc_time( x, y )
			for idx, val in enumerate(march_rotation):
				attack(general_ids[idx], val[0], val[1], x, y)
				time.sleep(0.5)
			
			print("Wait: %f" % wait)
			time.sleep(wait*2+10)

		os.system("python3 heal.py")
		
except HTTPError as e:
	if e.code == 404:
		pass
	else:
		print(e.code)
except URLError as e:
	pass 
