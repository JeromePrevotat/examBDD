-- 1. Créer la base de données « bibliotheque » en UTF8.
CREATE DATABASE bibliotheque CHARACTER SET utf8mb4;

-- Créer les 3 tables en respectant les contraintes de relation et de référence. Les # ne doivent pas paraître dans le nom des champs.
CREATE TABLE IF NOT EXISTS adhérents(
    id_adhérent INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    date_inscription DATE NOT NULL,
    a_surveiller BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS livres(
    isbn INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    auteur VARCHAR(255) NOT NULL DEFAULT 'Anonyme',
    année_publication INT,
    disponible BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS emprunts(
    id_adhérent INT NOT NULL,
    FOREIGN KEY (id_adhérent) REFERENCES adhérents(id_adhérent),
    isbn INT NOT NULL,
    FOREIGN KEY (isbn) REFERENCES livres(isbn),
    date_emprunt DATE NOT NULL,
    date_retour DATE DEFAULT NULL
);

-- 2. Créer un utilisateur « bibliothecaire » avec le mot de passe « secret » ayant accès uniquement à cette base de données bibliotheque avec tous les droits.
CREATE USER IF NOT EXISTS 'bibliothecaire'@'localhost';
ALTER USER bibliothecaire IDENTIFIED BY 'secret';

/* 3. Ajouter les adhérents : Jane Austen, Charles Dickens, Jules Verne, Mary Shelley. 
Ajouter les livres : "Orgueil et Préjugés", "David Copperfield", "Vingt mille lieues sous les mers", "Frankenstein".
Ajouter des emprunts pour que chaque adhérent emprunte chaque chaque livre.*/
INSERT INTO adhérents(nom, adresse, date_inscription, a_surveiller) VALUES
    ('Jane Austen', 'England', '1775-12-16', FALSE),
    ('Charles Dickens', 'Portsmouth, England', '1812-02-07', FALSE),
    ('Jules Vernes', 'France', '1828-02-08', FALSE),
    ('Mary Shelley', 'Londres', '1797-08-30', FALSE);

INSERT INTO livres (titre, auteur, année_publication, disponible) VALUES
    ('Orgueil et Préjugés', 'Jane Austen', '1813-01-28', TRUE),
    ('David Copperfield', 'Charles Dickens', '1850-11-01', TRUE),
    ('Vingt mille lieues sous les mers', 'Jules Vernes', '1870-06-20', TRUE),
    ('Frankenstein', 'Mary Shelley', '1818-01-01', TRUE);

INSERT INTO emprunts(id_adhérent, isbn, date_emprunt, date_retour) VALUES
    ((SELECT id_adhérent FROM adhérents WHERE adhérents.nom = 'Jane Austen'),
    (SELECT isbn FROM livres WHERE livres.titre = 'David Copperfield'),
    CURRENT_DATE(), CURRENT_DATE() + 30),
    ((SELECT id_adhérent FROM adhérents WHERE adhérents.nom = 'Charles Dickens'),
    (SELECT isbn FROM livres WHERE livres.titre = 'Vingt mille lieues sous les mers'),
    CURRENT_DATE(), CURRENT_DATE() + 30),
    ((SELECT id_adhérent FROM adhérents WHERE adhérents.nom = 'Jules Vernes'),
    (SELECT isbn FROM livres WHERE livres.titre = 'Frankenstein'),
    CURRENT_DATE(), CURRENT_DATE() + 30),
    ((SELECT id_adhérent FROM adhérents WHERE adhérents.nom = 'Mary Shelley'),
    (SELECT isbn FROM livres WHERE livres.titre = 'Orgueil et Préjugés'),
    CURRENT_DATE(), CURRENT_DATE() + 30);

-- 4. Charles Dickens déménage, mettez à jour son adresse dans la base de données.
UPDATE TABLE adhérents SET adresse = 'Deutschland' WHERE nom = 'Charles Dickens';

-- 5. Un livre est empruntable 30 jours, faites une vue qui affiche les personnes qui ont des livres en retard et les livres en question
CREATE VIEW retards_emprunts AS (
    SELECT adhérents.*, livres.* FROM adhérents
    JOIN emprunts
    ON emprunts.id_adhérent = adhérents.id_adhérent
    JOIN livres
    ON emprunts.isbn = livres.isbn
    WHERE emprunts.date_retour - emprunts.date_emprunt > 30    
    );

-- 6. Créer un trigger qui passe le booléen « disponible » à true si la date de retour d’un livre est précisée
DELIMITER //
CREATE TRIGGER livre_dispo AFTER UPDATE ON livres
FOR EACH ROW BEGIN
    IF (NEW.date_retour != NULL) THEN
        UPDATE TABLE livres SET livres.disponible = TRUE WHERE livres.isbn = NEW.isbn;
    END IF;
END //
DELIMITER ;

-- 7. Créer une procédure stockée qui passe le booléen « a_surveiller » à true si une personne a un retard de plus de 30 jours
-- 8. Mary Shelley arrête son adhésion à la bibliothèque, supprimez son enregistrement de la base de données.
-- 9. Sur quel(s) champ(s) pourrait-on mettre un index pour optimiser les requêtes et pourquoi ?
-- 10. La bibliothèque doit se conformer à la RGPD. Quelle requête SQL utiliseriez-vous pour anonymiser la base de données? pour supprimer toute la base de données ?