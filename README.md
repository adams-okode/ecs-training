# Introduction

Consul is a distributed highly available and data center aware solution to connect and Configure applications across dynamic, distributed infrasctructure.
Why Consul ?      
- Multi Datacenter Aware
- Service Mesh/ Segmentations 
- Service Discovery
- Service health Checking
- Key/Value Storage for system wide dynamic configurations                                            
  
# Concepts
- Microservices
- Containerization
- CI/CD

# Tools Used
- Docker
- AWS (ECS, EC2, ECR)
- Consul
- Spring Boot
- Github Actions

# Architecture
![Architecture](docs/consul-architecture.png)

The deployment pattern follows a a multi-cluster deployment scheme implemented on top of AWS ECS.

ECS is the AWS Docker container service that handles the orchestration and provisioning of Docker containers.

### Summary of the ECS Terms
First we need to cover some of the key ECS terminology before we get started:
- Task Definition - This a blueprint that describes how a docker container should launch. It contains settings like exposed port, docker image, cpu shares, memory requirement, command to run and environmental variables.
- Task — This is a running container with the settings defined in the Task Definition. It can be thought of as an “instance” of a Task Definition.
- Service — Defines long running tasks of the same Task Definition.
- Cluster — A logic group of EC2 instances. When an instance launches the ecs-agent software on the server registers the instance to an ECS Cluster. 
- Container Instance — This is just an EC2 instance that is part of an ECS Cluster and has docker and the ecs-agent running on it.

## Service Set up 
The project has 4 services implemented in spring-boot, these are dockerized to allow deployment on the proposed architecture. The service are language agnostic and can be implemented in framework of choice.
according to the architecture diagram Cluster 1 & Cluster 2  that run 2 services each. The clusters each run an extra service i.e. the consul agent. 
The deployment has a cluster dedicated to the ingress gateway and another for the server instances.

### Summary of Consul & Service Mesh Terms
- Consul agent - The Consul agent is the core process of Consul. The agent maintains membership information, registers services, runs checks, responds to queries, and more. The agent must run on every node that is part of a Consul cluster.

- Service Mesh - A service mesh, is a way to control how different parts of an application share data with one another. Unlike other systems for managing this communication, a service mesh is a dedicated infrastructure layer built right into an app. This visible infrastructure layer can document how well (or not) different parts of an app interact, so it becomes easier to optimize communication and avoid downtime as an app grows.

- Sidecar Service - Deploy components of an application into a separate process or container to provide isolation and encapsulation. The sidecar service handles peripheral tasks such as proxy to remote services, logging, dynamic configuration

- Ingress Gateway - An ingress Gateway describes a load balancer operating at the edge of the mesh that receives incoming HTTP/TCP connections.

# Step By Step Implementation Guide
## Cluster Definition
We should create and configure 4 ECS clusters 
1. Cluster 1 - contains S1 and S2
2. Cluster 2 - contains S3 and S4
3. Counsul Server Cluster
4. Ingress Cluster
   
   For more information on cluster creation and configuration refer to this [tutorial by Tung Nguyen](https://medium.com/boltops/gentle-introduction-to-how-aws-ecs-works-with-example-tutorial-cea3d27ce63d).

> note that this takes a multicluster approach , you do not necessarily have to run it as explained there are plenty of other approaches to consider.Using resources as defined in this guide can be quite costly to mantain, hence ensure that you subscribe to the AWS free tier if you are using this tutorial for learning purposes.

## Counsul Server Set Up
Once the Consul Server Cluster is created we should now define the consul -server-service.
First things first we need to have the consul server image on ECR. 
We'll define a custom consul image that embeds envoy proxy that consul uses to implement the sidecar on .
below is a sample customized Dockerfile of this.
```Dockerfile
ARG ENVOY_VERSION=1.14-latest

FROM envoyproxy/envoy-alpine:v${ENVOY_VERSION}

ARG CONSUL_VERSION=1.8.0

RUN mkdir -p /opt/consul  \
    && mkdir -p /etc/consul.d \
    && mkdir /var/logs \
    # This should be avoided in production instead change ownership
    && chmod -R 777 /opt/consul \
    && chmod -R 777 /etc/consul.d \
    && chmod -R 777 /var/logs

# copy config file into the the image
COPY consul.hcl /etc/consul.d/consul.hcl

# download defined version of consul and install it
RUN apk add -u bash curl && \
    wget https://releases.hashicorp.com/consul/"${CONSUL_VERSION}"/consul_"${CONSUL_VERSION}"_linux_amd64.zip \
    -O /tmp/consul.zip && \
    unzip /tmp/consul.zip -d /tmp && \
    mv /tmp/consul /usr/local/bin/consul && \
    rm -f /tmp/consul.zip
# Initialize consul agent as server based on config file
CMD [ "consul", "agent", "-config-file", "/etc/consul.d/consul.hcl" ]
```

> Consul can run as server or agent depending on initialization config i.e. server=true

below is the config file loaded as the service starts up.

```h
datacenter = "our_dc"
data_dir = "/opt/consul"
verify_incoming = false
verify_outgoing = false

bootstrap_expect = 1
ui = true
client_addr = "0.0.0.0"
server = true

ports {
  grpc = 8502
}

connect {
  enabled = true
}


bind_addr = "{{GetInterfaceIP \"eth0\"}}"

auto_encrypt = {
   allow_tls = true
}
```
Push this to ECR and define task definition for this 
below is asample of task definition withj exporsable ports as well a volume mount-points.
>Please do not blindly copy paste, rather map settings according to your defined task
```json
{
    "ipcMode": null,
    "executionRoleArn": "arn:aws:iam::{user-id}:role/{role}",
    "containerDefinitions": [
        {
            "dnsSearchDomains": null,
            "environmentFiles": null,
            "logConfiguration": {
                "logDriver": "awslogs",
                "secretOptions": null,
                "options": {
                    "awslogs-group": "/ecs/consul-ecs-builder",
                    "awslogs-region": "eu-west-1",
                    "awslogs-stream-prefix": "ecs"
                }
            },
            "entryPoint": null,
            "portMappings": [
                {
                    "hostPort": 8300,
                    "protocol": "tcp",
                    "containerPort": 8300
                },
                {
                    "hostPort": 8301,
                    "protocol": "tcp",
                    "containerPort": 8301
                },
                {
                    "hostPort": 8301,
                    "protocol": "udp",
                    "containerPort": 8301
                },
                {
                    "hostPort": 8501,
                    "protocol": "tcp",
                    "containerPort": 8501
                },
                {
                    "hostPort": 8502,
                    "protocol": "tcp",
                    "containerPort": 8502
                },
                {
                    "hostPort": 8500,
                    "protocol": "tcp",
                    "containerPort": 8500
                },
                {
                    "hostPort": 8600,
                    "protocol": "tcp",
                    "containerPort": 8600
                },
                {
                    "hostPort": 21000,
                    "protocol": "tcp",
                    "containerPort": 21000
                }
            ],
            "command": [],
            "linuxParameters": null,
            "cpu": 0,
            "environment": [],
            "resourceRequirements": null,
            "ulimits": null,
            "dnsServers": null,
            "mountPoints": [
                {
                    "readOnly": null,
                    "containerPath": "/opt/consul",
                    "sourceVolume": "consul"
                }
            ],
            "workingDirectory": null,
            "secrets": null,
            "dockerSecurityOptions": null,
            "memory": null,
            "memoryReservation": 150,
            "volumesFrom": [],
            "stopTimeout": null,
            "startTimeout": null,
            "firelensConfiguration": null,
            "dependsOn": null,
            "disableNetworking": null,
            "interactive": null,
            "healthCheck": null,
            "essential": true,
            "links": null,
            "hostname": null,
            "extraHosts": null,
            "pseudoTerminal": null,
            "user": null,
            "readonlyRootFilesystem": null,
            "dockerLabels": null,
            "systemControls": null,
            "privileged": null,
            "name": "consul-server"
        }
    ],
    "placementConstraints": [],
    "memory": null,
    "taskRoleArn": "arn:aws:iam::{user-id}:role/{role}",
    "compatibilities": [
        "EC2"
    ],
    "taskDefinitionArn": "arn:aws:ecs:eu-west-1:{user-id}:task-definition/consul-ecs-builder:26",
    "family": "consul-ecs-builder",
    "requiresAttributes": [

    ],
    "pidMode": null,
    "requiresCompatibilities": [
        "EC2"
    ],
    "networkMode": "host",
    "cpu": null,
    "revision": 26,
    "status": "ACTIVE",
    "inferenceAccelerators": null,
    "proxyConfiguration": null,
    "volumes": [
        {
            "efsVolumeConfiguration": null,
            "name": "consul",
            "host": {
                "sourcePath": null
            },
            "dockerVolumeConfiguration": null
        }
    ]
}
```
Consul will communicate to agents on the eth0 interface which provides host IP on the registered vpc this is evident from;

```h 
bind_addr = "{{GetInterfaceIP \"eth0\"}}"
``` 

It is crucial to ensure that you run your task in host network mode or use vxLan to allow the consul container access other hosts within the network.

Create an ECS service to run the tasks automatically. Once the tasks are active you should be able to view the cosul dashboard by accessing the node IP on port 8500 
http://ip:8500/

![consul](https://learn.hashicorp.com/img/consul-services.png)


