[
  {
    "name": "${app_name}-${env}-app",
    "image": "${ecr_url}:${image_tag}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "environment": [
      {
        "name": "VERSION",
        "value": "${image_tag}"
      }
    ]
  }
]
