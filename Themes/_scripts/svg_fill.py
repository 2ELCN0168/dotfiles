#!/usr/bin/env python3

import os
import sys
import re

def remplacer_couleur_fill(dossier, nouvelle_couleur):
    if not os.path.isdir(dossier):
        print(f"Erreur : {dossier} n'est pas un répertoire.")
        sys.exit(1)

    if not re.match(r'^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$', nouvelle_couleur):
        print("Erreur : couleur invalide (ex: #ff0000)")
        sys.exit(1)

    for nom_fichier in os.listdir(dossier):
        if nom_fichier.endswith(".svg"):
            chemin_fichier = os.path.join(dossier, nom_fichier)
            with open(chemin_fichier, "r", encoding="utf-8") as f:
                contenu = f.read()

            # Remplacement des attributs fill (dans XML et CSS inline)
            nouveau_contenu = re.sub(
                r'fill="[^"]+"',
                f'fill="{nouvelle_couleur}"',
                contenu
            )
            nouveau_contenu = re.sub(
                r'fill:\s*#[0-9a-fA-F]{3,6}',
                f'fill: {nouvelle_couleur}',
                nouveau_contenu
            )

            with open(chemin_fichier, "w", encoding="utf-8") as f:
                f.write(nouveau_contenu)

            print(f"Modifié : {nom_fichier}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage : python3 remplace_fill.py <répertoire> <#couleur>")
        sys.exit(1)

    dossier = sys.argv[1]
    couleur = sys.argv[2]
    remplacer_couleur_fill(dossier, couleur)

