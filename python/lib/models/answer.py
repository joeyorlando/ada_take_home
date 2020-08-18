import json
from lib.database import db
from typing import List, Dict
from pony.orm import PrimaryKey, Required, Optional, db_session


class Answer(db.Entity):
    _table_ = "answers"

    id = PrimaryKey(int)
    title = Required(str)
    block = Optional("Block")

    def serialize(self) -> Dict:
        return {
            "id": self.id,
            "title": self.title,
            "content": json.loads(self.block.content) if self.block else None
        }

    @classmethod
    @db_session
    def search(cls, query: str) -> List[Dict]:
        query_terms = query.strip().lower().split(" ")
        query = """
            SELECT
                answers.*
            FROM answers
            LEFT JOIN blocks ON blocks.answer_id = answers.id
            WHERE
                """

        for idx, query_term in enumerate(query_terms):
            query += f"""{' AND ' if idx > 0 else ''}(
                (
                    TRIM(LOWER(answers.title)) LIKE '%' || '{query_term}' || '%'
                    OR TRIM(LOWER(blocks.content)) LIKE '%' || '{query_term}' || '%'
                )
                -- ensure that the search terms dont match type key
                AND (
                    TRIM(LOWER(blocks.content)) !~ '["'']type["'']: ["'']{query_term}["'']'
                )
                -- ensure that json field names dont match
                AND (
                    TRIM(LOWER(blocks.content)) !~ '["'']{query_term}["'']: ["''].*["'']'
                )
            )"""

        query += """
            ORDER BY
                answers.id ASC
        """

        results = cls.select_by_sql(query)
        return [result.serialize() for result in results]
