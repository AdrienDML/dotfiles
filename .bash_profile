#
# ~/.bash_profile
#
# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    sway --my-next-gpu-wont-be-nvidia
fi
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -f ~/.bashrc ]] && . ~/.bashrc
