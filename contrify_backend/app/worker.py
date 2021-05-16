import threading
import requests
from time import sleep
from .notifier import newContractNotification
from .external_api import getContracts
from .db import Contract

contracts_url = 'https://api.tzkt.io/v1/contracts?sort.desc=firstActivity&limit=5'


def checkForContracts():
    print('checking for new contracts...')
    contracts = getContracts(5)
    for contract in contracts:
        if Contract.find_one({'codeHash': contract['codeHash']}) is None:
            newContractNotification(contract['address'])
            Contract.insert_one(contract)
            print(contract)
    # newContractNotification()
    

def worker():
    while True:
        checkForContracts()
        sleep(30)

def startWorker():
    t = threading.Thread(target=worker)
    t.start()
