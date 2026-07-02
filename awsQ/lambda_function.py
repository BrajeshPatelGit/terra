# Entry point invoked by API Gateway; event contains request data, context has runtime info
def handler(event, context):
    # Return a standard HTTP response with status 200 and a plain text body
    return {
        "statusCode": 200,
        "body": "Hello from Lambda!"
    }
