import requests

contracts_url = 'https://api.tzkt.io/v1/contracts'
stats_url = 'https://api.better-call.dev/v1/head'

params = {
    'sort.desc': 'firstActivity'
}

def parseContract(contract: dict):
    parsedContract = {
        'address': contract['address'],
        'codeHash': str(contract['codeHash']),
        'balance': str(contract['balance']),
        'creatorName': contract['creator'].get('alias', ''),
        'creatorAddress': contract['creator'].get('address', ''),
        'firstActivity': contract['firstActivityTime'][:-1].replace('T', '  '),
        'lastActivity': contract['lastActivityTime'][:-1].replace('T', '  '),
        'url': 'https://better-call.dev/mainnet/'+contract['address'],
        
    }
    return parsedContract

def getContracts(limit: int):
    params['limit'] = limit
    response = requests.get(contracts_url, params=params)
    contracts = response.json()
    for i in range(len(contracts)):
        contracts[i] = parseContract(contracts[i])
    return contracts

def getContract(address: str):
    url = f'{contracts_url}/{address}'
    response = requests.get(url)
    contract = response.json()
    if 'errors' in contract:
        return None
    # contract = parseContract(contract)
    # contract['contract'] = 
    return contract

def getStats():
    response = requests.get(stats_url)
    stats = response.json()[0]
    return {
        'totalContracts': stats['unique_contracts'],
        'faToken': stats['fa_count'],
        'contractCalls': stats['contract_calls']
    }
