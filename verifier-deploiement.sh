#!/bin/sh
# Controle du deploiement du depot vers irivo.fr
# A lancer DANS le dossier servi (www) :  sh verifier-deploiement.sh
cd "$(dirname "$0")" || exit 1
if command -v sha256sum >/dev/null 2>&1; then H="sha256sum"; else H="shasum -a 256"; fi
printf "%-40s %s\n" "Fichier" "Etat"
echo "-----------------------------------------------------"
cat <<'EOF' > /tmp/.irivo_ref
5ba0ea8e303b9a1709981c773226639e7f71fb9213d856595436e2e8123b9912  DEPLOIEMENT-OVH.md
238842b1588a0ab4289229957c5939aeb4fccbc533ce18c17edaef44e7734309  README.md
1d75656e26feee7549e050be3edce9d884f1e67bd60d88fe2a47e8100b4f061d  UNIVOQ-Chantier.apk
7cdea1ba97754e12e901c29cc7b3c054170c7a2d152b0ac1fef8313ad640ca21  bailliko.html
725764fa3d5e197fddd3071b74f21623f7103813b68fdc2a6dc1c7c3ef7863e4  bailliko/icone-bailliko.png
e31586dd9222e85a1dbdbe31bea4cd585116aeecf0baafccc99de83f8d605722  cgv.html
8ecbcbb272f54bc90ac255a2b0336b4400a443b97b252396926edda9a4fa04d3  commande.html
c3e975153d4a55679bcb01a8ef70521c6a9d5d0b04920321820596aa450b29c0  confidentialite.html
9d40ac191a2fe321c10c891c36054fd083732c3ce3bfa544d08e3fd057a886c1  ecran-ifi.png
a7c1a49e87eca315ffc1199efec9a200fc21fd782f3b62175e2d9e5de745e17c  ecran-import-bailliko.png
d2fdb9f21d569eb5da94d4ac01d8359cc0309264c24b1d24d752f0a15d0801b8  ecran-patrimoine.png
f957b9f2ab4d68c8e8364fa667ccfcc1107fad16c6d7bea2270e7ecc5de39c19  ecran-simulateur.png
1954171f077d6f35c7cef4e28e4136725a13d1e3ff78242e63331bf7ed0c1c87  guide-revision-irl.html
263a085a3cfab4f88c04e730e3c3a0f8949c4e103098529244f07c2f3914ad7c  icone-patrimoine-pilote.png
ae3fbe761f17c7eaf88d4a6dca5c973da2ee5b91887ba12242ebd344570e0527  index.html
8102e59e32ac2cdb80581d62ec0476eaae72621f9219cf97754682b8341837ce  irivo-batiment.html
c8dea3a46ad9444a5657a467c7a7096881f59e7e4dfc1d58c713a28a7e25d1d2  irivo-catalogue.json
83b1e43d4589b0313300ad82633c68f589d872c27bf8de67da5abf61ccb60812  logo-irivo.png
82e707dbfa95a7d194007d84e33518aee95b87e1d77b287bfc6dea04a73808e1  mentions-legales.html
598d5301081abbffc9419d4150b1ca7aabeff1558b5e4caa0b46db540454d99f  patrimoine-pilote.html
659f13ea5c51dbdce44bcce60e3922ea280d9aaa808f1fbcb880a36b57bbb8d4  style.css
e6d18cfcc0b7a02edbc22376a9a301b7117cc58a3e4396b2431d08e0c8dd61dd  univoq-chantier.html
184c3bbdc7fde337043edeba278a0f518dade30e99d652eabf4ba85e6956fd0f  univoq-chantier/icone-univoq-chantier.png
3475bd8f02b97f0dd49cc8e5dad3819cece48d79276b340482179d9e25812917  univoq/icone-univoq-artisan-eco.png
c478427a2ededfcd7d171f4f0c5cbf3fbb56eba91f4d31da110d992debfd7385  univoq/icone-univoq-artisan-full.png
cfd5d965c0186e5a6cf63a6ddad6e8571c9809a7c785dad1f0ec34cbee3d0d77  univoq/icone-univoq-solo.png
EOF
while read -r sha nom; do
  [ -z "$sha" ] && continue
  if [ ! -f "$nom" ]; then printf "%-40s MANQUANT\n" "$nom"; continue; fi
  a=$($H "$nom" | cut -d" " -f1)
  if [ "$a" = "$sha" ]; then printf "%-40s OK\n" "$nom"; else printf "%-40s DIFFERENT\n" "$nom"; fi
done < /tmp/.irivo_ref
rm -f /tmp/.irivo_ref
