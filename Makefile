build:
	packer validate packer.json
	packer build packer.json

archive_dotfiles:
	tar -cvf dotfiles.tar dotfiles
