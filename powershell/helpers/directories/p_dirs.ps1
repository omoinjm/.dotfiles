# personal repos and directories

# folders and config
function omoi { cd "$env:maindir\omoi" }
function o_dev { omoi; cd "development" }
function conf { cd "$env:dotfiles" }

# repo
function o_git { o_dev; cd "git\" }
function o_site { o_git; cd "portfolio\" }


