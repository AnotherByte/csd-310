"""
Chris Beatty
July 3, 2022
Mod 9.2 - PySports Join Queries
"""

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "pysports_user",
    "password": "seasprite",
    "host": "127.0.0.1",
    "database": "pysports",
    "raise_on_warnings": True
}

try:
    #connect to db
    db = mysql.connector.connect(**config)
    
    #create db scanner/reader
    cursor = db.cursor()
   
    #select query for players with join on team_id to show team_name
    cursor.execute("SELECT player_id, first_name, last_name, team_name FROM player INNER JOIN team ON player.team_id = team.team_id")
    
    #fetch all player info using previous SELECT statement
    players = cursor.fetchall()
    
    #display player info
    print("\n  -- DISPLAYING PLAYER RECORDS --")
    for player in players:
        print("  Player ID: {}\n  First Name: {}\n  Last Name: {}\n  Team Name: {}\n".format(player[0], player[1], player[2], player[3]))    
    
    
    input("\n\n  Press any key to continue...")
    
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")
        
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The Specified database does not exist")
        
    else:
        print(err)
        
finally:
    db.close()