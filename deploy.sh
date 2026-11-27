#!/bin/bash
# =============================================================================
#  Compilation + packaging (.war) + déploiement Tomcat d'un projet MY_FRAMEWORK
#  Usage : ./deploy.sh
# =============================================================================

# Arrêt immédiat à la première erreur (compilation ratée => pas de déploiement)
set -euo pipefail

# Toujours travailler depuis le dossier du script
cd "$(dirname "$(readlink -f "$0")")"

# ----------------------------- Configuration ---------------------------------
APP_NAME="Medecine"                       # => http://localhost:8080/Medecine/
SRC_DIR="src/main/java"                   # sources Java
WEB_DIR="src/main/webapp"                 # web.xml, JSP...
BUILD_DIR="build"
LIB_DIR="lib"
TOMCAT_HOME="/home/tendry/itu/S4/MR_NAINA/tomcat"
TOMCAT_WEBAPPS="$TOMCAT_HOME/webapps"
# -----------------------------------------------------------------------------

err()  { echo -e "\e[31m[ERREUR]\e[0m $*" >&2; exit 1; }
info() { echo -e "\e[34m[INFO]\e[0m $*"; }
ok()   { echo -e "\e[32m[OK]\e[0m $*"; }

# --- Vérifications -----------------------------------------------------------
command -v mvn   >/dev/null || err "Maven introuvable."
[ -d "$SRC_DIR" ]                || err "Dossier des sources introuvable : $SRC_DIR"
[ -f "$WEB_DIR/WEB-INF/web.xml" ] || err "web.xml introuvable : $WEB_DIR/WEB-INF/web.xml"
[ -f "$LIB_DIR/MY_FRAMEWORK.jar" ] || err "$LIB_DIR/MY_FRAMEWORK.jar introuvable."
[ -d "$TOMCAT_WEBAPPS" ]         || err "Dossier Tomcat introuvable : $TOMCAT_WEBAPPS"

WAR_FILE="$BUILD_DIR/$APP_NAME.war"
info "Compilation et création de l'archive avec Maven..."
mvn -q clean package || err "La compilation ou la création du .war a échoué."
[ -f "$WAR_FILE" ] || err "Archive introuvable après compilation : $WAR_FILE"
ok "Compilation réussie. Archive créée : $WAR_FILE"

# --- Déploiement -------------------------------------------------------------
info "Déploiement dans $TOMCAT_WEBAPPS..."
# Supprime l'ancienne version (dossier décompressé) pour forcer un redéploiement propre
rm -rf "${TOMCAT_WEBAPPS:?}/$APP_NAME"
cp -f "$WAR_FILE" "$TOMCAT_WEBAPPS/"

echo ""
ok "Déploiement terminé."
echo "    -> http://localhost:8080/$APP_NAME/patients"
echo "    (Démarrer Tomcat si nécessaire : $TOMCAT_HOME/bin/startup.sh)"
echo ""
