build:
	sudo docker build \
	  --build-arg="password=example" \
	  --build-arg="github_token=example" \
	  --build-arg="id_rsa=MQ0=" \
	  --build-arg="gpg_pub=MQ0=" \
	  --build-arg="gpg_priv=MQ0=" \
	  --tag="dev-machine:latest" .
