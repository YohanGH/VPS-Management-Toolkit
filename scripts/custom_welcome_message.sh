# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    custom_welcome_message.sh                           |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:49:34 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 20:53:20 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Script pour configurer un message de bienvenue personnalisé pour les utilisateurs sur le VPS

# Vérifie si l'utilisateur root exécute le script
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté avec des privilèges root." >&2
    exit 1
fi

# Lit le nom de l'utilisateur pour lequel configurer le message
read -p "Entrez le nom d'utilisateur pour configurer le message de bienvenue: " username

# Vérifie si l'utilisateur existe
if id "$username" &>/dev/null; then
    # Ajoute le message de bienvenue dans le fichier .bashrc de l'utilisateur
    echo "echo 'Bonjour, $username! Voici les nouvelles de la promotion XYZ.' | cowsay" >> /home/$username/.bashrc

    echo "Message de bienvenue configuré pour l'utilisateur $username."
else
    echo "L'utilisateur spécifié n'existe pas." >&2
    exit 1
fi

