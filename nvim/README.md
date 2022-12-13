# Set up process

1. Create a nvim file in "C:\Users\nhlan\AppData\Local\" or alternatively setup a symbolic link that points to "~\.config\nvim"

2. Install nvim Packer https://github.com/wbthomason/packer.nvim
  
  - git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim" 

3. Install dependencies

  - sccop install tree-sitter
  - sccop install lua-language-serve
  - npm i -g typescript-language-server

4. Install gcc
  
  - devdungeon.com/content/install-gcc-complier-windows-msys2-cc 


