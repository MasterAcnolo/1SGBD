USE NewWorld;

-- Monnaies
INSERT INTO Monnaie (Nom, Symbole) VALUES ('Euro', '€');

-- Pays
INSERT INTO Pays (Code, Name, Continent, Region, SurfaceArea, IndependanceYear, Population, LifeExpectancy, PIB, PIB_OLD, LocalName, GovernmentForm, HeadOfState, Code2, Id_Monnaie) 
VALUES ('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 1789, 67000000, 82.5, 2800000.00, 2650000.00, 'France', 'République', 'Emmanuel Macron', 'FR', 1);

-- Villes
INSERT INTO Ville (Nom, Code_de_Pays, District, Population, Surface, PIB, id_pays) 
VALUES ('Paris', 'FRA', 'Île-de-France', 2165000, 105.40, 750000.00, 1);

-- Mise à jour capitale
UPDATE Pays SET Capital = 1 WHERE Code = 'FRA';

-- Armées
INSERT INTO Armee (nombre_infanterie, nombre_chars, nombre_aviations, nombre_portes_avions, nombre_sous_marins, qualite_armee, haveNuclear, id_pays) 
VALUES (115000, 406, 1057, 1, 10, 85, TRUE, 1);

-- Langues
INSERT INTO Langue (Code_de_Pays, Langue, EstOfficiel, Pourcentage, id_pays) 
VALUES ('FRA', 'Français', TRUE, 95.0, 1);

-- Guerres (nécessite 2 pays minimum)
INSERT INTO Pays (Code, Name, Continent, Region, SurfaceArea, IndependanceYear, Population, LifeExpectancy, PIB, PIB_OLD, LocalName, GovernmentForm, HeadOfState, Code2, Id_Monnaie) 
VALUES ('USA', 'United States', 'North America', 'North America', 9629091.00, 1776, 331000000, 78.9, 21000000.00, 20500000.00, 'United States', 'Federal Republic', 'Joe Biden', 'US', 1);

INSERT INTO Guerre (id_pays, id_pays_1, date_debut, date_fin, statut) 
VALUES (1, 2, '2024-01-15', NULL, 'en_cours');