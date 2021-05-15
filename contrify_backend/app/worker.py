import threading
import requests
from time import sleep
from .notifier import newContractNotification
from .external_api import getContracts

contracts_url = 'https://api.tzkt.io/v1/contracts?sort.desc=firstActivity&limit=5'


def checkForContracts():
    print('checking for new contracts...')
    # newContractNotification()
    

def worker():
    while True:
        checkForContracts()
        sleep(30)

def startWorker():
    t = threading.Thread(target=worker)
    t.start()
