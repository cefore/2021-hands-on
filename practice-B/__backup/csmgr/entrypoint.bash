#!/bin/bash

csmgrdstart
sleep 0.5
cefnetdstart && tail -f 
