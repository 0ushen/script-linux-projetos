SCRIPTING LINUX

Cr�er un script LinuxTools.sh qui pr�sente en boucle un menu � l�utilisateur avec un choix 
d�actions possibles. rem : envisagez l�utilisation de l�outil � whiptail �. 
Ce menu doit comporter les fonctionnalit�s suivantes:

	1. Archivage d�un r�pertoire L�utilisateur est invit� � entrer le nom du r�pertoire 
	qu�il d�sire sauver ainsi que le nom et le chemin de l�archive � cr�er.
	Une archive de ce r�pertoire est alors cr��e (fichier .tar).
	Il est �vident que le r�pertoire doit exister et que l�archive doit avoir �t� cr��e.
	Dans le cas contraire, l�utilisateur doit en �tre averti.

	2. Compression d�une archive L�utilisateur est invit� � entrer le nom de l�archive 
	(fichier .tar) qu�il d�sire compresser (fichier .tar.gz).

	3. D�sarchivage d�une archive L�utilisateur est invit� � introduire le nom de 
	l�archive (fichier .tar) qu�il d�sire d�sarchiver et le r�pertoire de destination. 
	Si le fichier n�existe pas, l�utilisateur doit en �tre inform�.

	4. D�compression d�une archive compress�e L�utilisateur est invit� � introduire 
	le nom de l�archive compress�e (fichier .tar.gz) qu�il d�sire d�compresser 
	(fichier .tar comme r�sultat). 
	Si le fichier n�existe pas l�utilisateur doit en �tre inform�.

	5. Comparaison de 2 fichiers L�utilisateur est invit� � introduire les deux noms 
	des fichiers � comparer. Les fichiers doivent bien entendu exister. 
	Une comparaison est alors effectu�e (somme MD5). 
	L�utilisateur doit �tre inform� du r�sultat de la comparaison.

	6. Mise en forme d'un fichier .csv L�utilisateur est invit� � introduire le nom 
	d'un fichier .csv � mettre en forme. 
	Si le fichier n'existe pas, l'utilisateur doit en �tre inform�. 
	Le fichier s�lectionn� est affich�, avec mise-en-forme en colonnes. 
	Les outils awk ou column trouvent ici leur utilit�.

	7. Affiche votre configuration IP

	8. Red�marre votre carte r�seau

	9. Quitter Quitter le script.