# Code Structure
```
├─ cicd
│  │
│  └─ infra
│     ├─ data.tf
│     ├─ main.tf
│     ├─ outputs.tf
│     ├─ provider.tf
│     ├─ remotestate.tf
│     ├─ terraform.tfvars
│     ├─ variables.tf
│     └─ versions.tf
├─ modules
│  ├─ setup_ecr
│  │  ├─ main.tf
│  │  ├─ outputs.tf
│  │  ├─ variables.tf
│  │  └─ versions.tf
│  ├─ setup_ecs
│  │  ├─ alb_backend.tf
│  │  ├─ alb_frontend.tf
│  │  ├─ data.tf
│  │  ├─ main.tf
│  │  ├─ services.tf
│  │  ├─ tasks.tf
│  │  ├─ variables.tf
│  │  └─ versions.tf
│  └─ setup_vpc
│     ├─ main.tf
│     ├─ outputs.tf
│     ├─ variables.tf
│     └─ versions.tf
└─ cicd
   ├─ app
   │  ├─ backend
   │  │  ├─ AWSCLIV2.pkg
   │  │  ├─ Dockerfile
   │  │  ├─ config.js
   │  │  ├─ index.js
   │  │  ├─ package-lock.json
   │  │  └─ package.json
   │  └─ frontend
   │     ├─ .gitignore
   │     ├─ Dockerfile
   │     ├─ package-lock.json
   │     ├─ package.json
   │     └─ start_app.sh
```


# Overview
This repository contains a React frontend, and an Express backend that the frontend connects to.

# Objective
Deploy the frontend and backend to somewhere publicly accessible over the internet. The AWS Free Tier should be more than sufficient to run this project, but you may use any platform and tooling you'd like for your solution.

# Code source and links
1. Github Repo: https://github.com/hvprash/prash-cicd
2. Jenkins: http://ec2-3-237-191-1.compute-1.amazonaws.com:8080/
3. Deployed App URL : http://lightfeather-frontend-1699696571.us-east-1.elb.amazonaws.com:3000/

# What this code does ?:
Create Dockerfile for the frontend and backend services and artifacted in ECR.

Used Terraform for provisioning the following infrastructure resources
   - Create VPC, Public Subnets, Internet Gateway and Routing tables in AWS
   - Create ECR repos for storing the lightfeather frontend and backend docker images
   - Setup ECS cluster with Fargate for provisioning the containers
   - Create ECS task for frontend and backend services
   - Create ECS service and associate them to the tasks
   - Create Application Loadbalancer for the Frontend and Backend service
   - During ECS task initiation, load balancer FQDNS are provided as environment variables into docker to update `frontend/src/config.js` and `backend/config.js`

# Usage
Setup `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

```
$ cd cicd/infra
$ terraform plan
$ terraform apply
```

   