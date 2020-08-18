from lib.database import db
from pony.orm import PrimaryKey, Required


class Block(db.Entity):
    _table_ = "blocks"

    id = PrimaryKey(int)
    content = Required(str)
    answer_id = Required("Answer")
