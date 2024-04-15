# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    delete_expired_users.sh                             |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:47:56 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 20:57:23 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Script pour supprimer les comptes utilisateurs expirés sur le VPS

# Vérification des privilèges root
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root." >&2
    exit 1
fi

# Définition du répertoire des utilisateurs
USER_HOME_DIR="/home"

# Date limite: comptes plus anciens que 365 jours
MAX_DAYS=365

# Trouver et supprimer les comptes utilisateurs expirés
find "$USER_HOME_DIR" -maxdepth 1 -type d -ctime +$MAX_DAYS -exec basename {} \; | while read username; do
    # Vérifier que le répertoire utilisateur n'est pas un dossier système
    if [ "$username" != "lost+found" ]; then
        # Suppression de l'utilisateur et de son répertoire home
        userdel -r "$username"
        if [ $? -eq 0 ]; then
            echo "Utilisateur $username supprimé avec succès."
        else
            echo "Échec de la suppression de l'utilisateur $username." >&2
        fi
    fi
done

