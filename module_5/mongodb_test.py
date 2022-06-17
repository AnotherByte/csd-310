#import pymongo
from pymongo import MongoClient

url = "mongodb+srv://admin:admin@cluster0.xibse.mongodb.net/?retryWrites=true&w=majority"

client = MongoClient(url)

db = client.pytech

print(" -- Pytech Collections List --")
print(db.list_collection_names())