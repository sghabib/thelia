#!/bin/bash
# @author Guillaume MOREL
# v0.1

echo -e "\033[47m\033[1;31m\n[WARN] This script will reset this Thelia2 install\n\033[0m"

echo -e "\n\e[01;34m[INFO] Downloading vendors\e[00m\n"
php composer install --prefer-dist --no-dev

cd local/config/

echo -e "\n\e[01;34m[INFO] Building Models file\e[00m\n"
../../bin/propel build -v --output-dir=../../core/lib/

echo -e "\n\e[01;34m[INFO] Building SQL CREATE file\e[00m\n"
../../bin/propel sql:build -v --output-dir=../../install/

# Not working : insert manually
# echo -e "\n\e[01;34m[INFO] Inserting SQL\e[00m\n"
# ../../bin/propel insert-sql -v --output-dir=../../install/
# install/thelia.sql
# install/insert.sql
echo -e "\n\e[01;34m[INFO] Reinstalling Thelia2\e[00m\n"
cd ../..
php Thelia thelia:install --db_host localhost --db_username thelia2 --db_password thelia2 --db_name thelia2

echo -e "\n\e[01;34m[INFO] Installing fixtures\e[00m\n"
php install/faker.php

echo -e "\n\e[01;34m[INFO] Adding admin\e[00m\n"
php Thelia thelia:create-admin --login_name thelia2 --password thelia2 --last_name thelia2 --first_name thelia2

echo -e "\n\e[00;32m[SUCCESS] Reset done\e[00m\n"

