#!/bin/bash

OPTION=$(whiptail --menu "Choix?" 20 20 10 \
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
    1) whiptail --title "Samir's Program" --msgbox "Vous avez choisi l'option $OPTION" 10 35 
        REPERTOIRE=$(whiptail --title "Choix d'un repertoire" --inputbox \
	"Veuillez indiquer le chemin du repertoire" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le repertoire choisi est $REPERTOIRE" 10 35
	CHEMIN=$(whiptail --title "Choix du dossier ou placer l'archive" \
	 --inputbox "Veuillez indiquer ou placer cette archive" 10 50 \
	 3>&1 1>&2 2>&3 )
	whiptail --msgbox "LE chemin choisi est $CHEMIN" 10 35
        NOM_ARCHIVE=$(whiptail --title "Nom d'archive" --inputbox \
	"Veuillez indiquer le nom de votre archive" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le nom de votre archive sera $NOM_ARCHIVE" 10 30
	tar -cvf $CHEMIN$NOM_ARCHIVE $REPERTOIRE
	;;
    2) whiptail --title "Samir's Program" \
	 --msgbox "Vous avez choisi l'option $OPTION" 10 35 
	CHEMIN_ARCHIVE=$(whiptail --title "Chemin de l'archive" \
	--inputbox "Veuillez indiquer le chemin du dossier dans lequel se trouve l'archive" \
	10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le chemin est $CHEMIN_ARCHIVE" 10 35
        ARCHIVE=$(whiptail --title "Nom de l'archive" \
	 --inputbox "Veuillez indiquer le nom de l'archive" 10 50 \
	 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le nom de l archive est $ARCHIVE" 10 35
	CHEMIN_ARCHIVE_COMPRESSEE=$(whiptail \
	 --title "Choix du dossier ou placer l'archive compressée" \
	 --inputbox "Veuillez indiquer ou placer cette archive compressée" \
	 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le chemin choisi est $CHEMIN_ARCHIVE_COMPRESSEE" 10 35
	gzip -c $CHEMIN_ARCHIVE$ARCHIVE > $CHEMIN_ARCHIVE_COMPRESSEE$ARCHIVE.gz
	;;
    3) whiptail --title "Samir's Program" \
	whiptail --msgbox "Vous avez choisi l'option $OPTION" 10 35 
	CHEMIN_ARCHIVE=$(whiptail --title "Chemin vers l'archive" \
	--inputbox "Veuillez indiquer le chemin vers l'archive" 10 50 \
	3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le chemin vers l'archive est : $CHEMIN_ARCHIVE" 10 35
	if (whiptail --yesno "Voulez vous extraire l'archive dans un autre dossier?" 10 45) then
	    CHEMIN_EXTRACTION_ARCHIVE=$(whiptail --title "Dossier de destination" \
	    --inputbox "Veuillez indiquer ou placer le contenu de l'archive" 10 50 \
	    3>&1 1>&2 2>&3 )
	    whiptail --msgbox "Le contenu de l'archive sera placé dans : $CHEMIN_EXTRACTION_ARCHIVE" 10 35
	    tar -xvf $CHEMIN_ARCHIVE -C $CHEMIN_EXTRACTION_ARCHIVE
	else
            tar -xvf $CHEMIN_ARCHIVE
	fi
	;;
    4) whiptail --title "Samir's Program" \
        whiptail --msgbox "Vous avez choisi l'option $OPTION" 10 35
	CHEMIN_ARCHIVE_COMPRESSEE=$(whiptail --title "Chemin vers l'archive compressee" \
	--inputbox "Veuillez indiquer le chemin de l'archive à décompresser" 10 50 \
	3>&1 1>&2 2>&3 )
        whiptail --msgbox "Le chemin vers l'archive à décompresser est : $CHEMIN_ARCHIVE_COMPRESSEE" 10 35
	if (whiptail --yesno "Voulez vous décompresser l'archive dans un autre dossier?" 10 45) then
	    CHEMIN_DECOMPRESSION=$(whiptail --title "Dossier de destination" \
	    --inputbox "Veuillez indiquer où placer l'archive décompressée" 10 50 \
	    3>&1 1>&2 2>&3 )
            whiptail --msgbox "Le contenu de l'archive sera placé dans : $CHEMIN_DECOMPRESSION" 10 35
            NOUVEAUNOM=$(whiptail --title "Nom du fichier" \
	    --inputbox "Veuillez indiquer le nom qui sera donné au fichier" 10 50 \
	    3>&1 1>&2 2>&3 )
	    whiptail --msgbox "Nom du fichier : $NOUVEAUNOM" 10 35
	    gunzip -c $CHEMIN_ARCHIVE_COMPRESSEE > $CHEMIN_DECOMPRESSION$NOUVEAUNOM
        else
	    gunzip $CHEMIN_ARCHIVE_COMPRESSEE
	fi
	;;
    5) whiptail --title "Samir's Program" \
	whiptail --msgbox "Vous avez choisi l'option $OPTION" 10 35
	CHOICE=$(whiptail --title "Comparaison de fichiers" --checklist "Choisissez : " 20 78 15 \
	"Comparaison de hash (md5sum)" "" on \
	"Comparaison par ligne de textes (VIM)" "" off \
        3>&1 1>&2 2>&3 )
	whiptail --msgbox "Vos choix sont : $CHOICE " 10 35
	FICHIER1=$(whiptail --title "Choix du 1er fichier à comparer" \
	--inputbox "Fichier 1" 10 50 \
	3>&1 1>&2 2>&3 )
	FICHIER2=$(whiptail --title "Choix du 1er fichier à comparer" \
	--inputbox "Fichier 2" 10 50 \
	3>&1 1>&2 2>&3 )
	if [[ $CHOICE == *"hash"* ]] ; then
	    FILE1=$(md5sum $FICHIER1 | awk '{print $1}')
	    FILE2=$(md5sum $FICHIER2 | awk '{print $1}')
	    if [ $FILE1 == $FILE2 ] ; then
    		whiptail --msgbox "Ils sont identiques" 10 35
	    else
    		whiptail --msgbox "Ils ne sont pas identiques" 10 35
	    fi
	fi
	if [[ $CHOICE == *"VIM"* ]] ; then
	    vimdiff $FICHIER1 $FICHIER2
   	fi
	;;
    6) whiptail --title "Samir's Program" \
	whiptail --msgbox "Vous avez choisi l'option $OPTION" 10 35
	FILE=$(whiptail --title "Choix d'un fichier .csv à mettre en forme" \
	--inputbox "Fichier : " 10 50 \
	3>&1 1>&2 2>&3 )
	cat $FILE | column -t -s $','
	;;
    7);;
    8);;
    9);;
    *) echo "vous n'avez rien fait"
esac
