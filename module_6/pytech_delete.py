'''
Chris Beatty
June 26, 2022
Mod 6.3 - PyTech Delete
'''
#import pymongo
from pymongo import MongoClient

#setup mongodb connection
url = "mongodb+srv://admin:admin@cluster0.xibse.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(url)

db = client["pytech"]
col = db["students"]

#begin find()
print("\n-- DISPLAYING STUDENTS DOCUMENTS FROM find() QUERY --")
#get all student records; print id, firstname, lastname for each
for student in col.find():
    print(f"Student ID: {student['student_id']}")
    print(f"First Name: {student['first_name']}")
    print(f"Last Name: {student['last_name']}\n")

#begin new insert
print("\n-- INSERT STATEMENTS --")
#create new student document
student = {"student_id": "1010",
           "first_name": "Matt",
           "last_name": "Mercer"} 
#insert new student document
new_student_id = col.insert_one(student).inserted_id
print(f"Inserted student record {student['student_id']} into the students collection with document_id {new_student_id}")
 
#begin find() after new insert
print("\n-- DISPLAYING NEW STUDENT LIST DOC --")
#get all student records; print id, firstname, lastname for each
for student in col.find():
    print(f"Student ID: {student['student_id']}")
    print(f"First Name: {student['first_name']}")
    print(f"Last Name: {student['last_name']}\n")
    
#begin delete of new student
col.delete_one({"student_id": "1010"})
    
#begin find() after delete
print("\n-- DELETED STUDENT ID: 1010 --")
#get all student records; print id, firstname, lastname for each
for student in col.find():
    print(f"Student ID: {student['student_id']}")
    print(f"First Name: {student['first_name']}")
    print(f"Last Name: {student['last_name']}\n")
    
#end program
input("\n\nEnd of program, press any key to exit... ")