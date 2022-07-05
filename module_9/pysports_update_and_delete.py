"""
Chris Beatty
July 4, 2022
Mod 9.3 - PySports Update and Delete
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
   
    
    #insert statement to add new player
    cursor.execute("INSERT INTO player (first_name, last_name, team_id) VALUES ('Smeagol', 'Shire Folk', 1);")
    
    
    #show newly added player
    #select query for players with join on team_id to show team_name
    cursor.execute("SELECT player_id, first_name, last_name, team_name FROM player INNER JOIN team ON player.team_id = team.team_id")
    
    #fetch all player info using previous SELECT statement
    players = cursor.fetchall()
    
    #display player info
    print("\n  -- DISPLAYING PLAYERS AFTER INSERT --")
    for player in players:
        print("  Player ID: {}\n  First Name: {}\n  Last Name: {}\n  Team Name: {}\n".format(player[0], player[1], player[2], player[3]))    
    
    
    #update newly added record
    cursor.execute("UPDATE player SET team_id = 2, first_name = 'Gollum', last_name = 'Ring Stealer' WHERE first_name = 'Smeagol';")
    
    
    #show updated player
    #select query for players with join on team_id to show team_name
    cursor.execute("SELECT player_id, first_name, last_name, team_name FROM player INNER JOIN team ON player.team_id = team.team_id")
    
    #fetch all player info using previous SELECT statement
    players = cursor.fetchall()
    
    #display player info
    print("\n  -- DISPLAYING PLAYERS AFTER UPDATE --")
    for player in players:
        print("  Player ID: {}\n  First Name: {}\n  Last Name: {}\n  Team Name: {}\n".format(player[0], player[1], player[2], player[3]))    
    
    
    #delete new record
    cursor.execute("DELETE FROM player WHERE first_name = 'Gollum';")
    
    
    #show deleted player, or lack of
    #select query for players with join on team_id to show team_name
    cursor.execute("SELECT player_id, first_name, last_name, team_name FROM player INNER JOIN team ON player.team_id = team.team_id")
    
    #fetch all player info using previous SELECT statement
    players = cursor.fetchall()
    
    #display player info
    print("\n  -- DISPLAYING PLAYERS AFTER DELETE --")
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