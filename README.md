# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    README.md                                           |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/04/15 18:53:12 by YohanGH           '__   _/_               #
#    Updated: 2024/04/15 19:53:47 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

# VPS-Management-Toolkit - Documentation du Projet

## Introduction

Ce projet vise à établir et à gérer une infrastructure VPS (Virtual Private Server) sécurisée et efficace. Les scripts et procédures documentées ici permettent la création et la gestion de comptes utilisateurs, la personnalisation de l'environnement de connexion et la maintenance automatisée des comptes.

## Objectifs

- **Sécurité** : Mise en place d'une connexion sécurisée via SSH.
- **Automatisation** : Scripts pour la création et la suppression automatique des comptes utilisateurs.
- **Surveillance** : Analyse et rapport des spécifications et performances du VPS.
- **Personnalisation** : Configuration d'un message de bienvenue personnalisé pour les utilisateurs.

## Installation

### Prérequis

Assurez-vous que votre machine locale dispose de SSH installé. Pour les utilisateurs Windows, vous pouvez installer PuTTY ou utiliser Windows Subsystem for Linux (WSL).

### Connexion au VPS

1. Générer une paire de clés SSH (si non existante) :

```bash
   ssh-keygen -t rsa -b 4096
```

2. Copier la clé publique sur le VPS :

```bash
ssh-copy-id username@vps-address
```

3. Se connecter au VPS :

```bash
ssh username@vps-address
```

## Usage

Suivez les instructions détaillées dans les fichiers `procedure.md` et `process.md` pour comprendre comment utiliser les scripts et effectuer les tâches de gestion du VPS.

## Arborescence

/VPS_Management_Project
|-- README.md             # Document principal expliquant le projet, son installation et son usage.
|-- procedure.md          # Document détaillant les procédures à suivre pour les différentes tâches.
|-- process.md            # Document expliquant les scripts et processus techniques.
|-- scripts               # Dossier contenant tous les scripts utilisés dans le projet.
|   |-- create_non_admin_users.sh  # Script pour créer des utilisateurs avec des droits limités.
|   |-- auto_delete_users.sh       # Script pour supprimer automatiquement les comptes utilisateurs.
|   |-- custom_welcome_message.sh  # Script pour configurer un message de bienvenue personnalisé.
|   |-- vps_monitor.sh             # Script pour surveiller les caractéristiques du VPS.
|-- logs                 # Dossier pour stocker les fichiers de log générés par les scripts.
|   |-- vps_status.log   # Fichier de log où sont enregistrées les caractéristiques du VPS.
|-- docs                 # Dossier pour la documentation supplémentaire, si nécessaire.
|-- LICENSE              # Fichier décrivant la licence sous laquelle le projet est distribué.

## Contribution

Les contributions à ce projet sont bienvenues. Veuillez envoyer vos pull requests pour toute amélioration ou correction des scripts ou de la documentation.

## Licence

Ce projet est distribué sous la Licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## Contact

Email : YohanGH@proton.me

