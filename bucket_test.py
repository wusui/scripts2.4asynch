import sys
import boto
import json
import socket
import uuid
import boto.s3.connection
from get_connection import get_connection
"""
Run a simple test that creates a bucket and lists buckets.
"""
conn = get_connection(sys.argv[1])
new_bucket = conn.create_bucket(str(uuid.uuid4()))
for bucket in conn.get_all_buckets():
    print "{name}\t{created}".format(
            name = bucket.name,
            created = bucket.creation_date,
    )
