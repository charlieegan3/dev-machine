build:
	sudo docker build \
	  --build-arg="password=example" \
	  --build-arg="github_token=example" \
	  --build-arg="id_rsa=MQ0=" \
	  --tag="dev-machine:latest" .
