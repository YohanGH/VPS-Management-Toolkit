# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    custom_welcome_message.sh                           |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:49:34 by YohanGH           '__   _/_               #
#    Updated: 2024/04/20 22:11:31 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Script pour configurer un message de bienvenue personnalisé pour les utilisateurs sur le VPS

# Vérifie si l'utilisateur root exécute le script
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté avec des privilèges root." >&2
    exit 1
fi

# Vérifie si un fichier a été fourni en argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <fichier_noms_utilisateurs>" >&2
    exit 1
fi

filename="$1"

# Vérifie si le fichier spécifié existe
if [ ! -f "$filename" ]; then
    echo "Le fichier spécifié n'existe pas." >&2
    exit 1
fi

# Obtient l'année en cours
current_year=$(date +"%Y")

# Lit et configure le message pour chaque utilisateur dans le fichier
while IFS= read -r username
do
    # Vérifie si l'utilisateur existe
    if id "$username" &>/dev/null; then
        # Ajoute le message de bienvenue dans le fichier .bashrc de l'utilisateur
        echo "echo 'Bonjour, $username! Voici les nouvelles de la promotion Lyon $current_year. By Regnier Yohan'" >> /home/$username/.bashrc
        echo "Message de bienvenue configuré pour l'utilisateur $username."
    else
        echo "L'utilisateur spécifié ($username) n'existe pas." >&2
    fi
done < "$filename"
