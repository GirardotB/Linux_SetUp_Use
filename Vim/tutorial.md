# (Tutorial) Installer et configurer neovim 

## Installer 

+ Soit par les dépôts officiels 

        $ sudo apt-get install neovim

+ Soit par le PPA stable 
    
        $ sudo add-apt repository ppa:neovim-ppa/stable

## Configurer 

### General setting 

Dans le init.vim (~/.config/nvim/init.vim) 


#### Color themes 

Deux assez sympas: 

- onedark (https://github.com/joshdick/onedark.vim) 
- gruvbox (https://github.com/morhetz/gruvbox)

Puis (pour gnome-terminal) rightClick -> preferences -> profils -> onedark. 

#### Polices 

Avec onedark (colortheme) + inconsolata ça fit pas mal Atom style. 

	$ sudo apt-get install fonts-inconsolata 
	$ sudo fc-cache -fv 

Puis aller dans préférences (si gnome-terminal) -> polices 

Pour les pluggins, vim-plug (voir References) conseillé.

### vim-plug (gestionnaire de pluggins)
	
	$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Puis éditer le fichier de config 

	$ vim ~/.config/nvim/init.vim 

Et remplir de cette façon: 

	call plug#begin('~/.config/nvim/plugged')
	
	" one solution is simply (here for supertab) 
	Plug 'https://github.com/ervandew/supertab' 

	call plug#end() 

Voir dans init.vim pour les pluggins utiles à installer 

#### YouCompleteMe (YCM)

Un peu plus compliqué pour YCM: 

	$ sudo apt install build-essential cmake python3-dev
	$ cd ~/.config/nvim/plugged/YouCompleteMe
	$ python3 install.py --clang-completer

De plus, nécessite supertab et ultisnipps pour fonctionner de façon sympa.  

#### Fugitive (Git wrapper): comment l'utiliser ? 

à compléter 



# References 

- https://damien.pobel.fr/post/vim-neovim/
- https://launchpad.net/~neovim-ppa/+archive/ubuntu/stable
- https://github.com/junegunn/vim-plug
- https://github.com/ycm-core/YouCompleteMe
- https://askubuntu.com/questions/988083/inconsolata-font-doesnt-show-up-on-terminal-preferences
- https://vimawesome.com/plugin/fugitive-vim

Pour aller plus loin: 
- https://github.com/neovim/neovim/wiki/Related-projects#plugins



