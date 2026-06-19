#!/bin/bash

apt update -y

apt install curl unzip -y

curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh

bash wazuh-install.sh -a





#!/bin/bash

##############################################
# Update System
##############################################

apt-get update -y
apt-get upgrade -y

##############################################
# Install AWS CloudWatch Agent
##############################################

wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

dpkg -i amazon-cloudwatch-agent.deb

##############################################
# Create CloudWatch Configuration
##############################################

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/

cat <<EOF >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

{
    "agent": {
        "metrics_collection_interval": 60,
        "run_as_user": "root"
    },

    "logs": {

        "logs_collected": {

            "files": {

                "collect_list": [

                    {

                        "file_path": "/var/log/syslog",

                        "log_group_name": "/enterprise/devsecops",

                        "log_stream_name": "{instance_id}/syslog"

                    },

                    {

                        "file_path": "/var/log/auth.log",

                        "log_group_name": "/enterprise/devsecops",

                        "log_stream_name": "{instance_id}/auth"

                    },

                    {

                        "file_path": "/var/ossec/logs/ossec.log",

                        "log_group_name": "/enterprise/devsecops",

                        "log_stream_name": "{instance_id}/wazuh"

                    }

                ]

            }

        }

    }

}

EOF

##############################################
# Enable CloudWatch Agent
##############################################

systemctl enable amazon-cloudwatch-agent

systemctl restart amazon-cloudwatch-agent

##############################################
# Start Agent
##############################################

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
-s