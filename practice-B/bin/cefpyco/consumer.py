#!/usr/bin/env python3

from time import sleep
import cefpyco

with cefpyco.create_handle() as handle:
    while True:
        handle.send_interest(_______________) #TODO
        info = handle.receive()
        #         ↓TODO                     ↓TODO                            ↓TODO  
        if info.is_____ and (info.name == ___________) and (info.chunk_num == _):
            print("Success")
            print(info)
            break
        sleep(1)
