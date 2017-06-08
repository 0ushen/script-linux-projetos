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
	CHEMIN=$(whiptail --title "Choix du dossier ou placer l'archive" --inputbox \
	"Veuillez indiquer ou placer cette archive" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "LE chemin choisi est $CHEMIN" 10 35
        NOM_ARCHIVE=$(whiptail --title "Nom d'archive" --inputbox \
	"Veuillez indiquer le nom de votre archive" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le nom de votre archive sera $NOM_ARCHIVE" 10 30
	tar -cvf $CHEMIN$NOM_ARCHIVE $REPERTOIRE
	scripts/./script.sh
	;;
    2) whiptail --title "Samir's Program" --msgbox "Vous avez choisi l'option $OPTION" 10 35 
	CHEMIN_ARCHIVE=$(whiptail --title "Chemin de l'archive" \
	--inputbox "Veuillez indiquer le chemin du dossier dans lequel se trouve l'archive" \
	10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le chemin est $CHEMIN_ARCHIVE" 10 35
        ARCHIVE=$(whiptail --title "Nom de l'archive" --inputbox \
	"Veuillez indiquer le nom de l'archive" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le nom de l archive est $ARCHIVE" 10 35
	CHEMIN_ARCHIVE_COMPRESSEE=$(whiptail --title "Choix du dossier ou placer l'archive compressée" --inputbox \
	"Veuillez indiquer ou placer cette archive compressée" 10 50 3>&1 1>&2 2>&3 )
	whiptail --msgbox "Le chemin choisi est $CHEMIN_ARCHIVE_COMPRESSEE" 10 35
	gzip -c $CHEMIN_ARCHIVE$ARCHIVE > $CHEMIN_ARCHIVE_COMPRESSEE$ARCHIVE.gz
	;;
    3) echo "HOHO?" ;;
    *) echo "Vous n'avez rien choisi" ;;
esac
