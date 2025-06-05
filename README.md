# Projet Terraform : Déploiement N-tier WordPress sur Azure

## Description

Déploiement d’une infrastructure N-tier sur Azure avec Terraform :  
- Image Docker WordPress personnalisée stockée dans Azure Container Registry (ACR)  
- Azure Web App Linux déployant le conteneur depuis ACR  
- Base de données Azure MySQL Flexible Server accessible uniquement par la Web App

Deux environnements : **dev** et **prod**.

## Prérequis

- Compte Azure avec droits suffisants  
- Azure CLI, Terraform et Docker installés  
- Git pour gérer le code

## Structure

