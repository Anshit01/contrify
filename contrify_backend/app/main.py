from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import exists
import requests
from os import environ

from .external_api import getContracts, getContract, getStats
from .notifier import newContractNotification
from .worker import checkForContracts

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = environ['DATABASE_URL']
db = SQLAlchemy(app)

class Contract(db.Model):
    address = db.Column(db.String(200), primary_key=True)
    balance = db.Column(db.Integer)
    creatorName = db.Column(db.String(256))
    creatorAddress = db.Column(db.String(200))
    firstActivity = db.Column(db.String(50))
    lastActivity = db.Column(db.String(50))
    url = db.Column(db.String(200))
    codeHash = db.Column(db.String(200))

    def __repr__(self):
        return f'<Contract {self.address}>'

class Contracts(db.Model):
    address = db.Column(db.String(200), primary_key=True)
    
    def __repr__(self):
        return f"<Contracts {self.address}>"

@app.route("/")
def index():
    try:
        test_address = Contracts(address = 'asfadgadsasfas')
        db.session.add(test_address)
        db.session.commit()
    except:
        pass

    return {
        'message': 'API for Contrify app',
        'documentationUrl': 'https://documenter.getpostman.com/view/10774800/TzRVf6CM'
    }

@app.route("/v1/data")
def printData():
    address = Contracts.query.all()
    for i in range(len(address)):
        address[i] = str(address[i])
    return jsonify(address)

@app.route("/<version>")
def versionCheck(version):
    versionStatus = {
        'v1': 'Latest version',
    }
    return {
        'message': versionStatus.get(version, f'Version {version} does not exist')
    }

@app.route('/v1/contracts')
def contracts():
    limit = request.args.get('limit', '100')
    if not limit.isdigit() or int(limit) > 10000:
        return {
            'error': 'Invalid limit'
        }
    limit = int(limit)
    contracts = getContracts(limit)
    return jsonify(contracts)

@app.route('/v1/contracts/<address>')
def contract(address):
    contract = getContract(address)
    if not contract:
        return {
            'message': 'Contract not found.'
        }, 404
    return contract

@app.route('/v1/stats')
def stats():
    statDict = getStats()
    return statDict

@app.route('/v1/notify')
def notify():
    newContractNotification()
    return {}

@app.route('/v1/newContractNotify')
def newContractNotify():
    contracts = getContracts(2)
    print(contracts)
    for i in range(len(contracts)):
        q = db.session.query(Contracts.address).filter(Contracts.address==contracts[i]['address'])
        if db.session.query(q.exists()).scalar():
            pass
        else:
            newContractNotification()
            test_address = Contracts(address = contracts[i]['address'])
            db.session.add(test_address)
            db.session.commit()
            
    return jsonify(contracts)

@app.route('/v1/newContract')
def newContract():
    if request.method == 'POST':
        contracts = request.json
        print(contracts)
        return {}
    address = request.args['address']
    balance = request.args['balance']
    creatorName = request.args['creatorName']
    creatorAddress = request.args['creatorAddress']
    firstActivity = request.args['firstActivity']
    lastActivity = request.args['lastActivity']
    url = request.args['url']
    codeHash = request.args['codeHash']

    q = db.session.query(Contract.address).filter(Contract.address==address)
    if not db.session.query(q.exists()).scalar():
        contract = Contract(
            address=address,
            balance=balance,
            creatorName=creatorName,
            creatorAddress=creatorAddress,
            firstActivity=firstActivity,
            lastActivity=lastActivity,
            url=url,
            codeHash=codeHash
        )
        db.session.add(contract)
        db.session.commit()
    return dict(request.args)
