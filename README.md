### Introduction
Sample project for developing and testing lambda function, it will launch a virtualbox which contains all necessary tools for AWS Lambda function. It also leverage AWS Serverless Application Model(https://github.com/awslabs/aws-sam-cli) to test and deploy lambda function.

### Environment preparation
Please install and setup following tools for the preparation
1. git <https://git-scm.com>
2. Vagrant <https://www.vagrantup.com>
3. VirtualBox <https://www.virtualbox.org>
4. UP and Enter vagrant development environment 
    * `cd lambda-development-environment`
    * `vagrant up`
    * `vagrant ssh`

## [In Vagrant] Working directory and permissions
The working directory is `/vagrant`, and due to the docker requires specified permission to execute, you can 
1. switch to root user `sudo su -` 
2. or add `sudo` in front of all further commands.

## [In Vagrant] Build instructions
Ecexute `./build.sh` and then pack all files under src

## [In Vagrant] Testing from local
sam local invoke "SamExample" -e event.json

## [In Vagrant] Assign environment variables in testing
Method 1 -
Update the environment varible in template.yaml
Method 2 - 
WORKENV=dev sam local invoke "SamExample" -e event.json

## [In Vagrant] Tutorial for the sample function
1. The sample code in this repository, it contains a Lambda function which would import numpy for print a matrix.

2. Let's start from the template.yaml, there is only one function in it. And it will try to launch lambda_handler in src/lambda_function.py
```
Resources:
  # Lambda Function name
  SamExample:
    Type: 'AWS::Serverless::Function'
    Properties:
      # Execute path
      Handler: lambda_function.lambda_handler
```
3. Before we build the numpy packages, let's directly run `sam local invoke "SamExample" -e event.json`. Then it start to fetch a docker container which is using to simulate AWS Lambda function, and then show following error message while import numpy
```
START RequestId: 9b312306-d632-463b-b8cc-435a9a45017a Version: $LATEST
Unable to import module 'lambda_function': No module named 'numpy'
END RequestId: 9b312306-d632-463b-b8cc-435a9a45017a
REPORT RequestId: 9b312306-d632-463b-b8cc-435a9a45017a Duration: 5 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 19 MB

{"errorMessage": "Unable to import module 'lambda_function'"}
```
4. For reslove the package issue, let's run the script `./build.sh` to build the packages, it will refer to the file requirements.txt to download and compile packages in directory `src`, and delete unnecessary files.

5. Run `sam local invoke "SamExample" -e event.json` again, it should works well now.
```
START RequestId: e128485e-119a-4207-a154-1cb88de380e3 Version: $LATEST
Use config: default
[[ 0  1  2  3  4]
 [ 5  6  7  8  9]
 [10 11 12 13 14]]
END RequestId: e128485e-119a-4207-a154-1cb88de380e3
REPORT RequestId: e128485e-119a-4207-a154-1cb88de380e3 Duration: 479 ms Billed Duration: 500 ms Memory Size: 128 MB Max Memory Used: 35 MB

"Success"
```
