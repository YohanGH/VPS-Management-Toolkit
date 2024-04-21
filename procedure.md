```
# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    procedure.md                                        |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 19:14:33 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 19:14:40 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #
```

# Procédures de Gestion VPS

Ce document décrit les étapes détaillées pour la configuration initiale, la gestion des utilisateurs, et l'entretien régulier du serveur VPS. Chaque section contient des commandes spécifiques et des guides pour atteindre les objectifs de gestion efficace du serveur.

## Connexion Initiale au VPS

### Création et utilisation de SSH

1. **Générer une paire de clés SSH :**

    - Exécutez la commande suivante sur votre terminal local :
        ```bash
        ssh-keygen -t rsa -b 4096
        ```
    - Suivez les instructions à l'écran pour nommer et sécuriser votre paire de clés avec un mot de passe.

2. **Copier la clé publique sur le VPS :**

    - Utilisez la commande suivante pour copier votre clé publique :
        ```bash
        ssh-copy-id -i ~/.ssh/mykey.pub username@vps-address
        ```

### Modifier le mot de passe initial

-   Une fois connecté, changez immédiatement votre mot de passe :
    ```bash
    passwd
    ```

## Gestion des Utilisateurs

### Création de Comptes Utilisateurs

-   Utilisez le script suivant pour créer un nouvel utilisateur avec des restrictions :

### Suppression Automatique des Comptes

-   Configurez une tâche cron pour supprimer les comptes après 12 mois :

```bash
echo "0 0 1 * * /path/to/script/delete_users.sh" | sudo tee -a /etc/crontab
```

### Surveillance des Caractéristiques du VPS

-   Pour faire un état des lieux des caractéristiques du VPS, exécutez :

```bash
echo "CPU Info:" && lscpu
echo "Memory Info:" && free -h
echo "Disk Usage:" && df -h
```

### Configuration du Message de Bienvenue

-   Pour configurer un message de bienvenue personnalisé pour chaque utilisateur, modifiez le fichier .bashrc de l'utilisateur :

```bash
welcome_message="echo -e \"\e[32mPromotion $current_year\n\e[34mBonjour, $username! \n\e[33mBy Regnier Yohan\e[0m\""
```

### Documentation et Référence

- [Link repos]
