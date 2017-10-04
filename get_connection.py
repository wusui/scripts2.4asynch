import sys
import boto
import json
import socket
import boto.s3.connection
"""
get_connection(user) interprets a file named /tmp/user as a json
file. It extracts the access_key and secret_key and generates a
boto connection
"""
def get_connection(user):
    with open('/tmp/%s' % user) as f:
        uinfo = f.read()
    userinf = json.loads(uinfo) 
    fconn = boto.connect_s3(
        aws_access_key_id = userinf['keys'][0]['access_key'],
        aws_secret_access_key = userinf['keys'][0]['secret_key'],
        host = socket.gethostname(),
        is_secure=False, port=80,
        calling_format = boto.s3.connection.OrdinaryCallingFormat(),
        )
    return fconn
