#!/bin/bash
# This script is used to backup Jenkins logs to S3 bucket
# Author : Vootla Sai Charan
# Created on 08/01/2025

#Jenkins Home Directory
JENKINS_HOME="/var/lib/jenkins"
#S3 Bucket Name
BUCKET_NAME="s3://jenkins-backup-logs"
DATE=$(date +%Y-%m-%d)

# Chek if AWS CLI is Available or Not

if ! aws --version &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if the Jenkins Installed or Not
if ! jenkins --version &> /dev/null; then
    echo "Jenkins is not installed. Please install it first."
    exit 1
fi

# checking jobs directory are present or not
for job_dir in "$JENKINS_HOME"/jobs/*/; do
    job_name=$(basename "$job_dir")

    #Iterating through all the build directories for each job
    for build_dir in "$job_dir"/builds/*/; do
        # Getting the build number
        build_number=$(basename "$build_dir")
        # Getting the log file path
        log_file="$build_dir/log"

        # Checking if the log file exists or not
        if [ -f "$log_file" ] && [ "$(date -r "$log_file" +%Y-%m-%d)" == "$DATE" ]; then
        
            # Uploading the log file to S3 bucket
            aws s3 cp "$log_file" "$BUCKET_NAME/$job_name/$build_number.log" --only-show-errors

            # if [ $? -eq 0 ]; then
            #     echo "Log file for $job_name build number $build_number uploaded successfully"
            # else
            #     echo "Failed to upload log file for $job_name build number $build_number"
            # fi

            if [ $? -eq 0 ]; then
                echo "Uploaded log file for $job_name build number $build_number to $BUCKET_NAME/$job_name/$build_number.log"
            else
                echo "Failed to upload log file for $job_name build number $build_number"
            fi
        fi
    done
done
