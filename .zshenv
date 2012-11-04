# ~/.zshenv: user-specific file for zsh(1).
# Global Order: zshenv, zprofile, zshrc, zlogin

export GIT_CEILING_DIRECTORIES="/:/etc:/home:$HOME:$HOME/projects"

# I want to manage system-wide virtual domains when I allowed to.
groups | grep libvirt > /dev/null \
    && export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
