# Déployer le dépôt vers irivo.fr (hébergement OVH)

Ce document ne concerne **que** l'étape « dépôt GitHub → serveur OVH ».
L'étape « codes et pages → dépôt GitHub » se fait depuis la console IRIVO ou par un simple envoi de fichiers.

---

## ⚠️ Règle d'or avant tout déploiement

1. **Sauvegardez le serveur** : connectez-vous au gestionnaire de fichiers OVH, sélectionnez
   tout le dossier du site (`www/`) et téléchargez-le en ZIP. Sans cette copie, aucun retour arrière n'est possible.
2. **Ne déployez jamais en mode « miroir » / « suppression »** (l'option qui supprime les fichiers
   présents sur le serveur mais absents du dépôt). Elle effacerait `compteur.php`, les 4 fichiers `.apk`,
   les 3 vidéos `.mp4` et tout le dossier `bailliko/` : les pages de téléchargement et les vidéos
   cesseraient de fonctionner.
3. **Mode recommandé** : `git pull` en place, dans le dossier servi par le site. Ce mode ne touche
   jamais aux fichiers non suivis (vidéos, APK, compteur.php).

---

## Cas 1 — Le serveur a Git (Plesk « Git », cPanel « Git Version Control », ou un accès SSH)

**Réglages à vérifier une seule fois :**

- Dépôt : `https://github.com/penfrat2012-AI/irivo-fr-site`
- Branche : **`main`**
- Répertoire de destination : le dossier qui contient réellement `index.html` du site
- Sans clé : le dépôt est public, la lecture suffit
- **Ne pas cocher** « supprimer les fichiers non suivis » / « deploy from scratch »

**Puis, à chaque mise à jour :**

```sh
git -C /chemin/du/site/ pull --ff-only
sh /chemin/du/site/verifier-deploiement.sh      # contrôle : tous les fichiers doivent être en "OK"
```

En cas de refus du type *« Your local changes to the following files would be overwritten by merge »*,
c'est que le fichier a été modifié à la main sur le serveur : comparez-le (`diff`) avant de décider
quelle version garder, puis `git checkout -- <fichier>` si la version du dépôt doit gagner.

---

## Cas 2 — Pas de Git sur le serveur (uniquement FTP / gestionnaire de fichiers)

Téléchargez les fichiers un par un depuis GitHub puis déposez-les à la racine du site :

1. Ouvrez `https://github.com/penfrat2012-AI/irivo-fr-site`
2. Pour chaque fichier de `MANIFESTE.txt` : cliquez dessus → bouton **Raw** → clic droit →
   *Enregistrer sous* (ou Ctrl+S), en conservant **exactement** le même nom
3. Envoyez-le par FTP dans le dossier du site, en écrasant l'ancien
4. Vérifiez ensuite chaque page dans le navigateur (Ctrl+F5 pour vider le cache)

Ordre conseillé : `style.css` et les images d'abord, puis les pages HTML, puis `irivo-catalogue.json`.

---

## Cas 3 — Vous utilisez un outil de synchronisation automatique

- Vérifiez qu'il suit bien la branche **`main`**
- Le dossier de destination doit être **le dossier servi** (celui qui contient `index.html` du site),
  pas un dossier annexe
- Vérifiez que l'option de suppression/miroir est **désactivée**
- Après le premier passage, lancez `verifier-deploiement.sh` : si un fichier est « MANQUANT » ou
  « DIFFERENT », l'outil ne déploie pas au bon endroit

---

## Ce qui doit se voir sur le site après un déploiement réussi

- Accueil : la 3e carte affiche **UNIVOQ Chantier** avec la pastille bleue **En Test** et un bouton **Découvrir**
- `univoq-chantier.html` : page complète (planning Gantt, réserves, tarifs Éco / Artisan Éco / Artisan Full, FAQ)
- `commande.html` : 6 liens de paiement + l'encadré « Votre identifiant appareil » qui n'apparaît que
  si l'on arrive avec `?aid=` (par exemple `commande.html?aid=CH-0123456789ABCDEF`)
- Les vidéos de `bailliko.html` et `patrimoine-pilote.html` fonctionnent toujours
- Les téléchargements d'APK fonctionnent toujours (`compteur.php?dl=1` … `dl=4`)
