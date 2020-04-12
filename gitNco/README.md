# Git tutorial 

**Largely inspired from** https://git-scm.com/book/en/v2 

De l'aide sur git ? 

	git help <commande>
	git <commande> --help 
	man git-<commande> 


# Rudiments de Git 

Ce qui différencie Git des autres VCS (Version control system), c'est la façon dont Git considère les données: des instatanés, et pas des différences ($\delta 1$). 

Presque toutes les opérations sont locales, donc généralement aucune information venant du réseau n'est nécessaire. 

**Les trois états** de Git: 

+ Validé (répertoire Git) 

+ modifié (répertoire de travail)

+ indexé (staging area/zone d'index)

L'utilisation standard de Git se passe donc comme suit: 

1. On modifie des fichiers dans notre repertoire  de travail 

2. On indexe les fichiers modifiés, ce qui ajoute des instantanés des fichiers modifiés dans la zone d'index 

3. On valide, ce qui bascule les instantanés de ces fichiers dans la base de données du repertoire Git


## Paramétrage à la première utilisation de Git 

Git contient un outil (**git config**) qui permet de voir et modifier toutes les variables de configuration qui contrôlent tous les aspects de l'apparence et du comportement de Git. 

3 niveaux: super-utilisateur (/etc/gitconfig ; option --system à git config), utilisateur (~/.gitconfig ; option --global), et repertoire Git spécifique (.git/config)

Chaque niveau surcharge bien entendu le niveau le plus bas. 

### Renseigner son identité 

On va donc ici modifier au niveau de l'utilisateur: 

	git config --global user.name "Nom Prenom"
	git config --global user.email email@toto.fr 

### Vérifier les paramètres 

	git config --list 
	git config <paramètre>


## Démarer un dépôt Git (indispensable) 

Pour démarrer un dépôt Git, deux manières s'offrent à nous: 

1. Prendre un projet ou repertoire existant et l'importer dans Git 

2. Cloner un dépôt Git existant sur un autre serveur 

### Initialisation d'un dépôt dans un repertoire existant

Tout simplement se positionner dans le repertoire du projet, et saisir: 

	git init 

Cela a pour effet de créer un sous repertoire nommé .git (là où il y a notamment le fichier de config mentionné plus haut) qui contient tous les fichiers nécéssaires au dépôt. 

Si on souhaite démarrer un contrôle de version sur les fichiers déjà existants dans le repertoire (s'il n'est pas vide, donc), on doit **suivre** (add) ces fichiers et faire un **commit** initial (commit): 

	git add *.c 
	git add LICENCE 
	git commit -m 'initial project version'

### Cloner un dépôt existant 

	git clone [url] nom_de_mon_repo 

## Enregistrer des modifications dans le dépôt

On a à présent un dépôt git valide et une extraction ou copie de travail du projet. On doit faire quelques modifications et valider des instantanés de ces modifications dans notre dépôt chaque fois que notre projet atteint un état que nous souhaitons enregistrer. 

Il faut se rappeler les états que chaque fichier dans notre copie de travail peut avoir: 

+ sous suivi de version (fichiers qui appartenaient déjà au dernier instantané). Ces fichiers peuvent être inchangés, modifiés ou indexés. 

+ non suivis (tout fichiers de la copie de travail qui n'appartenait pas au dernier instantané et qui n'a pas été indexé). 

Au fur et à mesure qu'on édite des fichiers, Git les considère comme *modifiés*. On *indexe* alors ces fichiers modifiés, puis en enregistre (*commit*). Puis le cycle se répète. 

### Vérifier l'état des fichiers 

L'outil principal pour déterminer quels fichiers sont dans quel état. 

	git status 

### Placer de nouveaux fichiers sous suivi de version 

	git add fichier(s) 

Ces fichiers seront alors indexés ("Modifications qui seront validées")
Si on veut annuler: 
	git reset HEAD <fichier>  

Une fois indexés, si on les modifies encore, les fichiers apparaitront en indexés et non indexés. Si on commit, ce sera la version indexée qui sera envoyée. 

Pour un git status moins verbeux, faire git status -s (--short): 

+ ??: fichiers non suivis 
+ A: nouveaux et indexés 
+ M: modifié

Il y a deux colonnes (gauche correspond à l'état de l'index, et droite au répertoire de travail). 

### Ignorer des fichiers 

Pour énumérer les patrons de fichiers à ignorer (exemple les logs, les .mat dans mon cas, etc.); on édite le fichier .gitignore: 

	cat .gitignore 
	*.[oa]
	*~ 

Par exemple, ici les fichiers se terminant par .o ou .a (objets ou archives) sont ignorés.
La seconde ligne quand à elle ignore les fichiers se terminant par un tilde (temporaires par exemple, les swaps). 

Le fichier .gitignore est à créer avant de commencer à travailler sur un dépôt. 

On peut travailler sur un fichier gitignore global 
        
    vim ~/.gitignore_global 

et le prendre en compte avec 

    git config --global core.excludesfiles ~/.gitignore_global


Quelques règles de constructions des patrons dans .gitignore: 

+ lignes vides ou commençant par # sont ignorées 
+ les patrons standards de fichiers sont utilisables 
+ si le patron se termine par une barre oblique (/) il indique un repertoire 
+ un patron commençant par ! indique des fichiers à inclure malgé les autres règles 

Les patrons standards sont des expressions régulières utilisées par les shells. Ainsi, un astérisque correspond à un ou plusieurs caractères ; [abc] correspond à un des trois caractères listés dans les crochets (a ou b ou c) ; un ? correspond à un unique caractère ; des crochets entourants des caractères séparés par un tiret [0-9] correspond à un caractère dans l'intervalle des deux caractères indiqués ; deux astérisques pour une série de répertoires inclus. 

Exemples de .gitignore 

	*.mat 
	!toto.mat 
	
	# ignorer uniquement le fichier todo à la racine du projet 
	/todo 

	# ignorer tous les fichiers dans le repertoire build 
	build/ 

	# ignorer doc/notes.txt mais pas doc/server/arch.txt 
	doc/*.txt 

	# ignorer tous les .txt sous le repertoire doc/ 
	doc/**/*.txt 

### Inspecter les modifications indexées et non indexées 

Quand on veut savoir ce qui a changé dans les fichiers, on fait: 
	git diff 
	git diff --staged 

La première pour visualiser les modifications non indexées, la seconde pour les modifications indexées 

### Valider les modifications 

La fammeuse, 

	git commit 

A faire une fois que la zone d'index est dans l'état désiré. 

Cette commande lance l'éditeur par défault (vim), paramétré par la variable d'environnement $EDITOR ($) du shell. On peut aussi le configurer spécifiquement pour Git (git config --global core.editor). 
On nous demande alors de saisir le message justifiant le commit. 

On peut aussi faire: 
	git commit -m 'message justifiant le commit'

### Skip l'étape de mise en index 

Bien que l'étape de zone d'index soit importante et utile, il est possible de la skip, en faisant: 

	git commit -a 

Cette commande ordonne à Git de placer automatiquement tout fichier déjà en suivi de version dans la zone d'index avant de réaliser la validation, évitant ainsi d'avoir à tapper les commandes git add. 

### Effacer des fichiers 

Pour effacer un fichier de Git, on doit l'éliminer des fichiers en suivi de version (plus précisement l'effacer dans la zone de d'index) puis valider. 
Pour cela, la commande: 

    git rm 

Si on efface simplement le fichier dans la zone de travail, il apparaîtra sous la section "modifications qui ne seront pas validées" (cad non indexé) dans le résultat de git status. 

C'est pour ça qu'il faut l'enlever de la zone d'index avec **git rm** 

Si on l'a auparavant modifié et indexé, son élimination doit être forcée avec l'option -f. C'est un sécurité pour empêcher un effacement accidentel de données qui n'ont pas encore été enregistrées dans un instantané.

Un autre scénario possible serait de vouloir abandonner le suivi de version d'un fichier tout en le conservant dans la copie de travail. 
Utile si par exemple on a oublié de spécifier un patron dans .gitignore et qu'on a accidentellement indexé un fichier, tel qu'un gros fichier de journal ou une série d'archives de compilation .a. 
Pour réaliser ce scénario, on utilise l'option --cached 

	git rm --cached LISEZMOI

On peut aussi spécifier des noms de fichiers ou repertoires, ou des patrons de fichiers à la commande *git rm*. 
	
	# cette commande efface tous les fichiers avec l'extension .log présents dans le repertoire log/ 
	git rm log/\*.log 

	# élimine les fichiers se terminant par ~ 
	# pas besoin normalement si .gitignore bien configuré 
	git rm \*~ 

L'antislash est nécessaire pour échapper le caractère * car Git utilise sa propre expansion de nom de fichier en addition de l'expansion du shell. 


### Déplacer des fichiers 

Git ne suit pas explicitement les mouvements des fichiers (aucune méta-donnée indiquant le renomamge n'est stockée par Git). Mais Git est assez malin pour s'en apercevoir après coup (la détection de mouvement de fichier est traitée plus bas). 

De ce fait, que Git ait une commande *mv* peut paraître trompeur. 
Si on veut renommer un fichier dans Git, on peut faire: 

	git mv nom_initial nom_final 

ce qui est en fait équivalent à: 

	mv nom_initial nom_final
	git rm nom_initial 
	git add nom_final 

Un *git status* permet ensuite de voir que Git gère le renommage de fichier. Il suffit de commit ensuite (sur fichier suivi). 

## Visualiser l'historique des validations 

Revoir le fil des évènements: 

	git log 

Quelques options de *log*: 

+ -p (montre les différences introduites entre chaque validation) -2 (limite aux entrées les plus récentes)

+ --stat (liste des fichiers modifiés, combien de fichiers changés et combien de lignes ajoutées/retirées) 

+ --pretty=oneline/format:"%h - %an, %ar : %s" (d'autres options pour format utiles notamment pour séparer l'auteur du validateur, à creuser). 

+ --graph (à combiner avec oneline et format), surtout utile quand il y a les branches. 

## Annuler des actions 

**Premier scenario**: on valide une modification (commit) mais on réalise qu'on a oublié d'indexé quelque chose. Pas de panique ! *git commit -ammend* 

	git commit -m 'validation étourdite'
	git add fichier_oublie 
	git commit -amend 

**Deuxième scenario**: on veut valider deux modifications indépendantes, mais on a indexé les deux avec par exemple un git add *  ( * ). Comment faire ? 

En fait, le git status nous le rappelle: 
	
	git reset HEAD <fichier>. 

**Troisième scenario**: on a commit, mais on veut revenir en arrière. Comment faire ? Comment revenir à l'état du dernier instantané ? (ou lors du clonage, ou dans l'état dans lequel on a obtenu la copie de travail). 

Encore une fois, le git status nous renseigne: 
	
	git checkout -- <fichier> ... 

Si l'on souhaite seulement écarter momentanément cette modification, la meilleure solution est de créer des **branches**. 

## Travailler avec des dépôts distants 

Collaborer avec d'autres personnes consiste à gérer des dépôts distants, en poussant ou tirant des données depuis et vers ces dépôts quand vous souhaitez partager votre travail. 
Gérer des dépôts distants implique donc de savoir comment en ajouter, en effacer (plus valides), gérer des branches distantes et les définir comme suivies ou non, et plus encore. 

### Afficher les dépôts distants 

Pour visualiser les seveurs distants que l'on a enregistré, on fait 

	git remote 

Si l'on a cloné un dépôt, on voit au moins l'origine **origin**. 
L'option -v permet de voir l'url que Git a stockée 

### Ajouter des dépôts distants 

	git remote add [nom court] [url] 

Alors, de ce que j'ai compris (à confirmer), la différence avec git clone c'est qu'on a besoin d'un détôt Git existant pour faire cette commande, et ça rajoute juste une entrée à notre config Git qui spécifie un nom pour une URL particulière (d'un autre auteur/collaborateur du coup). 

Exemple: d'abord, on clone un dépôt: 

	git clone https://github.com/schacon/ticgit 

Ensuite, on ajoute un dépôt distant (collaborateur=paul): 

	git remote add pb https://github.com/paulboone/ticgit 

Maintenant, si l'on veut récupérer l'information que Paul (pb) a, mais que n'on ne souhaite pas (encore en tout cas) l'avoir dans notre branche, on fait: 

	git fetch pb

Il faut noter que *fetch* tire les données dans notre dépôt local mais sous sa propre brtanche, elle ne les fusionne pas automatiquement avec aucun de nos travaux ni ne modifie notre copie de travail.

Si on a créer une branche pour suivre l'évolution d'une branche distante, on peut utiliser la commande **git pull** qui récupère et fusionne automatiquement une branche distante dans votre branche locale.

### Pousser son travail sur un dépôt distant 

	git push [nom-distant] [nom-de-branche] 

Exemple: si on veut pousser notre branche master vers le serveur origin (pour rappel, cloner un dépôt définit automatiquement ces noms pour nous), alors on peut faire: 

	git push origin master 

Cette commande ne fonctionne qui si on a cloné depuis un serveur sur lequel on a les droits d'accès en écriture et si personne n'a poussé dans l'interval bien entendu. 

### Inspecter un dépôt distant 

	git remote show [nom-distant]

Cela donne la liste des URL pour le dépôt distant ainsi que la liste des branches distantes suivies. 

Utilisation plus utilise quand utilisation plus intense de Git. 

### Retirer et renommer des dépôts distants 

On peut modifier le nom court d'un dépôt distant, e.g.: 

	git remote rename pb paul





### Maintenir un fork synchronisé 

**Différence entre un clone et un fork**

    Initialement, un fork est un projet que l'on copie dans le but d'en développer une version divergente indépendante. Donc pas d'intentions de contribuer au projet initial. Un clone est le contraire, on le copie dans le but de contribuer au projet
    Mais GitHub a un peu bouleversé ces signications et le mot fork est en fait davantage l'équivalent d'un clone... 
    Car l'action de fork qqchose sous github correspond en réalité à l'action de cloner un projet. 
    Pour plus de détails, voir (Références). 

Tout d'abord ajouter le dépôt d'origine sur lequel on a forké (upstream) : 

	git remote add upstream <url> 

Puis 

	git fetch upstream 

Et enfin 

	git merge upstream/master 


Rappel: pour pousser nos modifs, on doit faire un push origin master sur le fork, et ensuite si on veut que ce soit sur le dépôt d'origine, 
on fait un pull-request 






## Etiquetage 

Possibilité d'étiqueter un certain état dans l'historique comme important. 

### Lister les étiquettes

	$ git tag 
	v0.1
	v1.3 

Si on veut rechercher un motif particulier: 

	git tag -l 'v1.8.5*'


### Créer des étiquettes 

Il y a deux types principaux d'étiquettes: légères et annotées. 

**Légères**: 

Juste un pointeur sur un commit spécifique 

Pour en créer, juste git tar (sans options -a/s/m) 
Donne uniquement la somme de contrôle d'un commit. 

**Annotées**: 

Stockées en tant qu'objets à part entière dans la base de données de Git. Elles ont une somme de contrôle, contiennent le nom, l'adresse e-mail, la date, etc.

Comment en créer ? 

	git tag -a v1.4 -m 'ma version 1.4'
	git tag 
	v0.1
	v1.3
	v1.4

On peut ensuite visualiser les donées de l'étiquette à côté du commit qui a été marqué, en utilisant: 

	git show v1.4 


### Etiquetter après coup 

On peut aussi étiqueter des commits anciens. Pour cela, déjà un petit git log --pretty=oneline, on récupère le début de la somme de contrôle (hexadécimale harcdcore) du commit, et on la met en fin de commande: 

	git tar -a v1.2 9fg1g2ec...  

### Partager les étiquettes 

Par défault, git push ne transfère pas les étiquettes vers les serveurs distants. Ainsi, si on les pousser, il faut le spécifier.

Si on veut envoyer uniquement quelques étiquettes: 

	git push origin [nom-du-tag] 

Si on veut toutes les envoyer: 

	git push --tags 

## Les alias Git

Se fait avec le git config / quelques exemples: 

	git config --global alias.co checkout 
	git config --global alias.br branch 
	git config --global alias.ci commit 
	git config --global alias.st status

Simplifier le desindexage: 

	git config --global alias.unstage 'reset HEAD --' 

,ce qui rend les commandes suivantes équivalentes: 
	
	git unstage file
	git reset HEAD file 

Pour visualiser rapidement le dernier commit 
	
	git config --global alias.last 'log -1 HEAD' 


# Les branches avec Git 

## Les branches en bref 

Git gère les branches de manière extremement légère, ce qui permet à Git de préconiser une utilisation fréquentes des branches, jusqu'à plusieurs fois par jour. 
Pour comprendre comment les branches fonctionnent, il faut comprendre comment Git stocke ses données. 
Bonne description avec schémas sur le site de la doc. 
Ce qu'il faut retenir c'est que ça ne coûte quasiment rien en mémoire de créer une branche, à la différence des autres VCS qui doivent copier les repertoires etc.

Une branche Git n'est en réalité qu'un simple fichier contenant les 40 caractères de l'empreinte SHA-1 (voir premier chapitre) du commit sur lequel elle pointe. 

### Créer une nouvelle branche 

	git branch test

### Basculer sur une branche 

	git checkout test 
	git checkout -b test # pour basculer directement dessus 

## Branches et fusions (merges) 

Prenons un exemple simple faisant intervenir des branches et des fusions (merges) que vous pourriez trouver dans le monde réel. Vous effectuez les tâches suivantes :

vous travaillez sur un site web ;

vous créez une branche pour un nouvel article en cours ;

vous commencez à travailler sur cette branche.

À cette étape, vous recevez un appel pour vous dire qu’un problème critique a été découvert et qu’il faut le régler au plus tôt. Vous faites donc ce qui suit :

vous basculez sur la branche de production ;

vous créez une branche pour y ajouter le correctif ;

après l’avoir testé, vous fusionnez la branche du correctif et poussez le résultat en production ;

vous rebasculez sur la branche initiale et continuez votre travail.

Comment ça se traduit en ligne de commande ? 

	git co -b branche_de_travail 
	vim fichier_de_modif 
	git commit -a -m "ajouts de modifs"

	git co master 
	git co -b correctif # on créer une autre branche pour corriger le problème 
	vim index.html # on fait les modifs 
	git commit -a -m "correction de ..."
	
	git co master # on repasse sur la master 
	git merge correctif # on merge 
	# ça merge en "fast-forward" ; en gros les deux branches ont en ancetre commum
	git branch -d correctif # on la supprime puisqu'elle ne sert plus à rien vu que la bche master est la mm  

	git co branche_de_travail 
	# on finit le travail 
	git commit -a -m "fini le travail"
	git co master 
	git merge branche_de_travail 
	# ça merge en "recursive" ; en gros il y a eu des modifs sur master par rapport à branche_de_travail  
	git branch -d branche_de_travail 

Encore une fois, voir les schemas sur le site pour les situations un peu plus complexes. 

Il peut aussi y avoir des conflits de fusion. 

## Gestion des branches 

La commande **branch** permet bien plus qu'uniquement la création, fusion, etc, des branches.

	git branch (sans argument) 

permet de lister les branches présentes (la branche courante est marquée d'un * ). 

	git branch -v 

pour connaître les derniers commits sur chaque branche (sûrement possiblité d'obtenir plus d'infos). 

	git branch --(no-)merged 

pour voir quelles branches ont déjà(pas encore) été fusionnées avec la branche courante.

### Travailler avec les branches

Souvent de fonctionner en 3 étapes : une branche master, une branche développement (qui sera mergée avec master quand nécessaire/satisaits) et de mutliples branches catérogies/topic qui traitent de développements particuliers, et qui sont mergés avec developpemement. 

+ branche master 

+ branche develop 

+ branche topic_subject

## Branches de suivi à distances 

à remplir ... 






# GitHub 

## Créer des répositories 

### Create a new repository on the command line
        
    echo "# Titre-" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git remote add origin https://github.com/GirardotB/repertoire-au-prealablement_cree.git
    git push -u origin master

### Push an existing repository from the command line
    
    git remote add origin https://github.com/GirardotB/test-.git
    git push -u origin master 


### Script qui permet de créer un new repo sur GitHub en ligne de commande 

Les deux méthodes décrites plus haut sont toujours nécessaires ensuite pour "remplir" ce nouveau répertoire créer sur le compte GitHub

à placer dans ~/bin/, **git-create** (possibilité de passer par Hub aussi, voir section correspondante) 

    #!/bin/sh

    repo_name=$1
    test -z $repo_name && echo "Repo name required." 1>&2 && exit 1

    curl -u 'your_github_username' https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"


Et après 

    git-create nomDuRepo 

Puis donc les deux méthodes décrites plus haut à faire 



# Hub 

à remplir ... 

# Git & Fugivive (vim/nvim)

see the commands doc in: 

    nvim ~/.config/nvim/plugged/vim-fugitive/doc/fugitive.txt 

Quelques commandes utiles: 

- **:Gwrite** -> stage the current file to the index (Git add %) 
- **:Gread** -> revert current file to last checked in version (Git checkout) 
- **:Gremove** -> Delete the current file and the corresponding Vim buffer (Git rm %) 
- **:Gmove** -> rename the current file and the corresponding Vim buffer (Git mv %) 
- **:Git co** (-b) develop/master/topic_aim
- **:G** (git status) 
- **:Gcommit** 

Actuellement problème non résolu pour merger des branches, par exemple: 

    :G co -b develop 
    ... "fait des modifs" 
    :Gwrite
    :Gcommit 
    :G co master 
    :Gmerge develop -> PROBLEMS 

Alors que si je fais ça en console 

    git merge develop 

ça marche .. ! ça devrait revenir au même non ? 





# References


- (Git) https://git-scm.com/book/en/v2
- (fugitive) http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
- (Hub) https://hub.github.com/
- (Hub, man) https://hub.github.com/hub.1.html
- (fork & clones meaning) https://opensource.com/article/17/12/fork-clone-difference



