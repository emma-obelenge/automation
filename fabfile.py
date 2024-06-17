#!/usr/bin/python3
#trying out the fabric file usage

from fabric import Connection

alx_server = Connection(host = "7afc3379fe15@7afc3379fe15.c4482d22.alx-cod.online", connect_kwargs = {"password" : "2c9b18ddf719514d8c95"})

alx_server.run("whoami")
