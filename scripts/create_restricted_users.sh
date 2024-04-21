# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    create_restricted_users.sh                          |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 20:47:51 by YohanGH           '__   _/_               #
#    Updated: 2024/04/21 14:51:17 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Script pour créer des utilisateurs restreints sur le VPS

# Vérification des privilèges root
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root." >&2
    exit 1
fi

# Vérifie si un nom de fichier a été fourni en argument
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

# Chemin du fichier journal
logfile="/var/log/user_creation.log"

# Création de plusieurs utilisateurs à partir d'une liste
while IFS= read -r username
do
	# Validation du nom d'utilisateur
    if [[ ! "$username" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "Nom d'utilisateur '$username' invalide. Les noms d'utilisateur ne peuvent contenir que des lettres, des chiffres et des underscores." | tee -a "$logfile"
        continue
    fi

	 # Vérifie si l'utilisateur existe déjà
    if id "$username" &>/dev/null; then
        echo "L'utilisateur '$username' existe déjà." | tee -a "$logfile"
        continue
    fi

	# Création de l'utilisateur avec un shell standard et sans ajout au groupe sudo
    if useradd -m -s /bin/bash -G users "$username"; then
		# Forcer le changement de mot de passe à la première connexion
		passwd -de "$username"

    echo "Utilisateur '$username' créé avec succès avec des droits limités." | tee -a "$logfile"
        echo "Mot de passe temporaire généré pour '$username'. L'utilisateur doit le changer à la première connexion." | tee -a "$logfile"
    else
        echo "Erreur lors de la création de l'utilisateur '$username'." | tee -a "$logfile"
    fi
done < "$filename"

echo "Opération terminée. Vérifiez $logfile pour le journal détaillé des opérations."
