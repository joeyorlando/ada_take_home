from flask import Flask, request, jsonify, Response
from lib.models import Message, Answer

app = Flask(__name__)


@app.route("/messages", methods=["GET"])
def messages_route() -> Response:
    return jsonify(Message.get_messages()), 200


@app.route("/search", methods=["POST"])
def search_route() -> Response:
    query = request.get_json().get("query")
    if not query or type(query) is not str:
        return "Invalid input", 400 
    return jsonify(Answer.search(query)), 200
