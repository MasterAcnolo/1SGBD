# 1SGBD - Projet Base de Données

## Description

Projet de bases de données géopolitique développé dans le cadre du cours SGBD.

Le projet est divisé en deux parties :
- **Partie 1** : Modification de la base World existante avec des scénarios géopolitiques
- **Partie 2** : Conception d'une nouvelle base de données optimisée (NewWorld)

## Structure du projet

### Partie 1 - Modification de la base World

Scripts de modification des données originales de la base MySQL World pour simuler une heure de jeu géopolitique.

**Emplacement :** `script/`

Les scripts sont organisés par continent :
- `AMERICA/` : modifications sur le continent américain
- `EUROPA/` : modifications sur le continent européen
- `ASIA/` : modifications sur le continent asiatique

Chaque fichier constitue un scénario indépendant.

### Partie 2 - Nouvelle modélisation NewWorld

Refonte complète de la base de données avec ajout de nouvelles entités pour le jeu de simulation.

**Emplacement :** `NewWorld/`

Contenu :
- Scripts de création et d'insertion des données
- Modélisation complète selon Merise (MCD, MLD, MPD)

### Diagrammes de modélisation

**Emplacement :** `blueprints/`

Fichiers Looping contenant les diagrammes MCD :
- `MCD.loo` : diagramme Looping

### Utilitaires

**Emplacement :** `utils/`

Scripts de maintenance :
- `check.sql` : vérification de la base
- `dropWorld.sql` : suppression de la base World
- `dropWorldCopy.sql` : suppression des copies

### Ressources

**Emplacement :** `ressources/`

- `world.sql` : dump de la base de données World de MySQL

## Installation et lancement

### Prérequis

- MySQL 8.0 ou supérieur
- Base de données World de MySQL (dump fourni dans `ressources/world.sql`)

### Préparation initiale

1. Vérifiez que la base de données World est propre
2. Si nécessaire, réinstallez-la avec `ressources/world.sql`
3. Si vous avez déjà lancé la base, exécutez `utils/dropWorldCopy.sql`
4. Lancez `init.sql` pour initialiser l'environnement

### Lancer la Partie 1

Exécutez les scripts SQL selon les continents souhaités :

1. Connectez-vous à MySQL
2. Sélectionnez la base World
3. Exécutez un ou plusieurs scripts du dossier `script/` par continent

### Lancer la Partie 2

Créez et testez la nouvelle base NewWorld :

1. Connectez-vous à MySQL
2. Exécutez le script `NewWorld/createNewWorld.sql`
3. Testez avec `NewWorld/testInsert.sql`

## Documentation

La documentation complète de la modélisation (analyse des limites, MCD, MLD, MPD) est disponible dans le document PDF joint au projet.

## Auteur

Axel NICOLAS - SupInfo Caen - 2026
