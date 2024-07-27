if [ $EUID != 0 ]; then
    sudo "$0" "$@"
fi

git add config.el
git add config.org
git add init.el

git commit -m "$1"
git push
