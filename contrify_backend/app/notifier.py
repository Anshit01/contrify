from pyfcm import FCMNotification
from os import environ

api_key = environ.get('FIREBASE_KEY')

push_service = FCMNotification(api_key=api_key)

def notifyAll(messageTitle, messageBody, messageData={}):
    response = push_service.notify_topic_subscribers(
        topic_name='general',
        message_body=messageBody,
        message_title=messageTitle,
        sound='Default',
        # dry_run=True,
        data_message=messageData
    )
    print(response)

def newContractNotification(address=None):
    messageData = {}
    if address:
        messageData = {'address': address}
    notifyAll('New Contract', 'A new contract just got deployed on the mainnet.', messageData)