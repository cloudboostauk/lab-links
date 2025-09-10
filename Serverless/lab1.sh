def lambda_handler(event, context):
    if event ['name'] == "Cloudboosta":
        return "I am a Cloudboosta Student!"
    else:
        return f"I am {event.get('name')} Student!"