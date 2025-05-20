import logging
import json
import azure.functions as func

app = func.FunctionApp()

@app.route(route="submit_form", methods=["POST"], auth_level=func.AuthLevel.ANONYMOUS)
@app.send_grid_output(arg_name="sendgrid_msg",
                      api_key="SENDGRID_API_KEY",
                      from_email="80da97eed946434cbef2c357fda2420e@domainsbyproxy.com",
                      to="davidmboli1@gmail.com",
                      subject="New Contact Form Message")
@app.blob_output(arg_name="output_blob",
                 path="submissions/{rand-guid}.json",
                 connection="AzureWebJobsStorage")
def submit_form(req: func.HttpRequest,
                sendgrid_msg: func.Out[str],
                output_blob: func.Out[str]) -> func.HttpResponse:
    try:
        data = req.get_json()
        name  = data.get("name")
        email = data.get("email")
        msg   = data.get("message")
        if not (name and email and msg):
            return func.HttpResponse("Missing fields", status_code=400)

        body = f"Name: {name}\nEmail: {email}\nMessage: {msg}"
        sendgrid_msg.set(json.dumps({
            "personalizations": [{"to":[{"email":"davidmboli1@gmail.com"}]}],
            "from": {"email":"80da97eed946434cbef2c357fda2420e@domainsbyproxy.com"},
            "subject":"New Contact Form Message",
            "content":[{"type":"text/plain","value": body}]
        }))

        output_blob.set(json.dumps(data))

        return func.HttpResponse(json.dumps({"success": True}),
                                 status_code=200,
                                 mimetype="application/json")
    except Exception as e:
        logging.error(f"submit_form error: {e}")
        return func.HttpResponse("Internal server error", status_code=500)


