#!/bin/bash

python -m uvicorn $ASGI_APPLICATION --port 8080
