from flask import Flask, jsonify, request
import requests
from os import environ

from .db import Contract
from .external_api import getContracts, getContract, getStats
from .notifier import newContractNotification
from .worker import checkForContracts

app = Flask(__name__)

@app.route("/")
def index():
    return {
        'message': 'API for Contrify app',
        'documentationUrl': 'https://documenter.getpostman.com/view/10774800/TzRVf6CM'
    }

@app.route("/v1/data")
def printData():
    contracts = Contract.find({}, {'_id': 0})
    return jsonify(cntracts)

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

@app.route('/v1/contracts/search/<address>')
def contract(address):
    contract = getContract(address)
    if not contract:
        return {
            'message': 'Contract not found.'
        }, 404
    return contract

@app.route('/v1/contracts/unique')
def uniqueContracts():
    limit = request.args.get('limit', '100')
    if not limit.isdigit() or int(limit) > 10000:
        return {
            'error': 'Invalid limit'
        }
    limit = int(limit)
    contracts = list(Contract.find({}, {'_id': 0}).sort('firstActivity', -1).limit(limit))
    return jsonify(contracts)


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
    limit = request.args.get('limit', '100')
    if not limit.isdigit() or int(limit) > 10000:
        return {
            'error': 'Invalid limit'
        }
    limit = int(limit)
    contracts = getContracts(limit)
    print(contracts)
    for contract in contracts:
        if Contract.find_one({'codeHash': contract['codeHash']}) is None:
            newContractNotification()
            insertIntoDatabase(dict(contract))
    return jsonify(contracts)

@app.route('/v1/newContract', methods=['POST'])
def newContract():
    contracts = request.json
    print(contracts)
    for k, contract in contracts.items():
        if Contract.find_one({'codeHash': contract['codeHash']}) is None:
            insertIntoDatabase(dict(contract))  
    return {}


def insertIntoDatabase(contract: dict):
    Contract.insert_one(contract)
    print(contract)
