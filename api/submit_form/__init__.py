import logging
import json
import azure.functions as func

def main(
    req: func.HttpRequest,
    mailgun_msg: func.Out[dict],
    output_blob: func.Out[str]
) -> func.HttpResponse:
    logging.info("Processing submit_form request via Mailgun binding")

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

        # Validate email logic here, if needed

        subject = "New Contact Form Message"
        body = f"Name: {name}\nEmail: {email}\nMessage: {msg}"

        # Use the Mailgun binding to send the message
        mailgun_msg.set({
            "to": ["davidmboli1@gmail.com"],
            "subject": subject,
            "text": body,
            "h:Reply-To": f"{name} <{email}>"
        })

        # Write the JSON payload to blob storage
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
