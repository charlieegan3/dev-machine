build: validate
	packer build packer.json

validate: install_requirements archive_dotfiles
	packer validate packer.json

archive_dotfiles:
	tar -cvf dotfiles.tar dotfiles

install_requirements:
	cd $$(mktemp -d)
	curl -LO https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip
	unzip *.zip
	sudo mv packer /usr/local/bin/packer

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
