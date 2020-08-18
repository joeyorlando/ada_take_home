import re
import logging
from lib.database import db
from typing import List, Tuple
from pony.orm import PrimaryKey, Required, db_session
from lib.models.state import State


class Message(db.Entity):
    _table_ = "messages"

    id = PrimaryKey(int)
    body = Required(str)

    def find_templates(self) -> List[Tuple]:
        return re.findall("({([^|]+)\|([^}]*)})", self.body)

    @db_session
    def serialize(self) -> str:
        body = self.body
        for template, state_id, default in self.find_templates():
            state = State.get(id=state_id)
            body = body.replace(template, state.value if state else default)
        return body

    @classmethod
    @db_session
    def get_messages(cls) -> List[str]:
        return [msg.serialize() for msg in cls.select().order_by(cls.id)]
