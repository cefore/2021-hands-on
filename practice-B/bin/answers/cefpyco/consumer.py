#!/usr/bin/env python3

from time import sleep
import cefpyco

with cefpyco.create_handle() as handle:
    while True:
        handle.send_interest("ccnx:/test", 0)
        info = handle.receive()
        if info.is_succeeded and (info.name == "ccnx:/test") and (info.chunk_num == 0):
            print("Success")
            print(info)
            break
        sleep(1)
