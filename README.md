# Oracle SQL Terminal Manager

A terminal-based Oracle SQL application that runs prebuilt SQL scripts through a simple shell menu. Instead of manually connecting to Oracle and executing each file one by one, this project uses a Bash script to handle the flow and run everything from one place.

The program prompts the user for Oracle credentials at runtime, connects through SQL*Plus, and lets the user create tables, insert sample data, create views, and run advanced queries from the terminal.


## Technologies

- Bash
- Oracle SQL
- SQL*Plus
- Oracle Instant Client
- Shell Scripting


## Features

- **Create Tables** - Run the SQL script that builds the database schema
- **Insert Sample Data** - Populate the database with records
- **Create Views** - Generate Oracle views for cleaner structured access to data
- **Run Advanced Queries** - Execute predefined SQL queries directly from the menu
- **Runtime Login** - Enter Oracle credentials when the program starts instead of storing them in code


## How It Works

The main file in this project is `menu.sh`.

When the script runs, it:
- Asks for your Oracle username
- Asks for your Oracle password
- Builds the Oracle connection string
- Connects to the database through SQL*Plus
- Shows a terminal menu
- Runs the selected SQL file

This makes the project feel more like a small command-line tool instead of a loose collection of SQL scripts.


## Design Decisions

One of the main goals of this project was to avoid hardcoding or storing Oracle credentials anywhere in the code. I didn't want login information sitting in files or being saved after the program ran.

To solve this, I used Oracle Instant Client and SQL*Plus, which let me handle database connections directly from the terminal. This setup requires a lot of Oracle client libraries (the `.dylib` and `.jar` files in the `lib/` folder), but it means the script can take credentials at runtime, use them for that session, and then discard them when the program ends.

This approach keeps sensitive information out of the source code and gives the user full control over their login details every time they run the program.


## What I Learned

This project helped me understand how terminal scripting and database systems can work together in a practical way.

**Oracle Connection Flow**  
I got more comfortable with how Oracle login details, host values, ports, and SID information come together in a working connection string.

**Shell Scripting**  
This project gave me more experience with loops, conditionals, user input, and command execution in Bash. It showed me how shell scripts can be used to build lightweight tools instead of just running isolated commands.

**SQL*Plus Integration**  
One of the biggest takeaways was learning how SQL*Plus can run `.sql` files directly from the shell. That made it possible to separate the launcher logic from the actual database logic.

**Organizing SQL by Purpose**  
Keeping the SQL files separate made the whole project easier to test, easier to debug, and easier to expand. Each file had a clear role.

**Oracle Client Environment**  
Working with Oracle Instant Client taught me how database client tools handle connections without storing credentials. The libraries and runtime files may seem like overhead, but they enable secure, session-based authentication that doesn't leave login information behind after the program closes.


## Project Structure
```
oracle-terminal-menu/
├── lib/                          # All Oracle client files
│   ├── sqlplus
│   ├── *.dylib files
│   ├── *.jar files
│   ├── network/
│   ├── instantclient_23_3/
│   └── other Oracle files
├── sql/                          # Your SQL scripts
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── views.sql
│   ├── queries.sql
│   └── glogin.sql
├── menu.sh                       # Main script
└── README.md                     # Project documentation
```

**Note:** The Oracle Instant Client libraries in `lib/` are required locally to run the project but are not included in the GitHub repository since they are environment dependencies. Users need to download and set them up separately.


## Prerequisites

- Access to an Oracle database
- SQL*Plus / Oracle Instant Client installed (download from [Oracle's website](https://www.oracle.com/database/technologies/instant-client/downloads.html))
- Valid Oracle username and password


### Setting Up Oracle Instant Client

1. Download Oracle Instant Client for your operating system
2. Create a `lib/` folder in the project directory
3. Place all Instant Client files in the `lib/` folder


## Installation

1. Clone the repository
```bash
git clone https://github.com/ElijahDego/oracle-terminal-menu.git
cd oracle-terminal-menu
```

2. Set up Oracle Instant Client (see Prerequisites above)

3. Make the shell script executable
```bash
chmod +x menu.sh
```


## Usage

Run the script:
```bash
./menu.sh
```

Enter your Oracle username and password when prompted, then choose the menu option you want to run.


### Typical Run Order

A normal first-time run would usually go like this:
1. Create Tables
2. Insert Sample Data
3. Create Views
4. Run Advanced Queries


## Adding Your Own SQL Files

If you want to extend the project and run your own SQL scripts through the menu, the structure is easy to build on.

**Step 1: Add your SQL file**

Create a new `.sql` file in the `sql/` folder.
```sql
-- sql/custom_file.sql
SELECT * FROM Account;
```

**Step 2: Add a new menu option**

Open `menu.sh` and add a new line to the menu display.
```bash
echo "5. Run Custom SQL File"
```

**Step 3: Add a new case block**

Inside the `case` statement in `menu.sh`, add a new option that runs your SQL file through SQL*Plus.
```bash
5)
  echo ">> Running custom SQL file..."
  ./lib/sqlplus -s "$conn_string" @"sql/custom_file.sql"
  ;;
```

**Step 4: Save and rerun**

Save the script, run `./menu.sh` again, and the new option should appear in the terminal menu.


## Security Note

This project does not store Oracle credentials in the code. The user enters them at runtime, which keeps private login information out of the source files. The Oracle Instant Client handles the connection for that session only, and credentials are discarded when the program exits.


## Future Improvements

- Add support for more custom SQL scripts directly through the menu
- Let the script read available `.sql` files dynamically instead of hardcoding each option
- Add better error handling for failed Oracle connections
- Support environment variables for connection settings
- Split SQL files into folders for cleaner organization
- Add logging for executed scripts and query results


## About This Project

This project was created while I was completing a database course assignment. I wanted to figure out how to use an Oracle database from the terminal, as well as make it so that the user could log in with their individual Oracle DB credentials. Made just for fun! Feel free to reach out if you have any suggestions that could make this better! 😊


## Example 

<img width="355" height="156" alt="Screenshot 2026-03-20 at 5 39 42 PM" src="https://github.com/user-attachments/assets/c7c80bd8-47cc-4316-8433-6fd8cd2690f0" />

