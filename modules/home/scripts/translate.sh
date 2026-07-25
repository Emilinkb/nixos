#!/bin/bash

# 1. On récupère le texte (les guillemets autour de $TEXT sont cruciaux)
# On ajoute l'option -show-icons ou d'autres si ton design habituel en a
# TODO: Le fichier de configuration rofi n'a pas été trouvé. L'option -config a été retirée.
TEXT=$(rofi -dmenu -p "Traduire" -theme-str 'window {width: 30%;}')

# Si vide, on sort
[[ -z "$TEXT" ]] && exit 0

# 2. Traduction de la PHRASE (on met bien "$TEXT" entre guillemets)
# L'option -e google force l'engine si besoin, -b est pour le mode bref
TRADUCTION=$(trans -b fr:en "$TEXT")

# 3. Affichage du résultat
# Ici, on n'ajoute PAS de flags de thème pour que Rofi utilise ton config.rasi par défaut
# Si ça ne marche toujours pas, remplace par : rofi -dmenu -theme "/chemin/vers/ton/theme.rasi"
echo "$TRADUCTION" | rofi -dmenu -p "Résultat" -theme-str 'window {width: 30%;}'

# Optionnel : Copie automatique
echo -n "$TRADUCTION" | xclip -selection clipboard
