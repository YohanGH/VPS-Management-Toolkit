# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    create_restricted_users.sh                          |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:47:51 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 20:55:19 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Script pour créer des utilisateurs restreints sur le VPS

# Vérification des privilèges root
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root." >&2
    exit 1
fi

# Demande du nom de l'utilisateur à créer
read -p "Entrez le nom d'utilisateur à créer: " username

# Vérifie si l'utilisateur existe déjà
if id "$username" &>/dev/null; then
    echo "L'utilisateur '$username' existe déjà." >&2
    exit 1
fi

# Création de l'utilisateur avec un shell standard
useradd -m -s /bin/bash "$username"

# Définition d'un mot de passe temporaire et forçage de la modification du mot de passe à la première connexion
echo "Veuillez entrer un mot de passe temporaire pour l'utilisateur:"
passwd "$username"
passwd -e "$username"

# Confirmation de la création de l'utilisateur
echo "Utilisateur '$username' créé avec succès avec des droits limités."
echo "L'utilisateur devra changer son mot de passe lors de la prochaine connexion."

