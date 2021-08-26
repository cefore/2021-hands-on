#!/usr/bin/env python3

import cefpyco

with cefpyco.create_handle() as handle:
    handle.register("ccnx:/test")
    while True:
        info = handle.receive()
        if info.is_interest and (info.name == "ccnx:/test") and (info.chunk_num == 0):
            handle.send_data("ccnx:/test", "hello", 0)
            # break # Uncomment if publisher provides content once 
