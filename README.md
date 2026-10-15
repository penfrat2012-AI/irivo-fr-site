# irivo-fr-site — miroir officiel du site irivo.fr

Ce dépôt contient **le site irivo.fr tel qu'il est en ligne** (source de vérité), plus le
fichier de liaison `irivo-catalogue.json` utilisé par la console IRIVO pour synchroniser
les espaces de travail.

> Objectif : que le dépôt soit **une copie exacte du site**. Ainsi, un déploiement
> (git pull chez l'hébergeur) ne peut plus écraser une page en ligne par une version
> dégradée.

## Contenu

| Fichier | Rôle |
|---|---|
| `index.html` | Portail : Bailliko, Patrimoine Pilote, **UNIVOQ Chantier** (En Test), IRIVO Bâtiment (Bientôt) |
| `bailliko.html` | Page produit Bailliko (vidéos + images intégrées) |
| `patrimoine-pilote.html` | Page produit Patrimoine Pilote (Solo 59 €, Pack IRIVO 89 €, Duo Pro 139 €) |
| `univoq-chantier.html` | Page produit UNIVOQ Chantier (Éco / Artisan Éco / Artisan Full) |
| `irivo-batiment.html` | Page produit IRIVO Bâtiment (à venir) |
| `commande.html` | Paiement Stripe : 9 liens + espace client + **activation automatique `?aid=`** |
| `style.css` | Feuille de style officielle |
| `guide-revision-irl.html`, `mentions-legales.html`, `cgv.html`, `confidentialite.html` | Pages légales et guide |
| `logo-irivo.png`, `icone-patrimoine-pilote.png`, `bailliko/icone-bailliko.png`, `ecran-*.png` | Images du site |
| `irivo-catalogue.json` | **Liaison inter-espaces de travail** (fiches des applications, réglages du site) |
| `MANIFESTE.txt` | Tailles + empreintes SHA-256 de chaque fichier |
| `verifier-deploiement.sh` | Contrôle du déploiement, à lancer sur le serveur |

## Fichiers volontairement absents du dépôt

Ils restent **uniquement sur le serveur** (trop lourds, et ils ne doivent jamais être
supprimés par un déploiement) :

- `compteur.php` — compteur de téléchargements
- `Bailliko.apk`, `Patrimoine-Pilote.apk`, `IRIVO-Batiment.apk`
  (`UNIVOQ-Chantier.apk` est désormais dans le dépôt : le déploiement le porte sur le serveur)
- `bailliko/presentation BAILLIKO site.mp4`, `bailliko/video-bailliko-ecrans.mp4`
- `patrimoine-pilote-presentation.mp4`

## Correspondance des identifiants d'appareil (`?aid=`)

L'application ouvre `commande.html?aid=XX-XXXXXXXXXXXXXXXX` : l'identifiant est ajouté
à tous les liens Stripe (`client_reference_id`), et Stripe le renvoie au webhook qui
active la licence de l'appareil. Préfixes gérés :

| Préfixe | Application |
|---|---|
| `BK-` | Bailliko |
| `PP-` | Patrimoine Pilote |
| `CH-` | **UNIVOQ Chantier** |
| `BT-` | IRIVO Bâtiment |

## Nouveautés appliquées dans cette version du dépôt

1. `index.html` : la carte « IRIVO Chantier / Bientôt » devient **« UNIVOQ Chantier / En Test »**, cliquable vers `univoq-chantier.html`.
2. `style.css` : nouvelle classe `.badge-test` (pastille bleue « En Test »).
3. `commande.html` : **rétablissement de l'activation automatique de licence** (`?aid=` → `client_reference_id`), avec les 4 préfixes ; l'encadré « Votre identifiant appareil » réapparaît uniquement quand on arrive depuis une application.
4. `univoq-chantier.html` : page régénérée à partir de la fiche officielle du catalogue (fonctionnalités, planning Gantt, tarifs Éco / Artisan Éco / Artisan Full, FAQ).
5. Nettoyage des traces Cloudflare (protection d'e-mail, script de défi) : les pages du dépôt contiennent les adresses `contact@irivo.fr` en clair ; Cloudflare les re-protège automatiquement à l'affichage.

## Points à traiter ensuite

- `irivo-catalogue.json` ne connaît pas encore les 2 produits apparus sur le site :
  **Patrimoine Pilote 59 €/an** (`buy.stripe.com/4gMeVdc1D3yl0Bp3Uc2Nq03`) et
  **Duo Pro 139 €/an** (`buy.stripe.com/dRm3cv9Tvb0N6ZN62k2Nq05`).
- Les liens Stripe d'UNIVOQ Chantier sont désormais réels (Solo 29,90 €, Artisan Éco 99,90 €,
  Artisan Full 299,90 €) ; ceux d'IRIVO Bâtiment restent des marqueurs (`remplacer_lien_...`).
