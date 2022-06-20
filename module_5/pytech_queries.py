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
    
#begin find_one()
print("\n-- DISPLAYING STUDENT DOCUMENT FROM find_one() QUERY --")
#get only student with student_id 1008
student = col.find_one({'student_id': "1008"})
#print student_id 1008's info
print(f"Student ID: {student['student_id']}")
print(f"First Name: {student['first_name']}")
print(f"Last Name: {student['last_name']}\n")

#end program
input("\n\nEnd of program, press any key to exit... ")