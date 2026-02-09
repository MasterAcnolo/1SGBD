USE world_sim;

-- Tables principales World
DESCRIBE Country;
DESCRIBE City;
DESCRIBE CountryLanguage;

-- Tables du jeu
DESCRIBE GUERRE;
DESCRIBE ARMEE;

-- Clés et contraintes
SHOW INDEX FROM Country;
SHOW CREATE TABLE GUERRE;
SHOW CREATE TABLE ARMEE;
