#! /bin/sh

# TODO: Use a file containing list of programs
apt_install() {
	
	sudo apt-get install -qy $1
}

install_programs()
{
	programsfile=".bootstrap/programs.csv"
	while IFS=, read -r tag program comment; do
		echo "Installing $program, which $(echo $comment | sed 's/"//g')"
		case "$tag" in
			A) apt_install $program $comment ;;
			*) echo "Aborting $program, no installation candidate for tag $tag"
		esac
	done < $programsfile
}

configure_keyboard()
{
	[ -f .bootstrap/gb.bak ] && [ -f /usr/share/X11/xkb/symbols/gb ] && rm -f .bootstrap/gb.bak
	sudo mv /usr/share/X11/xkb/symbols/gb .bootstrap/gb.bak
	sudo cp .bootstrap/gb /usr/share/X11/xkb/symbols/gb
}

execute_bootstrap()
{
	configure_keyboard
	install_programs
	chsh -s $(which zsh)

	# Fix dual boot time offset
	timedatectl set-local-rtc 1 --adjust-system-clock

 	# install oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	zsh -c "git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z"
}

echo "You are on branch $(git branch --show-current)\n"
read -p "This script WILL overwrite local files. Continue (y/n)?" do_proceed

case $do_proceed in 
	y|Y) execute_bootstrap;;
	*) echo "Aborted" ;;
esac

