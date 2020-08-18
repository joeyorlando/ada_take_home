from config import config
from pony.orm import Database

db = Database(**config["database"])
