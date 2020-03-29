build:
	packer validate packer.json
	packer build packer.json

archive_dotfiles:
	tar -cvf dotfiles.tar dotfiles

install_packer:
	cd $(mktemp -d) && \
	curl -LO https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip && \
	unzip *.zip && \
	sudo mv packer /usr/local/bin/packer

# development commands
import_dotfiles:
	./hack/import_dotfiles.rb
