#!/bin/bash
set -e

PROJECT_ID=$(gcloud config get-value project)

gcloud storage buckets create gs://${PROJECT_ID}-terraform --location=${REGION} --public-access-prevention --uniform-bucket-level-access
gcloud iam service-accounts create terraform --display-name="Terraform Service Account" --description="Service account used to deploy TF resources in the project"
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com" --role="roles/owner"
gcloud iam workload-identity-pools create ${WIF} --location="global" --display-name="Github pool" --description="Workload Identity Pool for github"
gcloud iam workload-identity-pools providers create-oidc ${WIF} --location="global" --workload-identity-pool=${WIF} --display-name="Github" --description="Workload Identity Pool provider for github" --attribute-mapping="google.subject=assertion.sub, attribute.repository=assertion.repository, attribute.ref=assertion.ref" --issuer-uri="https://token.actions.githubusercontent.com"
gcloud iam service-accounts add-iam-policy-binding terraform@${PROJECT_ID}.iam.gserviceaccount.com --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/${WIF}/attribute.repository/${REPO}" --role="roles/iam.workloadIdentityUser"