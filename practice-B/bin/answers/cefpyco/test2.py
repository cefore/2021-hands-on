#!/usr/bin/env python3

import cefpyco

with cefpyco.create_handle() as handle:
    # ccnx:/testというコンテンツ名・チャンク番号0で
    # helloというテキストコンテンツをDataパケットとして送信
    handle.send_data("ccnx:/test", "hello", 0, cache_time=7200000)
