#!/bin/sh
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$registry_id".dkr.ecr."$region".amazonaws.com
#-------------Get acces to private repo in GitHub
first_url="${repo_owner}:${github_token}"
second_url=`echo ${github_url} | cut -c9-`
all_url="https://$first_url@$second_url"
echo $all_url
#-------------Clone and build
git clone $all_url
cd ${repo_dir}/app
ls -la 
docker build -t ${app_name}:${image_tag} .
docker tag ${app_name}:${image_tag} ${ecr_url}:${image_tag}
docker push ${ecr_url}:${image_tag} 
