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
```
### Rendre le script exécutable

```bash
chmod u+x ./scripts/delete_expired_users.sh
```

### Éditer le fichier crontab

```bash
sudo crontab -e
```

### Ajouter une entrée cron

- Dans l'éditeur crontab qui s'ouvre, ajoutez la ligne suivante à la fin du fichier pour exécuter le script une fois par mois, par exemple le premier jour de chaque mois à minuit :

```cron
0 0 1 * * ./scripts/delete_expired_users.sh >> /var/log/delete_users.log 2>&1
```

### Sauvegarder et quitter l'éditeur crontab

- Sauvegardez les modifications et quittez l'éditeur. Sur la plupart des éditeurs dans le terminal, cela peut être fait avec `Ctrl+O` pour sauvegarder et `Ctrl+X` pour quitter si vous utilisez Nano, ou `:wq` pour Vim.

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
