# Création de la clé bootable

TODO 

# Installer la base 

## Partitionnement du disque 

1. Avoir le clavier Français 

    loadkeys fr


1. Bis: vérifier le time 

    timedatectl set-ntp true 


2. Créer les partitions avec **cfdisk**

    cfdisk /dev/sda

Puis créer 4 partitions, le boot (512M, bootable, primary), le swap (4G,primary), la partition racine (16/32G,primary), et le home (le reste, primary)

Et finir par **write**, et **quit**

3. Formater les partitions créées (**mkfs** et **mkswap**) 

    mkswap /dev/sda2
    swapon /dev/sda2

    mkfs.ext4 /dev/sda1 (boot) 
    mkfs.ext4 /dev/sda3 (root) 
    mkfs.ext4 /dev/sda4 (home)

4. Monter les partitions 

On commence par la partition root: 

    mount /dev/sda3 /mnt 

On créer les points de montage boot et home 

    mkdir /mnt/{boot,home} 

Et on les assigne 

    mount /dev/sda1 /mnt/boot 
    mount /dev/sda4 /mnt/home


## Récupérer la base de l'installation 

Important : À partir de maintenant, vous installerez les paquets dans le nouveau système monté sur /mnt. Par exemple, si vous tapez une commande du type "pacman -S nom_du_paquet", celui-ci sera installé sur le système en cours d'exécution, soit le live cd/usb. Pour installer sur le nouveau système, utilisez "pacstrap /mnt nom_du_paquet", ou attendez de chrooter dans le nouveau système.



### Récupérer les miroirs 

    vim /etc/pacman.d/mirrorlist 
    rechercher remplacer (:%s/Server/#Server) 
    puis recherche /polymorf 
    puis décommenter ligne 


### Installer la première couche 

+ Quelques outils à avoir dès le départ

    pacstrap /mnt base base-devel linux linux-firmware vim (pacman-contrib) grub os-prober 

NB: Pour faire cette install j'ai du procéder aux étapes suivantes (problèmes de keys)

    pacman-key --init 
    pacman-key --populate archlinux
    pacman-key --refresh-keys 



##  Configuration système 

1. On génère le fstab 

    genfstab -U -p /mnt >> /mnt/etc/fstab

2. On chroot dans le nouveau système 

    arch-chroot /mnt

3. On renseigne le nom de la machine 

    echo NomDeLaMachine > /etc/hostname

4. Idem dans le fichier /etc/hosts

    echo '127.0.1.1 NomDeLaMachine.localdomain NomDeLaMachine' >> /etc/hosts

5. Choisir le fuseau horaire 

    ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

6. Editer le fichier /etc/locale.gen et décommenter notre locale, puis executer 

    locale-gen

7. Ajoutez le nom de la locale au fichier /etc/locale.conf (voir locale), par exemple pour le français en UTF-8 :

    echo LANG="fr_FR.UTF-8" > /etc/locale.conf

8. Spécifier à la locale 

    export LANG=fr_FR.UTF-8

9. Éditez le fichier /etc/vconsole.conf afin d'y spécifier la disposition de clavier que vous souhaitez utiliser :

    echo KEYMAP=fr > /etc/vconsole.conf

10. Configurez /etc/mkinitcpio.conf et créez les RAMdisks initiaux avec :

    mkinitcpio -p linux



NB: Afin de pouvoir démarrer votre nouvelle installation, il est primordial d'installer (ou de reconfigurer) un bootloader sur votre machine. Référez-vous à la catégorie bootloader, choisissez le bootloader adapté à vos besoins, puis effectuez pas-à-pas son installation et sa configuration. Une fois cela fait, vous pouvez continuer et finir de lire cette page.

Dans notre cas on l'a installé avec le <pacstrap ...>

11. Pour BIOS install 

    grub-install --no-floppy --recheck /dev/sda 

12. Puis générer le fichier de config (je crois) 

    grub-mkconfig -o /boot/grub/grub.cfg 

11. Définir un mdp 

    passwd root  


Enfin installer networkmanager pour le réseeu 


    pacman -Syy networkmanager 

Et 

    systemctl enable NetworkManager


Puis pour finir, démonter et redémarrer 


    exit 
    umount -R /mnt 
    reboot 


# Installer l'environnement graphique  

## Partie commune à tous les environnements graphiques 



### Synchronisation et tâches automatiques admin 

    pacman -Syy ntp cronie

### Avoir les logs en "clair"

    vim /etc/systemd/journald.conf

et décommenter 

    ForwardToSyslog=yes 

### Son 

    pacman -Syy alsa-utils 

Puis

    alsamixer 

Mettre tout à fond, et 

    alsactl store 

### Multimedia (suite) 

    pacman -S gst-plugins--{base,good,bad,ugly} gst-libav  
    # ça marchait pas pour moi ça 

    pacman -S xorg-{server,xinit,apps} 

### Polices 

Pour installer les principales polices 

    pacman -S ttf-{bitstream-vera,liberation,freefont,dejavu} freetype2 


### Quelques outils 

    pacman -S cups gimp gimp-help-fr hplip python-pyqt5

    # imprimante (opt) 
    # pacman -S 

    pacman -S libreoffice-still-fr hunspell-fr 

    # LateX
    pacman -S texlive-most 

    # Git 
    pacman -S git 

    pacman -S chromium 


    # trizen = enrobeur pacman
    # ATTENTION A FAIRE EN TANT QU'UTILISATEUR CLASSIQUE, cad exit, puis nom_d_utilsateur 
    # voir https://www.youtube.com/watch?v=Hx-8GFBtV6I
    # pour details 
    git clone http://aur/archlinux.org/trizen 
    cd trizen 
    makepkg -sri 
    # s compiler, r enlever dépend inutiles, i installer 
 
    # ATTENTION A FAIRE EN TANT QU'UTILISATEUR CLASSIQUE 
    sudo localectl set-x11-keymap fr 


## Ajouter un utilisateur

    useradd -m -g wheel -c 'Benjamin Giradot' -s /bin/bash (ou autre) benj
    passwd benj (d...r) 


## Configurer l'accès sudo 

1. Editer /etc/sudoers

    vim /etc/sudoers

2. Uncomment la ligne en dessous de Uncomment to allow members of group ... 

3. Enregistrer quitter 

    :x (/:x!)  

## Services à activer (utilisateur classique)  

    sudo systemctl enable syslog-ng@default 
    sudo systemctl enable cronie  
    sudo systemctl enable avahi-daemon
    sudo systemctl enable ntpd



## Gnome

TODO

## Kde 

1. Changer le nom de la machine 

    vim /etc/hostname

2. Install 

    trizen -S plasma kde-applications digikam elisa kdeconnect packagekit-gt5 

NB: J'ai du faire un trizen -Syu (et -Syy ?) ensuite puis refaire la commande d'install pcq il y avait des error 404  

3. Clavier fr default 

    sudo localectl set-x11-keymap fr

4. Lancer 

    sudo systemctl start sddm 

5. (Si on veut tout le temps sddm) 

    sudo systemctl enable (disable ?) sddm 



## Xfce

TODO

### Méthode 1

1. Installer: 

    sudo pacman -S xfce4

2. Lancer: 

    startxfce4

### Méthode 2 (plus complète) 

TODO 




