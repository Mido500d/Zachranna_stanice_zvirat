-- =============================================================================
-- Seminární projekt: Záchranná stanice pro divoce žijící zvířata
-- Skript: create.sql
-- Použitý dialekt: Standardní ANSI SQL (kompatibilní s PostgreSQL/MySQL)
-- =============================================================================

-- Smazání tabulek v případě, že již existují (pro snadný re-run)
DROP TABLE IF EXISTS Financni_Dar;
DROP TABLE IF EXISTS Sponzor;
DROP TABLE IF EXISTS Denni_Zaznam;
DROP TABLE IF EXISTS Zviratko;
DROP TABLE IF EXISTS Osetrovatel;
DROP TABLE IF EXISTS Klec_Voliera;
DROP TABLE IF EXISTS Druh_Zvirete;
DROP TABLE IF EXISTS Nalezce;

-- 1. Tabulka: Nalezce (5 atributů)
CREATE TABLE Nalezce (
    id_nalezce INT PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    telefon VARCHAR(15),
    email VARCHAR(100)
);

-- 2. Tabulka: Druh_Zvirete (4 atributy)
CREATE TABLE Druh_Zvirete (
    id_druh INT PRIMARY KEY,
    nazev_druhu VARCHAR(100) NOT NULL,
    latinsky_nazev VARCHAR(100),
    stupen_ohrozeni VARCHAR(30)
);

-- 3. Tabulka: Klec_Voliera (5 atributů)
CREATE TABLE Klec_Voliera (
    id_klec INT PRIMARY KEY,
    oznaceni VARCHAR(10) NOT NULL,
    typ_prostoru VARCHAR(50) NOT NULL,
    kapacita_zvirat INT NOT NULL,
    datum_posledni_dezinfekce DATE
);

-- 4. Tabulka: Osetrovatel (5 atributů)
CREATE TABLE Osetrovatel (
    id_osetrovatel INT PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    telefon VARCHAR(15),
    specializace VARCHAR(100)
);

-- 5. Tabulka: Sponzor (5 atributů)
CREATE TABLE Sponzor (
    id_sponzor INT PRIMARY KEY,
    nazev_sponzora VARCHAR(100) NOT NULL,
    kontaktni_osoba VARCHAR(100),
    email VARCHAR(100),
    typ_sponzora VARCHAR(20) -- 'Fyzická osoba' nebo 'Firma'
);

-- 6. Tabulka: Zviratko (6 atributů)
CREATE TABLE Zviratko (
    id_zviratko INT PRIMARY KEY,
    id_druh INT NOT NULL,
    id_klec INT,
    id_nalezce INT,
    prezdivka VARCHAR(50),
    datum_prijmu DATE NOT NULL,
    FOREIGN KEY (id_druh) REFERENCES Druh_Zvirete(id_druh),
    FOREIGN KEY (id_klec) REFERENCES Klec_Voliera(id_klec),
    FOREIGN KEY (id_nalezce) REFERENCES Nalezce(id_nalezce)
);

-- 7. Tabulka: Denni_Zaznam (5 atributů) - IDENTIFIKAČNÍ ZÁVISLOST
-- Slabá entita závislá na entitě Zviratko. Primární klíč je složený.
CREATE TABLE Denni_Zaznam (
    id_zviratko INT,
    datum_zaznamu DATE,
    id_osetrovatel INT NOT NULL,
    vaha_gramy INT NOT NULL,
    zdravotni_stav_popis TEXT,
    PRIMARY KEY (id_zviratko, datum_zaznamu),
    FOREIGN KEY (id_zviratko) REFERENCES Zviratko(id_zviratko) ON DELETE CASCADE,
    FOREIGN KEY (id_osetrovatel) REFERENCES Osetrovatel(id_osetrovatel)
);

-- 8. Tabulka: Financni_Dar (5 atributů)
CREATE TABLE Financni_Dar (
    id_dar INT PRIMARY KEY,
    id_sponzor INT NOT NULL,
    id_zviratko INT, -- Může být NULL, pokud jde o obecný dar stanici
    castka_kc DECIMAL(10, 2) NOT NULL,
    datum_platby DATE NOT NULL,
    FOREIGN KEY (id_sponzor) REFERENCES Sponzor(id_sponzor),
    FOREIGN KEY (id_zviratko) REFERENCES Zviratko(id_zviratko) ON DELETE SET NULL
);
