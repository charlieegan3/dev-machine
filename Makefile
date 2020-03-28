build:
	sudo docker build \
	  --build-arg="password=example" \
	  --build-arg="github_token=example" \
	  --build-arg="id_rsa=MQ0=" \
	  --build-arg="gpg_pub=$$(cat examples/example.public | base64 -w 0)" \
	  --build-arg="gpg_priv=$$(cat examples/example.private | base64 -w 0)" \
	  --tag="dev-machine:latest" .
