# SupSimulation – Sujet de projet Base de Données

## Introduction

Vous êtes ingénieur en bases de données au sein du studio indépendant **SupGames**, actuellement en développement de son jeu **SupSimulation**.

SupSimulation est un jeu solo de **simulation géopolitique**. Le joueur choisit un pays et prend des décisions stratégiques : alliances, guerres, conquêtes de territoires, etc.  
Chaque décision peut avoir des répercussions à l’échelle mondiale.

Le jeu est encore à l’état d’ébauche et repose sur la base de données **World**, fournie par MySQL :  
https://downloads.mysql.com/docs/world-db.zip

Une démonstration du jeu sera prochainement présentée à un éditeur dans l’objectif d’obtenir un soutien pour le projet.

---

## Partie 1 : Modification des données (12 points)

Afin d’appuyer la démonstration, vous devez **modifier les données de la base World** pour représenter un état du monde plausible après **une heure de jeu**.

### Objectif

- Produire **un script SQL par continent**
- Chaque script doit contenir **tous les ajouts, modifications et suppressions nécessaires**
- Les données doivent rester **cohérentes**

### Remarque importante

Chaque modification doit prendre en compte **toutes ses implications**.

**Exemple : annexion du Portugal par l’Espagne**
- Les villes portugaises deviennent espagnoles
- La population, la surface et le PIB de l’Espagne augmentent
- L’espérance de vie est recalculée

**Exemple : indépendance de Paris**
- Création d’un nouveau pays
- La population de Paris est retirée de celle de la France

Les données non directement déductibles peuvent être **définies arbitrairement**.

---

### État du monde après une heure de jeu

#### 1. Amérique

- Le Canada annexe les États américains suivants :
  - Michigan
  - Wisconsin
  - Illinois
  - Alaska
  - Washington

- Le Québec et l’Ontario deviennent un **État souverain**
  - Capitale : Montréal

- Les États-Unis conquièrent :
  - Mexique
  - Cuba
  - Venezuela
  - Colombie

- En réaction, tous les pays **hispanophones situés au sud de la Colombie et du Brésil** fusionnent en un seul pays :
  - **Les Nouveaux États-Unis d’Amérique**

---

#### 2. Europe

- En France :
  - La Bretagne colonise la Normandie et devient un **État souverain**
    - Capitale : Rennes
    - Langue officielle : breton
  - La région Centre devient indépendante sous le nom :
    - **République du Val de Loire**
    - Capitale : Tours
  - Lyon, Caen et Lille deviennent des **cités-États indépendantes**

- Le Liechtenstein annexe :
  - La Suisse
  - La Lombardie

---

#### 3. Asie

- La Corée du Nord et la Corée du Sud fusionnent
- Elles conquièrent :
  - La Chine
  - Le Japon
- Le nouvel empire se nomme :
  - **La Grande Corée**

---

## Partie 2 : Modélisation des données (8 points)

La présentation a convaincu l’éditeur. Il faut désormais concevoir une base de données **plus réaliste et évolutive**.

### 1. Modèle

Dans un document **.pdf**, vous devez :

- Expliquer les **limites de la base World** pour SupSimulation
- Proposer une **nouvelle modélisation** adaptée au jeu
- Respecter la méthode **Merise** :
  - MCD (Modèle Conceptuel de Données)
  - MLD (Modèle Logique de Données)
  - MPD (Modèle Physique de Données)

Le document doit contenir :
- Les diagrammes directement intégrés au PDF
- Un **dictionnaire des données** joint au format **.xlsx**

⚠️ Les nouvelles entités doivent être **liées directement au gameplay**

**Exemples pertinents**
- Soldat
- Sous-marin
- Alliance
- Guerre

**Exemples non pertinents**
- Joueur
- Date de début de partie
- Sauvegardes

---

### 2. Création

- Créer une nouvelle base de données : **NewWorld**
- Créer toutes les tables issues de la modélisation
- Insérer **au moins une ligne par table** pour démonstration

---

## Bonus : Import des données (5 points)

Proposer une **méthode intelligente** pour exporter les données de la base **World** vers la base **NewWorld**.
