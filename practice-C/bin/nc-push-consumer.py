import cefpyco
import time
import sys
import subprocess
import click

FuncInterest_NamePrefix = "ccnx:/_SF_/_CS.STORE_"

args = sys.argv
if len(sys.argv) < 3:
	print ("Usage: $python ./program [INPUTFILE] [UNIQUE-ID]")
	print ("\t[INPUTFILE]: a name of file composed of data to push into a server")
	print ("\t[UNIQUE-ID]: Unique-ID used for the name of interest a server sends toward this client")
	sys.exit()	
	

inputfile = args[1]
unique_id = args[2]
print("Inputfile for PUSH: [", inputfile + " ]")
print("Unique_id (Your Myouji): [", unique_id + " ]")

## Read a file to be pushed into a Push-Server
dataCoded=[]
cob_count=0
with open(inputfile, "rb") as fcoded:
	line = fcoded.read()
	cob_len = 1024
	data_len = len(line)
	cob_count = ((data_len -1) // cob_len) + 1
	print ("Total Chunk-Num of ", inputfile, ": [", cob_count, "]")
	for c in range(cob_count):
		offset = c * cob_len;
		dataCoded.insert(c, line[offset:offset + cob_len]);

with cefpyco.create_handle() as handle:

	UniqueId = "_uid." + unique_id + "_"
	smiName = "ccnx:/" + UniqueId
	
	# to receiver Interests from a Server
	print ("Set the name of Interest to be receive from a Push-Server: " + "[ " + smiName + " ]")
	handle.register(smiName)

	## Send PUSH-Request to a Server by a regular interest (RGI)
	now_chunkNum = 0
	namePrefix = FuncInterest_NamePrefix + "/_K." + str(cob_count) + "/" + UniqueId 	

	if(1):
		# symbolic_f = 1 --> Regular Interest	
		print ("Send Function Request Interest: [ " + namePrefix + " (chunkNum=0) ]")
		handle.send_interest(namePrefix, now_chunkNum, symbolic_f = 1)
	
	print ("Now waiting for interests from a Push-Server, " + smiName)

	sendDataFlag=[] # e.g.) data(chunkNum=1) is sent, sendDataFlag[1] is set to 1
	sendDataNum=0
	for c in range(cob_count):
		sendDataFlag.insert(c, 0)
	
	while True:

		info = handle.receive(timeout_ms=4000)

		if info.is_succeeded:
			tp_mode = None
			if(info.chunk_num is None):
				print ("SUCCESS: Receive an SMI from the Push-Server")
				print ("\t", info)
				tp_mode = "smi"
			else:		
				print ("SUCCESS: Receive an Interest from the Push-Server:")
				print ("\tRecv-Interest-Name: [", info.name, " ( #chunk:", info.chunk_num, ") ]") 
				tp_mode = "rgi"

			if(tp_mode == "smi"):
				try:
					cefput_cmd = "cefputfile ccnx:/" + UniqueId + " -f ./" + inputfile + " -e 3600 -t 3600 -r 20"
					print ("Exec: " + cefput_cmd)
					res_cefput = subprocess.Popen(cefput_cmd, shell=True, stdout=subprocess.PIPE)
				except:
					print ("Error: " + cefput_cmd)			

				while True:
					line = res_cefput.stdout.readline()
					if line:
						print (line.decode(), end='')
						#yield line

					if not line and res_cefput.poll() is not None:
						break

			if(tp_mode == "rgi"):
				if(info.chunk_num < cob_count):
					print("Send a chunk of Inputfile, of which the chunkNum is ", info.chunk_num)
					handle.send_data(info.name, dataCoded[info.chunk_num], info.chunk_num, expiry=0, cache_time=0)
					if(sendDataFlag[info.chunk_num] == 0):
						sendDataFlag[info.chunk_num] = 1
						sendDataNum +=1

					print("Total number of chunks sent  is", sendDataNum)
				else:
					print("The chunkNum is out beyond the max chunkNum", (cob_count-1))
			
				if(sendDataNum == cob_count):
					print("Successfully send all the chunks of the Inputfile")
					break

		else:
			print ("FAIL: failed to receive Interests from a Push-Server, the name prefix is ccnx:/" + UniqueId)
			break
