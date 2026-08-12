#!/bin/bash

# Define variables
DB_PASSWORD=$(pass show aws/grooove/database/mssql/password)
DB_USER=$(pass show aws/grooove/database/mssql/user)
DB_HOST=$(pass show aws/grooove/database/mssql/host)
BACKUP_PATH="/home/omoi/development/databases/mssql"

# List of databases to backup
DATABASES=("Grooove_Dev" "Grooove_Common")

# Generate timestamp for backup file
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Loop through the databases
for DATABASE in "${DATABASES[@]}"
do
    # Define full path for backup file
    FULL_BACKUP_PATH="$BACKUP_PATH/${DATABASE}_$TIMESTAMP.bak"

    # Use sqlcmd with credentials from pass to perform backup
    sqlcmd -P "$DB_PASSWORD" -U "$DB_USER" -S "$DB_HOST" -d "$DATABASE" -Q "BACKUP DATABASE $DATABASE TO DISK='$FULL_BACKUP_PATH'"

    # Check if backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup of $DATABASE successful. File saved at $FULL_BACKUP_PATH"
    else
        echo "Backup of $DATABASE failed"
    fi
done
