import pymongo
from os import environ

cluster = pymongo.MongoClient(environ['DATABASE_URL'])

db = cluster.database

Contract = db.contract
