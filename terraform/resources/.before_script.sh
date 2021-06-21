#!/usr/bin/env bash

export TF_VAR_aws_access_key=${{ secrets.AWS_ACCESS_KEY_ID }}
export TF_VAR_aws_secret_access_key=${{ secrets.AWS_SECRET_ACCESS_KEY }}
