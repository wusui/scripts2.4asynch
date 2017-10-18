# scripts2.4asynch

The scripts here combine to form a set of commands that can be used
to install rgw clusters.

The following are commands that can be run from this directory.

* prerequisites.sh -- run the prerequisite commands on the machines specified
* install_ceph.sh -- ansible install ceph osds and mons on the machines specified
* setup_client_and_rgw.sh -- add client and rgw to the machines specified.
* rgw_sanity_test.sh -- test s3 basics on the site specified

Note globaldefs.sh.sample must be moved to globaldefs.sh, and subscrname and subscrpassword need to be set.

