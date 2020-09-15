build: validate
	packer build packer.json

validate: archive_dotfiles
	packer validate packer.json

archive_dotfiles:
	tar -cvf dotfiles.tar dotfiles

install_requirements:
	# install packer
	cd $$(mktemp -d)
	curl -LO https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip
	unzip *.zip
	sudo mv packer /usr/local/bin/packer
	# install hcloud
	curl -LO https://github.com/hetznercloud/cli/releases/download/v1.19.1/hcloud-linux-amd64.tar.gz
	tar -xf hcloud-linux-amd64.tar.gz
	sudo mv hcloud /usr/local/bin/hcloud

# development commands
import_dotfiles:
	./hack/import_dotfiles.rb

# operator commands
delete_vm:
	./hack/delete_vm.rb
delete_images:
	./hack/delete_images.rb
assert_no_instances:
	./hack/assert_no_instances.rb
