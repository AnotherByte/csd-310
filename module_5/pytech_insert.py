'''
Chris Beatty
June 16, 2022
Mod 5.3 - PyTech Insert
'''
#import pymongo
from pymongo import MongoClient

#setup mongodb connection
url = "mongodb+srv://admin:admin@cluster0.xibse.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(url)

db = client["pytech"]
col = db["students"]

#begin inserts
print("\n-- INSERT STATEMENTS --")

#first student 1007
student = {"student_id": "1007",
           "first_name": "Laura",
           "last_name": "Bailey"}
#save _id from insert
new_student_id = col.insert_one(student).inserted_id
#print values of what was inserted
print(f"Inserted student record {student['first_name']} {student['last_name']} into the students collection with document_id {new_student_id}")

#second student 1008
student = {"student_id": "1008",
           "first_name": "Sam",
           "last_name": "Riegel"}
#save _id from insert
new_student_id = col.insert_one(student).inserted_id
#print values of what was inserted
print(f"Inserted student record {student['first_name']} {student['last_name']} into the students collection with document_id {new_student_id}")

#third student 1009
student = {"student_id": "1009",
           "first_name": "Travis",
           "last_name": "Willingham"}
#save _id from insert
new_student_id = col.insert_one(student).inserted_id
#print values of what was inserted
print(f"Inserted student record {student['first_name']} {student['last_name']} into the students collection with document_id {new_student_id}")

input("\n\nEnd of program, press any key to exit... ")