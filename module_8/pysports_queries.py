"""
Chris Beatty
July 3, 2022
Mod 8.3 - PySports Queries
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
    cursor.execute("SELECT team_id, team_name, mascot FROM team")
    
    #fetch all team info from team table
    teams = cursor.fetchall()
    
    #display team info
    print("\n  -- DISPLAYING TEAM RECORDS --")
    for team in teams:
        print("  Team ID: {}\n  Team Name: {}\n  Mascot: {}\n".format(team[0], team[1], team[2]))
   
    #select query for players
    cursor.execute("SELECT player_id, first_name, last_name, team_id FROM player")
    
    #fetch all player info
    players = cursor.fetchall()
    
    #display player info
    print("\n  -- DISPLAYING PLAYER RECORDS --")
    for player in players:
        print("  Player ID: {}\n  First Name: {}\n  Last Name: {}\n  Team ID: {}\n".format(player[0], player[1], player[2], player[3]))    
    
    
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