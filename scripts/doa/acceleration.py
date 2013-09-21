import json
import urllib.request, urllib.parse
import http.client
from urllib.error import URLError, HTTPError
import time
import hashlib



dragon_heart="f8452a2fa102608f0c1ce6945694194a8b30029b"
session_id="c5bd6b5c337642f85738ea21f53c7eac"
#session_id="c5bd6b5c337642f85738ea21f53c7eac"
user_id=18113601
realm_number=354
c=10
cookie="__utma=113356292.1545172947.1367122147.1371621599.1371659023.37; __utmc=113356292; __utmz=113356292.1371659023.37.37.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; __utma=54346615.1911431419.1367089712.1371666439.1371668529.253; __utmb=54346615.6.10.1371668529; __utmc=54346615; __utmz=54346615.1371668529.253.253.utmcsr=castle.wonderhill.com|utmccn=(referral)|utmcmd=referral|utmcct=/platforms/kabam; dragons=c5bd6b5c337642f85738ea21f53c7eac"
version="overarch"

job_id=3232283106
item="DarkTestroniusPowder"
#Item names:
#Blink, Hop, Skip, Jump, Leap, Bounce, Bore, Bolt, Blast, Blitz, ForcedMarchDrops, TestroniusPowder, DarkTestroniusPowder, TranceMarchDrops, TestroniusDeluxe, TestroniusInfusion
#1m,5m, 15m,1h,   2'5h, 8h,15h, 24h,   60h,96h, 25%,30%,30%50%,50%,99%
#You can use any item on any job (research, building or training)
#Puedes usar cualquier item en cualquier trabajo (investigacion, construir o entrenar)
#This script it's freely available here http://www.youtube.com/watch?v=wpPKIpLJlhA if someone has sold it to you, you were scammed - Atomsk
#Este script est
try:
    realm="realm%d.c%d.castle.wonderhill.com" % (realm_number, c)
    params="%%5Fmethod=delete&%%5Fsession%%5Fid=%s&timestamp=%d&version=%s&job%%5Fid=%d&dragon%%5Fheart=%s&user%%5Fid=%d" % (session_id, int(time.time()), version, job_id, dragon_heart, user_id )
    url="http://%s/api/player_items/%s.json" % (realm, item)
    cadena= "Draoumculiasis" + params + "LandCrocodile" + url + "Bevar-Asp" 
    cadenau=cadena.encode('utf8')
    m=hashlib.sha1(cadenau)
    xs3=m.hexdigest()
    headers= { 'Host': realm , 'Connection': 'keep-alive', 'Content-Length': len(params), 'Origin': 'http://castlemania-production.s3.amazonaws.com', 'x-s3-aws': xs3, 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11', 'content-type': 'application/x-www-form-urlencoded', 'Accept': '*/*', 'Accept-Encoding': 'gzip,deflate,sdch', 'Accept-Language': 'es-ES,es;q=0.8', 'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3', 'DNT': 1, 'Cookie': cookie }
    conn=http.client.HTTPConnection(realm,80)
    conn.request("POST",url,params, headers)
    response=conn.getresponse()
    print(response.read())
    
except HTTPError as e:
    if e.code == 404:
        pass
    else:
        print(e.code)
except URLError as e:
    pass 
