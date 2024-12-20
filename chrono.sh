#!/bin/bash
#Pour executer le programme, il faut écrire 'chmod +x chrono.sh
# Vérifier si un programme a été fourni
if [ $# -eq 0 ]; then
    echo "Usage: $0 <commande à exécuter>"
    exit 1
fi

# Stocker la commande à exécuter
COMMAND="$@"

# Afficher un message indiquant le début du chronomètre
echo "Lancement du chronomètre pour la commande : $COMMAND"

# Mesurer le temps d'exécution
START=$(date +%s.%N) # Démarrage du chronomètre
$COMMAND              # Exécution de la commande
END=$(date +%s.%N)   # Fin du chronomètre

# Calculer la durée d'exécution
DURATION=$(echo "$END - $START" | bc)

# Afficher le résultat
echo "Temps d'exécution : $DURATION secondes"
