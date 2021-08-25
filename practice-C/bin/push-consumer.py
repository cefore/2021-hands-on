#!/usr/bin/env python3
from time import sleep

import sys
print (sys.path)

import cefpyco


# Name Prefix  of Data to be cached at the Server
pushDataNameSuffix = "/Current-Temp"
# Network Function Name
functionName = "/_SF_abcdef_"
# Paramter K
pushDataNum = 5  

with cefpyco.create_handle() as handle:

	Name_PushData = "ccnx:" + pushDataNameSuffix 
 
	print("The name of Interest to be received: " + Name_PushData)
	handle.register(Name_PushData)

	#interestName = "ccnx:/CACHE/" + str(pushDataNum) + pushDataNameSuffix 
	interestName = "ccnx:" + functionName + "/" + str(pushDataNum) + pushDataNameSuffix 
	print("Send an Intrest with a name: " + interestName)
	handle.send_interest(interestName, 0)
  
	recvInterestNum = 0 
	while True:
		info = handle.receive()
		if info.is_succeeded and ( info.name == ("ccnx:" + pushDataNameSuffix) ):
			print("Recv Interest: {}".format(info))
			msg = "Current-Temp: 30 degree celsius, chunk=" + str(info.chunk_num) + "\n"
			recvInterestNum += 1
			print("Send Data: " + info.name + " chunk_num=" + str(info.chunk_num))
			handle.send_data(info.name, msg, info.chunk_num, expiry=3600000, cache_time=360000) 
			#handle.send_data(info.name, msg, info.chunk_num) 

		if recvInterestNum == pushDataNum:
			print("PushData Done, num={0}".format(pushDataNum) + " name=[ccnx:" + pushDataNameSuffix +"]")
			break 
