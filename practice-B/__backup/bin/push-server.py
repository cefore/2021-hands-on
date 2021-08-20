#!/usr/bin/env python3
import re
import cefpyco


# Network Function Name
functionName = "/_SF_abcdef_"

with cefpyco.create_handle() as handle:
	
	# Interest Name Prefix for Cache Function
	interestNamePrefix = "ccnx:" + functionName
	print("Interest Name Prefix for Cache Function: " + interestNamePrefix)
	handle.register(interestNamePrefix)
	while True: 
		info = handle.receive()
		#if info.is_succeeded and ("ccnx:/CACHE" in info.name) and (info.chunk_num == 0):
		if info.is_succeeded and (interestNamePrefix in info.name) and (info.chunk_num == 0):
			print("Receive: {}".format(info));
			chunkNum = re.findall(interestNamePrefix + "/(.*?)/", info.name)
			namePrefix = re.findall(interestNamePrefix + "/.*?(/.*)", info.name)  
			#chunkNum = re.findall("ccnx:/CACHE/(.*?)/", info.name)
			#namePrefix = re.findall("ccnx:/CACHE/.*?(/.*)", info.name)  
     
			print("chunkNum:" + chunkNum[0])  
			print("namePrefix:" + namePrefix[0])  

			interestName = "ccnx:" + namePrefix[0]
			for i in range( int(chunkNum[0]) ):
				print("Send Interest: name: " + interestName + " chunk=" + str(i)) 
				handle.send_interest(interestName, i)  

			dataRecvNum = 0
			while True:
				tmpinfo = handle.receive()
				if info.is_succeeded and (tmpinfo.name == interestName):
					print(tmpinfo)
					dataRecvNum+=1

				if(dataRecvNum == int(chunkNum[0])):
					print("Receive all Data to be cached (" + str(dataRecvNum) + ") name: " + interestName)
					break
   
