# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    create_restricted_users.sh                          |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:47:51 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 21:26:16 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Script pour créer des utilisateurs restreints sur le VPS

# Vérification des privilèges root
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root." >&2
    exit 1
fi

# Création de plusieurs utilisateurs à partir d'une liste
echo "Entrez les noms d'utilisateur séparés par un espace:"
read -a usernames

for username in "${usernames[@]}"
do
    # Vérifie si l'utilisateur existe déjà
    if id "$username" &>/dev/null; then
        echo "L'utilisateur '$username' existe déjà." >&2
        continue
    fi

    # Création de l'utilisateur avec un shell standard et sans ajout au groupe sudo
    useradd -m -s /bin/bash -G users "$username"

    # Définition d'un mot de passe temporaire et forçage de la modification du mot de passe à la première connexion
    echo "Définissez un mot de passe temporaire pour $username:"
    passwd "$username"
    passwd -e "$username"

    # Confirmation de la création de l'utilisateur
    echo "Utilisateur '$username' créé avec succès avec des droits limités."
    echo "L'utilisateur devra changer son mot de passe lors de la prochaine connexion."
done
