```
# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    process.md                                          |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 19:14:48 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 19:14:50 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #
```

# Processus Technique de Gestion VPS

Ce document détaille les scripts et les commandes techniques utilisés pour la gestion et la maintenance du VPS. Il fournit des explications détaillées sur le fonctionnement interne des scripts, les commandes utilisées et les procédures automatisées.

## Création de Comptes Utilisateurs

### Script pour la Création d'Utilisateurs Restreints

**Nom du script** : `create_non_admin_users.sh`

Ce script crée un utilisateur sans privilèges d'administration. Voici le contenu du script:

```bash
#!/bin/bash
# Ce script crée un utilisateur avec des droits limités.

if [ "$(id -u)" != "0" ]; then
   echo "Ce script doit être exécuté avec des droits d'administrateur" 1>&2
   exit 1
fi

read -p "Entrez le nom de l'utilisateur à créer: " username
useradd -m -s /bin/bash "$username"
echo "$username:UNPASSWORDSECRETPARDEFAUT" | chpasswd
echo "Utilisateur $username créé avec succès avec des droits limités."
```

## Explication
- Le script vérifie si l'utilisateur actuel a des privilèges d'administrateur.
- Il demande ensuite le nom de l'utilisateur à créer.
- L'utilisateur est créé avec un dossier home et un shell par défaut.
- Un mot de passe par défaut est attribué, que l'utilisateur doit changer à la première connexion.

## Suppression Automatique des Comptes

### Script de Suppression Automatique

Nom du script : `auto_delete_users.sh`

Ce script supprime les utilisateurs qui ont été créés il y a plus de 12 mois. Voici le script :

```bash
#!/bin/bash
# Script pour supprimer les utilisateurs créés il y a 12 mois.

find /home -maxdepth 1 -type d -ctime +365 -exec basename {} \; | while read user; do
    userdel -r "$user"
    echo "Utilisateur $user supprimé."
done
```
## Explication

- Ce script recherche dans le répertoire /home les dossiers créés il y a plus de 365 jours.
- Pour chaque utilisateur trouvé, le script supprime l'utilisateur et son dossier home.

## Personnalisation du Message de Bienvenue

### Configuration du Message de Bienvenue

Nom du fichier à modifier : `.bashrc` dans le dossier home de chaque utilisateur

Ajoutez le code suivant à la fin du fichier .bashrc de l'utilisateur pour afficher un message de bienvenue personnalisé :

```bash
echo "Bienvenue, $(whoami)! Voici les nouvelles de la promotion XYZ."
```

### Explication

- Ce code utilise `echo` pour afficher un message chaque fois que l'utilisateur ouvre un terminal.
- `$(whoami)` est une commande qui retourne le nom de l'utilisateur actuellement connecté.

## Documentation et Maintenance

- [Link repos]
