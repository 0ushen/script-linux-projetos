SCRIPTING LINUX

Créer un script LinuxTools.sh qui présente en boucle un menu à l’utilisateur avec un choix 
d’actions possibles. rem : envisagez l’utilisation de l’outil « whiptail ». 
Ce menu doit comporter les fonctionnalités suivantes:

	1. Archivage d’un répertoire L’utilisateur est invité à entrer le nom du répertoire 
	qu’il désire sauver ainsi que le nom et le chemin de l’archive à créer.
	Une archive de ce répertoire est alors créée (fichier .tar).
	Il est évident que le répertoire doit exister et que l’archive doit avoir été créée.
	Dans le cas contraire, l’utilisateur doit en être averti.

	2. Compression d’une archive L’utilisateur est invité à entrer le nom de l’archive 
	(fichier .tar) qu’il désire compresser (fichier .tar.gz).

	3. Désarchivage d’une archive L’utilisateur est invité à introduire le nom de 
	l’archive (fichier .tar) qu’il désire désarchiver et le répertoire de destination. 
	Si le fichier n’existe pas, l’utilisateur doit en être informé.

	4. Décompression d’une archive compressée L’utilisateur est invité à introduire 
	le nom de l’archive compressée (fichier .tar.gz) qu’il désire décompresser 
	(fichier .tar comme résultat). 
	Si le fichier n’existe pas l’utilisateur doit en être informé.

	5. Comparaison de 2 fichiers L’utilisateur est invité à introduire les deux noms 
	des fichiers à comparer. Les fichiers doivent bien entendu exister. 
	Une comparaison est alors effectuée (somme MD5). 
	L’utilisateur doit être informé du résultat de la comparaison.

	6. Mise en forme d'un fichier .csv L’utilisateur est invité à introduire le nom 
	d'un fichier .csv à mettre en forme. 
	Si le fichier n'existe pas, l'utilisateur doit en être informé. 
	Le fichier sélectionné est affiché, avec mise-en-forme en colonnes. 
	Les outils awk ou column trouvent ici leur utilité.

	7. Affiche votre configuration IP

	8. Redémarre votre carte réseau

	9. Quitter Quitter le script.