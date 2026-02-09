-- LISTE DES DONNEES SUPLEMENTAIRES
-- GUERRE (Défenseur / Attaquant ou équivalent)
-- ALLIANCE (Pays 1, Pays 2)
-- ARMEE (Champ Infanteries, Artillerie, )

CREATE TABLE IF NOT EXISTS `GUERRE`(
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `id_pays_attaquant` INTEGER NOT NULL,
    `id_pays_defenseur` INTEGER NOT NULL,
    `estActive` BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_pays_attaquant`) REFERENCES `country`(`ID`),
    FOREIGN KEY (`id_pays_defenseur`) REFERENCES `country`(`ID`)
);

-- Table ARMEE avec relation vers la table pays
CREATE TABLE IF NOT EXISTS `ARMEE`(
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `id_pays` INTEGER NOT NULL,
    `nombre_soldats` INTEGER DEFAULT 0,
    `nombre_chars` INTEGER DEFAULT 0,
    `nombre_avions` INTEGER DEFAULT 0,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id_pays`) REFERENCES `country`(`ID`)
);