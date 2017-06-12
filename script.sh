#!/bin/bash
clear

# A faire : -adapter le code sur 80 lignes max
#           -demander le mot de passe sudo via whiptail (8)
#           -vérifier si les fichiers existent (1 2 3 4 5 6)
#           -
#



OPTION=$(whiptail --title "Projet scripting linux" --menu "" 0 0 10 \
"1" "Archivage d'un repertoire" \
"2" "Compression d'une archive" \
"3" "Désarchivage d'une archive" \
"4" "Décompression d'une archive compressée" \
"5" "Comparaison de 2 fichiers" \
"6" "Mise en forme d'un fichier .csv" \
"7" "Afficher votre configuration IP" \
"8" "Redémarrer votre carte réseau" \
"9" "Quitter" \
 3>&1 1>&2 2>&3 )

case $OPTION in
    1)  REPERTOIRE=$(whiptail --title "Choix d'un repertoire à archiver" --inputbox "Exemple : repertoire/" 0 0 \
	3>&1 1>&2 2>&3 )
	CHEMIN=$(whiptail --title "Choix du dossier ou placer l'archive" \
	--inputbox "*!*Ne rien faire si vous voulez placer l'archive dans le dossier courant*!*\nExemple : Documents/" 0 0 \
	3>&1 1>&2 2>&3 )
        NOM_ARCHIVE=$(whiptail --title "Nom d'archive" --inputbox \
	"*!*Pas besoin de préciser le type de fichier*!*" 0 0 \
	3>&1 1>&2 2>&3 )
	if [[ $CHEMIN == *"/"* ]] ; then
	    whiptail --msgbox "Le repertoire $REPERTOIRE sera archivé dans le dossier $CHEMIN sous le nom $NOM_ARCHIVE.tar" 0 0
	else
	    whiptail --msgbox "Le repertoire $REPERTOIRE sera archivé dans le dossier courant sous le nom $NOM_ARCHIVE.tar" 0 0
	fi
	tar -cvf $CHEMIN$NOM_ARCHIVE.tar $REPERTOIRE
	exec $0
	;;
    2) 	CHEMIN_ARCHIVE=$(whiptail --title "Dossier dans lequel se trouve l'archive" \
	--inputbox "*!*Ne rien faire si vous voulez placer l'archive compressée dans le dossier courant*!*\nExemple : Documents/ ou /home/%USER%/Documents/" 0 0 \
	3>&1 1>&2 2>&3 )
        ARCHIVE=$(whiptail --title "Nom de l'archive" \
	--inputbox "*!*Précisez le type*!*\nExemple : montar.tar" 0 0 \
	3>&1 1>&2 2>&3 )
	CHEMIN_ARCHIVE_COMPRESSEE=$(whiptail \
	--title "Choix du dossier dans lequel sera placé l'archive compressée" \
	--inputbox "*!*Ne rien faire si vous voulez placer l'archive compressée dans le dossier courant*!*\nExemple : Musique/ ou /home/%USER%/Musique/" 0 0 \
	3>&1 1>&2 2>&3 )
	if [[ $CHEMIN_ARCHIVE_COMPRESSEE == *"/"* ]] ; then
	    whiptail --msgbox "L'archive $CHEMIN_ARCHIVE$ARCHIVE sera compressée et \nplacée dans le dossier $CHEMIN_ARCHIVE_COMPRESSEE ." 0 0    
	else
	    whiptail --msgbox "L'archive $CHEMIN_ARCHIVE$ARCHIVE sera compressée et \nplacée dans le dossier courant ." 0 0
	fi 
	gzip -c $CHEMIN_ARCHIVE$ARCHIVE > $CHEMIN_ARCHIVE_COMPRESSEE$ARCHIVE.gz
	;;
    3)  CHEMIN_ARCHIVE=$(whiptail --title "Choix de l'archive a extraire" \
	--inputbox "Exemple : montar.tar (dossier courant)\n          Documents/montar.tar\n          /home/%USER%/Documents/montar.tar" 0 0 \
	3>&1 1>&2 2>&3 )
	CHEMIN_EXTRACTION_ARCHIVE=$(whiptail --title "Extraire vers : " \
	--inputbox "*!*Ne rien faire si vous voulez extraire vers le dossier courant*!*\nExemple : Documents/ ou /home/%USER%/Documents/" 0 0 \
	3>&1 1>&2 2>&3 )
	if [[ $CHEMIN_EXTRACTION_ARCHIVE == *"/"* ]] ; then
	    whiptail --msgbox "Le contenu de $CHEMIN_ARCHIVE sera placé dans : $CHEMIN_EXTRACTION_ARCHIVE" 0 0
	    tar -xvf $CHEMIN_ARCHIVE -C $CHEMIN_EXTRACTION_ARCHIVE
	else
	    whiptail --msgbox "Le contenu de $CHEMIN_ARCHIVE sera placé dans le dossier courant" 0 0
            tar -xvf $CHEMIN_ARCHIVE
	fi
	exec $0
	;;
    4) 	CHEMIN_ARCHIVE_COMPRESSEE=$(whiptail --title "Choix de l'archive à décompresser" \
	--inputbox "Exemple : montar.tar.gz (dossier courant)\n          Documents/montar.tar.gz\n          /home/%USER%/Documents/montar.tar.gz" 0 0 \
	3>&1 1>&2 2>&3 )
        CHEMIN_DECOMPRESSION=$(whiptail --title "Décompresser vers : " \
        --inputbox "*!*Ne rien faire si vous voulez décompresser dans le dossier d'origine*!*\nExemple : Documents/ ou /home/%USER%/Documents/" 0 0 \
        3>&1 1>&2 2>&3 )
        if [[ $CHEMIN_DECOMPRESSION == *"/"* ]] ; then
            NOUVEAUNOM=$(whiptail --title "Nom du fichier resultant : " \
	    --inputbox "Exemple : resultat.tar" 0 0 \
	    3>&1 1>&2 2>&3 )
	    whiptail --msgbox "$CHEMIN_ARCHIVE_COMPRESSEE sera décompressé et placé dans le dossier $CHEMIN_DECOMPRESSION sous le nom $NOUVEAUNOM." 0 0
	    gunzip -c $CHEMIN_ARCHIVE_COMPRESSEE > $CHEMIN_DECOMPRESSION$NOUVEAUNOM
        else
	    whiptail --msgbox "$CHEMIN_ARCHIVE_COMPRESSEE sera décompressé et placé dans le dossier d'origine." 0 0
            gunzip $CHEMIN_ARCHIVE_COMPRESSEE
	fi
	exec $0
	;;
    5)	CHOICE=$(whiptail --title "Comparaison de fichiers" --checklist "" 0 0 0 \
	"Comparaison de hash (md5sum)" "" on \
	"Comparaison par ligne de textes (VIM)" "" off \
        3>&1 1>&2 2>&3 )
	FICHIER1=$(whiptail --title "Fichier1" \
	--inputbox "Exemple : montar.tar.gz (dossier courant)\n          Documents/montar.tar.gz\n          /home/%USER%/Documents/montar.tar.gz" 0 0 \
	3>&1 1>&2 2>&3 )
	FICHIER2=$(whiptail --title "Fichier2" \
	--inputbox "Exemple : montar.tar.gz (dossier courant)\n          Documents/montar.tar.gz\n          /home/%USER%/Documents/montar.tar.gz" 0 0 \
	3>&1 1>&2 2>&3 )
	if [[ $CHOICE == *"hash"* ]] ; then
	    FILE1=$(md5sum $FICHIER1 | awk '{print $1}')
	    FILE2=$(md5sum $FICHIER2 | awk '{print $1}')
	    if [ $FILE1 == $FILE2 ] ; then
    		whiptail --msgbox "$FICHIER1 et $FICHIER2 sont les mêmes" 0 0
	    else
    		whiptail --msgbox "$FICHIER1 est différent de $FICHIER2" 0 0
	    fi
	fi
	if [[ $CHOICE == *"VIM"* ]] ; then
	    vimdiff $FICHIER1 $FICHIER2
   	fi
	exec $0
	;;
    6) 	FILE=$(whiptail --title "Fichier .csv" \
	--inputbox "" 0 0 \
	3>&1 1>&2 2>&3 )
	whiptail --textbox /dev/stdin 0 0 <<<"$(cat $FILE | column -t -s $',')"
	exec $0
	;;
    7)  whiptail --textbox /dev/stdin 0 0 <<<"$(ifconfig)"
	exec $0
        ;;
    8)
#	PASSWORD=$(whiptail --title "Mot de passe sudo" --passwordbox "Enter your password" 8 70 \
#	3>&1 1>&2 2>&3 )
#	exitstatus=$?
#  	if [ $exitstatus = 0 ]; then
#           sudo -S <<< $PASSWORD
#   	else
#           whiptail --title "Cancel" --msgbox "Operation Cancel" 10 60
#	    exit
#    	fi
	sudo ifconfig ens33 down && \
	{ 
	for ((i=0 ; i<=100 ; i+=5)) ; do
	    sleep 0.5
	    echo $i
	done
	} | whiptail --gauge "ens33 redémarre..." 0 0 0 \
	&& sudo ifconfig ens33 up
	exec $0
        ;;
    9) whiptail --msgbox "Merci d'avoir utilisé notre programme!\n           Samir Benlafya\n           Gregory Comble\n                2017" 0 0
	exit
	;;
    *) if (whiptail --yesno "Voulez vous vraiment quitter?" 0 0) then
	   whiptail --msgbox "Merci d'avoir utilisé notre programme!\n           Samir Benlafya\n           Gregory Comble\n                2017" 0 0
           exit
       else
	   exec $0
       fi
       ;;
esac
