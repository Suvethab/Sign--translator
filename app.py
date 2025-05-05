from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

@app.route('/summarize', methods=['POST'])
def summarize():
    data = request.get_json()
    text = data.get("text", "")
    if not text:
        return jsonify({"error": "No input text provided."}), 400
    result = summarizer(text, max_length=30, min_length=5, do_sample=False)
    return jsonify({"summary": result[0]["summary_text"]})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
