Database Cloner/Dumper
======================

Description
------------

Script to clone/dump a production database.

Installation
------------

Install thor:

    gem install thor

Save the script somewhere useful and run it from that folder.

Usage
-----

Clone a database into _development:

    thor cloner:clone [yml_file] [server]

Dump a database into the root of your project folder:

    thor cloner:dump [yml_file] [server]
