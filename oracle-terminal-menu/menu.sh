#!/bin/bash

# Set library path for Oracle Instant Client
export DYLD_LIBRARY_PATH="./lib:$DYLD_LIBRARY_PATH"  # macOS

# Prompt for Oracle username and password
read -p "Enter your Oracle username: " username
read -s -p "Enter your Oracle password: " password
echo ""

# Oracle connection string
conn_string="$username/\"$password\"@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.cs.torontomu.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))"

# Loop the menu
while true; do
  echo "======================================="
  echo " Oracle SQL Application Menu"
  echo "======================================="
  echo "1. Create Tables"
  echo "2. Insert Sample Data"
  echo "3. Create Views"
  echo "4. Run Advanced Queries"
  echo "5. Exit"
  echo "======================================="
  read -p "Choose an option (1-5): " option

  case $option in
    1)
      echo ">> Creating tables..."
      ./lib/sqlplus -s "$conn_string" @"sql/create_tables.sql"
      ;;
    2)
      echo ">> Inserting sample data..."
      ./lib/sqlplus -s "$conn_string" @"sql/insert_data.sql"
      ;;
    3)
      echo ">> Creating views..."
      ./lib/sqlplus -s "$conn_string" @"sql/views.sql"
      ;;
    4)
      echo ">> Running advanced queries..."
      ./lib/sqlplus -s "$conn_string" @"sql/queries.sql"
      ;;
    5)
      echo "Exiting... Goodbye!"
      break
      ;;
    *)
      echo "Invalid option. Please choose 1-5."
      ;;
  esac

  echo ""
done