#!/bin/bash
# Pour le rendre éxecutable, utiliser la commande chmod +x chrono_traitement.sh
# Vérifier si une commande a été fournie
if [ $# -eq 0 ]; then
    echo "Usage: $0 <commande à exécuter>"
    exit 1
fi

# Stocker la commande à exécuter
COMMAND="$@"

# Phase de compilation ou préparation
echo "Préparation des ressources..."
# Placez ici les commandes de compilation ou de création de dossiers si nécessaire
# Par exemple :
# gcc -o programme programme.c
# mkdir -p output

echo "Phase de traitement des données..."

# Chronométrer uniquement la phase de traitement
START=$(date +%s.%N)
$COMMAND
EXIT_STATUS=$?  # Capturer le statut de sortie de la commande
END=$(date +%s.%N)

# Calculer la durée
if [ $EXIT_STATUS -eq 0 ]; then
    DURATION=$(echo "$END - $START" | bc)
else
    DURATION=0.0
fi

# Afficher les résultats
if [ $EXIT_STATUS -eq 0 ]; then
    echo "Traitement terminé avec succès."
else
    echo "Échec du traitement (erreur dans le programme ou les paramètres)."
fi

echo "Temps utile de traitement : $DURATION secondes"
