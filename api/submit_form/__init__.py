import logging
import json
import azure.functions as func

def main(req: func.HttpRequest,
         sendgrid_msg: func.Out[str],
         output_blob: func.Out[str]) -> func.HttpResponse:
    logging.info("Processing submit_form request")
    try:
        data = req.get_json()
        name = data.get("name")
        email = data.get("email")
        msg = data.get("message")
        if not (name and email and msg):
            return func.HttpResponse(json.dumps({"error": "Missing fields"}),
                                     status_code=400,
                                     mimetype="application/json")
        # build SendGrid message
        body = f"Name: {name}\nEmail: {email}\nMessage: {msg}"
        sendgrid_msg.set(json.dumps({
            "personalizations": [{"to": [{"email": "davidmboli1@gmail.com"}]}],
            "from": {"email": "80da97eed946434cbef2c357fda2420e@domainsbyproxy.com"},
            "subject": "New Contact Form Message",
            "content": [{"type": "text/plain", "value": body}]
        }))
        # write to blob
        output_blob.set(json.dumps(data))
        return func.HttpResponse(json.dumps({"success": True}),
                                 status_code=200,
                                 mimetype="application/json",
                                 headers={"Access-Control-Allow-Origin": "*"})
    except Exception as e:
        logging.error(f"submit_form error: {e}")
        return func.HttpResponse(json.dumps({"error": "Internal server error"}),
                                 status_code=500,
                                 mimetype="application/json",
                                 headers={"Access-Control-Allow-Origin": "*"})
