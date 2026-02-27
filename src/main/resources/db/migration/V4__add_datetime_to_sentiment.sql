-- Ou si vous voulez que ce soit nullable mais avec une valeur par défaut
ALTER TABLE sentiment ADD COLUMN timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;