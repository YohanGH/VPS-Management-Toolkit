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

Ce script crée des utilisateurs sans privilèges d'administration à partir d'une liste fournie dans un fichier texte. Chaque nom d'utilisateur doit être sur une ligne distincte dans le fichier.

## Explication

- **Vérification des privilèges :** Le script commence par vérifier si l'utilisateur actuel a des privilèges d'administrateur. S'il n'en a pas, le script s'arrête.
- **Lecture du fichier :** Le script attend un nom de fichier en argument, qui contient les noms d'utilisateur à créer.
- **Création de l'utilisateur :** Pour chaque nom dans le fichier, le script crée un utilisateur avec un dossier home et un shell par défaut (/bin/bash). Si l'utilisateur existe déjà, le script passe au suivant.
- **Attribution du mot de passe :** Un mot de passe temporaire est attribué à chaque nouvel utilisateur, que l'utilisateur doit changer lors de sa première connexion.## Suppression Automatique des Comptes

### Exemple de Fichier Texte

Pour utiliser ce script, vous devez préparer un fichier texte où chaque ligne contient un nom d'utilisateur. Voici un exemple de contenu pour un fichier nommé `userlist.txt`:

```txt
alice
bob
charlie
```

### Utilisation du Script

Pour exécuter le script, utilisez la commande suivante dans le terminal :

```bash
sudo ./create_non_admin_users.sh userlist.txt
```

Cette commande suppose que vous avez accordé les droits d'exécution au script et que vous avez le fichier userlist.txt dans le même répertoire que le script ou spécifiez le chemin complet vers celui-ci.

### Script de Suppression Automatique

Nom du script : `auto_delete_users.sh`

Ce script supprime les utilisateurs qui ont été créés il y a plus de 12 mois.

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

**Type de fichier attendu :** Un fichier texte simple, avec un nom d'utilisateur par ligne.

**Exemple de fichier :**

```txt
alice
bob
charlie
```

**Conventions à respecter :**

- Assurez-vous que chaque nom d'utilisateur est sur une nouvelle ligne sans espaces supplémentaires ni caractères spéciaux.
- Le fichier ne doit pas contenir de lignes vides.
- Utilisez des noms d'utilisateur valides qui existent sur le système.

**Usage**

Pour utiliser le script, exécutez-le avec le chemin du fichier en argument comme suit :

```bash
sudo ./custom_welcome_message.sh chemin/vers/le/fichier_utilisateurs.txt
```

## Documentation et Maintenance

- https://github.com/YohanGH/VPS-Management-Toolkit
