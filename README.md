# 1SGBD - Projet Base de Données

## Description

Projet de bases de données géopolitique développé dans le cadre du cours SGBD.

## Structure du projet

### Avant de commencer

Avant de commencer, vérifiez que la base de données World de MySQL est propre. Si nécessaire, réinstallez-la avec le dump fourni dans `ressources/world.sql`.

Ensuite, lancez le script `utils/dropWorldCopy.sql` si vous avez déjà lancé la base. Sinon, lancez `init.sql` puis testez les scénarios selon vos besoins. 

### Partie 1 - Modification de la base World

Scripts de modification des données originales de la base MySQL World pour simuler une heure de jeu géopolitique.

**Emplacement :** dossier `script/`

Les scripts sont organisés par continent :
- AMERICA : modifications sur le continent américain
- EUROPA : modifications sur le continent européen
- ASIA : modifications sur le continent asiatique

Chaque fichier constitue un scénario indépendant.

### Partie 2 - Nouvelle modélisation NewWorld

Refonte complète de la base de données avec ajout de nouvelles entités pour le jeu de simulation.

**Emplacement :** dossier `NewWorld/`

Cette partie contient :
- Scripts de création de la base optimisée
- Scripts d'insertion des données
- Modélisation complète selon Merise (MCD, MLD, MPD)

**Diagrammes Looping :** dossier `blueprints/`

## Installation et lancement

### Prérequis

- MySQL 8.0 ou supérieur
- Accès à la base de données World de MySQL (Disponible dans `ressources/world.sql`)

### Partie 1 - Lancer les modifications World

Exécutez les scripts SQL dans l'ordre souhaité selon les continents :

1. Connectez-vous à MySQL
2. Sélectionnez la base World
3. Exécutez les scripts du dossier `script/` par continent

### Partie 2 - Créer la base NewWorld

1. Connectez-vous à MySQL
3. Exécutez le script `NewWorld/createNewWorld.sql`
4. Testez avec `NewWorld/testInsert.sql`

### Utilitaires

Le dossier `utils/` contient des scripts de maintenance :
- `check.sql` : vérification de la base
- `dropWorld.sql` : suppression de la base World
- `dropWorldCopy.sql` : suppression des copies

## Documentation

La documentation complète de la modélisation (analyse des limites, MCD, MLD, MPD) est disponible dans le document PDF joint au projet.

## Auteur

Axel NICOLAS - SupInfo Caen - 2026
