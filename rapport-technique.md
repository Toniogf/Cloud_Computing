# Rapport Technique – Déploiement d’une architecture N-tier sur Azure

**Nom** : Tonio Goncalves Freitas  
**Date** : Juin 2025  
**Projet** : Déploiement d’une infrastructure cloud en mode Infra-as-Code avec Terraform  
**Environnements** : Développement et Production  
**Cloud provider** : Microsoft Azure

---

## 1. Objectifs du projet

Ce projet a pour but de mettre en œuvre une architecture N-tier sur le cloud Azure, entièrement déployée via Terraform (Infra-as-Code). L’objectif est d’héberger une application WordPress dans un conteneur personnalisé, stocké dans Azure Container Registry (ACR), et déployé dans une Azure Web App Linux. Cette application est reliée à une base de données Azure MySQL Flexible Server, et le tout doit pouvoir être répliqué facilement pour plusieurs environnements (dev et prod).

Les compétences mobilisées sont :

- La conception d’une architecture cloud N-tier
- L’utilisation de Terraform pour le provisionnement des ressources Azure
- La gestion d’une image Docker personnalisée
- Le déploiement d’un site WordPress via Azure Web App
- La sécurisation des connexions entre les services
- L’utilisation de GitHub comme référentiel de code versionné

---

## 2. Architecture cible

L'architecture déployée repose sur 3 couches principales :

1. **Frontend / Présentation** :
   - Une application WordPress exécutée dans un conteneur Docker personnalisé
   - Hébergée dans une Web App Linux sur Azure

2. **Backend / Logique métier** :
   - Gérée via WordPress lui-même, avec ses plugins et son thème personnalisé

3. **Base de données / Persistance** :
   - Une instance Azure MySQL Flexible Server
   - Accessible uniquement par la Web App

---

## 3. Étapes de réalisation

### a. Création de l’image Docker personnalisée

J’ai d’abord modifié un thème WordPress de base en y insérant un logo personnalisé et quelques personnalisations visuelles dans le dossier `custom-theme/`.  
Puis, j’ai écrit un `Dockerfile` basé sur l’image officielle WordPress, copiant ce thème dans le répertoire adéquat. J’ai également défini ce thème comme thème par défaut à l’installation.

Voici les grandes étapes :

- Dockerfile basé sur `wordpress:php8.2-apache`
- Copie du thème dans `/var/www/html/wp-content/themes/`
- Ajout de `WP_DEFAULT_THEME` dans le fichier de config

Ensuite, j’ai utilisé Azure CLI pour me connecter à mon ACR, puis j’ai poussé l’image :

az acr login --name acrdevnwordpress
docker build -t acrdevnwordpress.azurecr.io/wordpress-custom:latest ./Docker
docker push acrdevnwordpress.azurecr.io/wordpress-custom:latest

b. Infrastructure avec Terraform
Le projet Terraform est structuré avec deux dossiers dev/ et prod/, chacun ayant ses propres fichiers :

main.tf : contient les ressources à déployer (Web App, ACR, MySQL…)

variables.tf : contient les variables réutilisables

terraform.tfvars : valeurs spécifiques à chaque environnement

Les ressources déployées sont :

Un groupe de ressources

Un Azure Container Registry

Un plan App Service Linux

Une Web App Linux tirant l’image depuis ACR

Une base MySQL Flexible Server

c. Connexion entre les ressources
Pour relier la Web App au registre ACR, j’ai utilisé l’authentification par nom d’utilisateur et mot de passe (activé avec admin_enabled = true).

Les paramètres de connexion MySQL sont injectés dans la Web App via les app_settings :

hcl
Copier
Modifier
"WORDPRESS_DB_HOST"     = azurerm_mysql_flexible_server.mysql.fqdn
"WORDPRESS_DB_USER"     = "${var.mysql_admin}@${azurerm_mysql_flexible_server.mysql.name}"
"WORDPRESS_DB_PASSWORD" = var.mysql_password
La base de données est en mode public pour simplifier le test, mais j’ai prévu une règle de pare-feu pour n’accepter que l’IP sortante de la Web App dans un contexte plus sécurisé.