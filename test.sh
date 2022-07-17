#!/bin/sh

THEDATE=`date +%d-%m-%y-%H:%M`
THEDBUSER="root"
THEDBPW="9913808057Aa@"

# zip all files
#zip -r backup_of_${THEDATE}.zip /var/lib/pterodactyl/volumes -P YXdzIGtpIG1hYSBrYSBiaG9zZGE=

cd /var/lib/pterodactyl/volumes
for i in */; do zip -r "${i%/}.zip" "$i"; done

for i in *.zip; do mv "${i%}" /var/www/_backups/ptero; done

zip -r backup_of_${THEDATE}.zip /var/www/_backups/ptero -P YXdzIGtpIG1hYSBrYSBiaG9zZGE=

# export all the db
cd ~
mysql -N -e 'show databases' | while read dbname; do mysqldump --complete-insert --routines --triggers --single-transaction "$dbname" > /var/www/_backups/${dbname}_${THEDATE}.sql; done
zip -r /var/www/_backups/dbbackup_${THEDATE}.zip /var/www/_backups/db -P YXdzIGtpIG1hYSBrYSBiaG9zZGE=
#mysqldump -u ${THEDBUSER} -p${THEDBPW} --all-databases > /var/www/_backups/dbbackup_${THEDATE}.sql

# move the zip and db
mv /var/www/_backups/ptero/backup_of_${THEDATE}.zip /var/lib/_backups/ptero
mv /var/www/_backups/db/dbbackup_${THEDATE}.zip /var/lib/_backups/db

#clear the extra db backups
rm -r /var/www/_backups && mkdir /var/www/_backups/ptero && mkdir /var/www/_backups/db

# Remove backups older than 3 days
find /var/lib/_backups/ptero* -mtime +3 -exec rm {} \;
find /var/lib/_backups/db* -mtime +3 -exec rm {} \;

# Sync to amazon. With the 'delete' option, the files removed from
# /var/www/_backups will be removed from the bucket as well
aws --endpoint-url http://13.235.69.39:9000 s3 sync /var/lib/_backups s3://test --delete
aws --endpoint-url http://15.206.147.201:9000 s3 sync /var/lib/_backups s3://test --delete
