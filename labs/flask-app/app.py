from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return "<h1>Flask app in Docker</h1><p>Lypovetskyi Bohdan, PI-23-03</p>"


@app.route("/api/student")
def student():
    return jsonify(name="Bohdan Lypovetskyi", group="PI-23-03", number=7)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
