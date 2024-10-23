#!/bin/bash

# Variables
BACKUP_DIR="/path/to/backup/gitlab/api"
REPO_SSH="git@gitlab.com:username/api.git"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Se déplacer dans le dossier de backup
cd $BACKUP_DIR

# Si le dépôt existe déjà, on fait un pull pour récupérer les nouvelles modifications
if [ -d "$BACKUP_DIR/api" ]; then
    cd api
    git pull
else
    # Si le dépôt n'existe pas, on le clone
    git clone $REPO_SSH
fi

# Archiver la sauvegarde avec un timestamp
tar -czf "api_backup_$TIMESTAMP.tar.gz" api

# Optionnel : supprimer les archives de plus de 7 jours
find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;

