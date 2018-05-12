#!/bin/bash
#Build and prepared required packages from docker
echo "Step (1/3) - Build packages"
docker run -v "$PWD/src":/var/task \
           -v "$PWD/requirements.txt":/tmp/requirements.txt \
           -it lambci/lambda:build-python3.6 pip install -r /tmp/requirements.txt -t .
echo "Step (2/3) - Cleanup __pycache__"
docker run -v "$PWD/src":/var/task \
           -v "$PWD/requirements.txt":/tmp/requirements.txt \
           -it lambci/lambda:build-python3.6 find -name __pycache__ -type d -exec rm \-rf {} \;
echo "Step (3/3) - Cleanup *-info"
docker run -v "$PWD/src":/var/task \
           -v "$PWD/requirements.txt":/tmp/requirements.txt \
           -it lambci/lambda:build-python3.6 find -name \*-info -type d -exec rm \-rf {} \;
