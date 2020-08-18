from lib.database import db

from lib.models.answer import Answer
from lib.models.block import Block
from lib.models.message import Message
from lib.models.state import State

db.generate_mapping(check_tables=True, create_tables=False)
