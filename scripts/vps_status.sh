# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    vps_status.sh                                       |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 19:30:32 by YohanGH           '__   _/_               #
#    Updated: 2024/04/20 22:35:28 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Script pour surveiller les caractéristiques du VPS et enregistrer les résultats dans un fichier.

# Créer le dossier 'log'
# Définir le chemin du dossier parent
parent_dir=$(dirname "$(pwd)")

# Chemin complet du dossier 'log'
log_dir="$parent_dir/log"

# Vérifier si le dossier 'log' existe déjà
if [ -d "$log_dir" ]; then
    echo "Le dossier 'log' existe déjà dans le dossier parent : $log_dir"
else
    # Tenter de créer le dossier 'log'
    mkdir -p "$log_dir"
    # Vérifier si la création du dossier a réussi
    if [ $? -eq 0 ]; then
        echo "Dossier 'log' créé dans le dossier parent : $log_dir"
    else
        echo "Erreur lors de la création du dossier 'log' dans le dossier parent : $log_dir" >&2
        exit 1
    fi
fi

# Chemin du fichier où les informations seront enregistrées
output_file="../log/vps_status.log"

# Date et heure de l'exécution
echo "Surveillance du VPS effectuée le $(date)" >> $output_file
echo "-------------------------------------------" >> $output_file

# Informations sur le processeur
echo "CPU Info:" >> $output_file
lscpu >> $output_file
echo "" >> $output_file

# Informations sur la mémoire
echo "Memory Info:" >> $output_file
free -h >> $output_file
echo "" >> $output_file

# Utilisation du disque
echo "Disk Usage:" >> $output_file
df -h >> $output_file
echo "" >> $output_file

echo "Fin du rapport." >> $output_file
echo "-------------------------------------------" >> $output_file
echo "Les résultats de la surveillance sont disponibles dans $output_file"
