# personal repos and directories

# folders and config
function omoi { cd "$env:maindir\omoi" }
function conf { cd "$env:dotfiles" }

# repo
function o_git { omoi; cd "git" }
function o_site { o_git; cd "portfolio\" }


