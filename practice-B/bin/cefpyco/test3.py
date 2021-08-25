#!/usr/bin/env python3

import cefpyco

with cefpyco.create_handle() as handle:
    # ccnx:/testというコンテンツの0番目のチャンクを
    # 要求するInterestパケットを送信
    handle.send_interest("ccnx:/test", 0)
