# -*- coding: utf-8 -*-
import json
import urllib.request, urllib.parse
import http.client
from urllib.error import URLError, HTTPError
import time
import hashlib


dragon_heart="f8452a2fa102608f0c1ce6945694194a8b30029b"
session_id="c5bd6b5c337642f85738ea21f53c7eac"
user_id=18113601
realm_number=354
c=10
cookie="__utma=113356292.1545172947.1367122147.1371621599.1371659023.37; __utmc=113356292; __utmz=113356292.1371659023.37.37.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; __utma=54346615.1911431419.1367089712.1371666439.1371668529.253; __utmb=54346615.6.10.1371668529; __utmc=54346615; __utmz=54346615.1371668529.253.253.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; dragons=c5bd6b5c337642f85738ea21f53c7eac"
version="overarch"

#city_id=802590281
#city_id=802636446 #wind
#city_id=802663283
city_id =0
city_ids=[802663283]
#city_ids=[802722103]
city_ids=[802663283, 802636446, 802590281, 802623127, 802630489, 802626214]
option="dragon" #outpost, dragon

def heal():
	job_id=0
	params="user%%5Fid=%d&%%5Fmethod=post&%%5Fsession%%5Fid=%s&timestamp=%d&version=%s&dragon%%5Fheart=%s" % (user_id, session_id, int(time.time()), version, dragon_heart)
	url="http://%s/api/cities/%d.json" % (realm, city_id)
	cadena= "Draoumculiasis" + params + "LandCrocodile" + url + "Bevar-Asp"
	cadenau=cadena.encode('utf8')
	m=hashlib.sha1(cadenau)
	xs3=m.hexdigest()
	headers= { 'Host': realm , 'Connection': 'keep-alive', 'Content-Length': len(params), 'Origin': 'http://castlemania-production.s3.amazonaws.com', 'x-s3-aws': xs3, 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11', 'content-type': 'application/x-www-form-urlencoded', 'Accept': '*/*', 'Accept-Encoding': 'gzip,deflate,sdch', 'Accept-Language': 'es-ES,es;q=0.8', 'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'DNT': 1, 'Cookie': cookie }
	conn=http.client.HTTPConnection(realm,80)
	conn.request("POST",url,params, headers)
	response=conn.getresponse()
	h=json.loads(response.read().decode('utf8'))
	jobs=h["city"]["jobs"]
	for x in jobs:
		if x["queue"]==option:
			job_id=x["id"]
		
	params="user%%5Fid=%d&%%5Fmethod=delete&%%5Fsession%%5Fid=%s&timestamp=%d&version=%s&job%%5Bid%%5D=%d&dragon%%5Fheart=%s" % (user_id, session_id, int(time.time()), version, job_id, dragon_heart)
	url="http://%s/api/jobs/%d.json" % (realm,job_id)
	cadena= "Draoumculiasis" + params + "LandCrocodile" + url + "Bevar-Asp"
	cadenau=cadena.encode('utf8')
	m=hashlib.sha1(cadenau)
	xs3=m.hexdigest()
	headers= { 'Host': realm , 'Connection': 'keep-alive', 'Content-Length': len(params), 'Origin': 'http://castlemania-production.s3.amazonaws.com', 'x-s3-aws': xs3, 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11', 'content-type': 'application/x-www-form-urlencoded', 'Accept': '*/*', 'Accept-Encoding': 'gzip,deflate,sdch', 'Accept-Language': 'es-ES,es;q=0.8', 'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'DNT': 1, 'Cookie': cookie }
	conn=http.client.HTTPConnection(realm,80)
	conn.request("POST",url,params, headers)
	response=conn.getresponse()		



try:
	realm="realm%d.c%d.castle.wonderhill.com" % (realm_number, c)
	for _id in city_ids:
		print(_id)
		city_id = _id
		heal()

		
		
except HTTPError as e:
	if e.code == 404:
		pass
	else:
		print(e.code)
except URLError as e:
	pass 
