from mangum import Mangum

from example.asgi import application

lambda_handler = Mangum(application, lifespan="off")
