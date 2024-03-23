from flask import Flask, request, jsonify
from utils import make_prediction
from waitress import serve
from paste.translogger import TransLogger

app = Flask(__name__)

@app.route('/status')
def healthCheck():
    response = "API is running"
    return jsonify({'response' : response})


@app.route('/api/predict', methods=['POST'])
def predict():
    text_json = request.get_json(force=True)
    text = text_json['text']
    prediction = make_prediction(text)
    return jsonify({'prediction': prediction})


if __name__ == "__main__":
    serve(TransLogger(app, setup_console_handler=False), host="0.0.0.0", port="5000")
