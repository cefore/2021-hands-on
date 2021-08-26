#!/usr/bin/env python3

import cefpyco

with cefpyco.create_handle() as handle:
    handle.register("ccnx:/test")
    while True:
        info = ________________ # TODO
        #         ↓TODO                         ↓TODO                   ↓TODO
        if info.is_________ and (info.name == ____________) and (info.______________):
            handle.send_______________________________ #TODO
            # break # Uncomment if publisher provides content once 
