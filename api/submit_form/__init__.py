import logging
import json
import os
import requests
import azure.functions as func

def main(req: func.HttpRequest, output_blob: func.Out[str]) -> func.HttpResponse:
    logging.info("Processing submit_form request via direct Mailgun API")

    try:
        data = req.get_json()
        name = data.get("name")
        email = data.get("email")
        msg = data.get("message")

        if not (name and email and msg):
            return func.HttpResponse(
                json.dumps({"error": "Missing fields"}),
                status_code=400,
                mimetype="application/json",
                headers={"Access-Control-Allow-Origin": "*"}
            )

        subject = "New Contact Form Message"
        body = f"Name: {name}\nEmail: {email}\nMessage: {msg}"

        # Read Mailgun credentials from environment variables
        MAILGUN_DOMAIN = os.environ["MAILGUN_DOMAIN"]
        MAILGUN_API_KEY = os.environ["MAILGUN_API_KEY"]
        FROM_EMAIL = os.environ["MAILGUN_FROM_EMAIL"]
        TO_EMAIL = os.environ["MAILGUN_TO_EMAIL"]

        # Send email via Mailgun API
        response = requests.post(
            f"https://api.mailgun.net/v3/{MAILGUN_DOMAIN}/messages",
            auth=("api", MAILGUN_API_KEY),
            data={
                "from": f"Website Contact <{FROM_EMAIL}>",
                "to": TO_EMAIL,
                "reply-to": email,
                "subject": subject,
                "text": body,
            }
        )

        if response.status_code != 200:
            logging.error(f"Mailgun error: {response.status_code}, {response.text}")
            return func.HttpResponse(
                json.dumps({"error": "Email failed to send"}),
                status_code=500,
                mimetype="application/json",
                headers={"Access-Control-Allow-Origin": "*"}
            )

        output_blob.set(json.dumps(data))

        return func.HttpResponse(
            json.dumps({"success": True}),
            status_code=200,
            mimetype="application/json",
            headers={"Access-Control-Allow-Origin": "*"}
        )

    except Exception as e:
        logging.error(f"submit_form error: {e}")
        return func.HttpResponse(
            json.dumps({"error": "Internal server error"}),
            status_code=500,
            mimetype="application/json",
            headers={"Access-Control-Allow-Origin": "*"}
        )
