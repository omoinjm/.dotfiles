#!/bin/bash

# Define variables
CONNECTION_STRING=$(pass show aws/grooove/database/mssql/con_str)
BACKUP_PATH="/home/omoi/development/databases/mssql"

echo $CONNECTION_STRING

# List of databases to backup
DATABASES=("Grooove_Dev" "Grooove_Common")

# Generate timestamp for backup file
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Loop through the databases
for DATABASE in "${DATABASES[@]}"
do
    # Define full path for backup file
    FULL_BACKUP_PATH="$BACKUP_PATH/$DATABASE_$TIMESTAMP.bak"
    
    # Use sqlcmd with connection string to perform backup
    sqlcmd -P "***REDACTED-PASSWORD***" -U "***REDACTED-USER***" -S "***REDACTED-HOST***" -d "$DATABASE" -Q "BACKUP DATABASE $DATABASE TO DISK='$FULL_BACKUP_PATH'"
    
    # Check if backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup of $DATABASE successful. File saved at $FULL_BACKUP_PATH"
    else
        echo "Backup of $DATABASE failed"
    fi
done
/
