from os import environ
from dotenv import load_dotenv

load_dotenv()

from app.main import app
from app.worker import startWorker

if __name__ == "__main__":
    # startWorker()
    app.run(
        debug = True if environ.get('DEBUG') == 'true' else False,
        port = environ.get('PORT'),
        host = environ.get('IP')
    )
