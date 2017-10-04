#! /bin/bash -f
#
# Create an rgw user and store the radosgw json data in /tmp/<username>
#
# Run simple s3 tests (create a bucket and list)
#
source /tmp/globaldefs.sh
octo_name=${octoname:-'wusui'}
rgw_uid=${rgwuid:-'tester'}
rgw_display_name=${rgwdisplayname:-'Tester'}
rgw_email=${rgwemail:-'foo@redhat.com'}
cd ~
cp /tmp/bucket_test.py .
cp /tmp/get_connection.py .
radosgw-admin user create --uid="${rgw_uid}" --display-name="${rgw_display_name}" --email="$rgw_email" > /tmp/${rgw_uid}
python bucket_test.py ${rgw_uid}
