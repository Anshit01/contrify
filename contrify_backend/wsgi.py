from os import environ
from dotenv import load_dotenv

load_dotenv()

from app.main import app
from app.worker import startWorker

if __name__ == "__main__":
    debug = True if environ.get('DEBUG') == 'true' else False
    if not debug:
        startWorker()
    app.run(
        debug = debug,
        port = environ.get('PORT'),
        host = environ.get('IP'),
        use_reloader=False
    )
