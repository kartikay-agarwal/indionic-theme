#!/bin/sh

THEDATE=`date +%d-%m-%y-%H:%M`
THEDBUSER="root"
THEDBPW="9913808057Aa@"

# zip all files
zip -r backup_of_${THEDATE}.zip /var/lib/pterodactyl/volumes -P YXdzIGtpIG1hYSBrYSBiaG9zZGE=

# export all the db
mysqldump --all-databases > /var/www/_backups/dbbackup_${THEDATE}.sql

# move the zip and db
mv backup_of_${THEDATE}.zip /var/lib/_backups/ptero
mv /var/www/_backups/dbbackup_${THEDATE}.sql /var/lib/_backups/db

# Remove backups older than 3 days
find /var/lib/_backups/ptero* -mtime +3 -exec rm {} \;
find /var/lib/_backups/db* -mtime +3 -exec rm {} \;

# Sync to amazon. With the 'delete' option, the files removed from
# /var/www/_backups will be removed from the bucket as well
aws --endpoint-url http://13.235.69.39:9000 s3 sync /var/lib/_backups s3://test --delete
aws --endpoint-url http://15.206.147.201:9000 s3 sync /var/lib/_backups s3://test --delete
