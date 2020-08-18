from lib.database import db
from pony.orm import PrimaryKey, Required


class State(db.Entity):
    _table_ = "state"

    id = PrimaryKey(str)
    value = Required(str)
