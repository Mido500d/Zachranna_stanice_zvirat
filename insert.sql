-- =============================================================================
-- Seminární projekt: Záchranná stanice pro divoce žijící zvířata
-- Skript: insert.sql (Ukázková data - každá tabulka obsahuje 8 záznamů)
-- =============================================================================

-- 1. Data pro tabulku Nalezce
INSERT INTO Nalezce (id_nalezce, jmeno, prijmeni, telefon, email) VALUES
(1, 'Jan', 'Novák', '+420777111222', 'jan.novak@seznam.cz'),
(2, 'Petr', 'Svoboda', '+420608333444', 'petr.svoboda@gmail.com'),
(3, 'Marie', 'Černá', '+420723555666', 'marie.cerna@centrum.cz'),
(4, 'Jana', 'Kučerová', '+420775999888', 'kucerova.j@seznam.cz'),
(5, 'Tomáš', 'Dvořák', '+420602111555', 'tomas.dvorak@gmail.com'),
(6, 'Lucie', 'Veselá', '+420731444777', 'lucinka.vesela@seznam.cz'),
(7, 'Martin', 'Horák', '+420776888222', 'martin.horak@outlook.com'),
(8, 'Eva', 'Pokorná', '+420605444111', 'eva.pokorna@seznam.cz');

-- 2. Data pro tabulku Druh_Zvirete
INSERT INTO Druh_Zvirete (id_druh, nazev_druhu, latinsky_nazev, stupen_ohrozeni) VALUES
(1, 'Ježek západní', 'Erinaceus europaeus', 'Chráněný'),
(2, 'Poštolka obecná', 'Falco tinnunculus', 'Málo dotčený'),
(3, 'Labuť velká', 'Cygnus olor', 'Málo dotčený'),
(4, 'Veverka obecná', 'Sciurus vulgaris', 'Ohrožený'),
(5, 'Rorýs obecný', 'Apus apus', 'Silně ohrožený'),
(6, 'Zajíc polní', 'Lepus europaeus', 'Málo dotčený'),
(7, 'Káně lesní', 'Buteo buteo', 'Málo dotčený'),
(8, 'Netopýr rezavý', 'Nyctalus noctula', 'Silně ohrožený');

-- 3. Data pro tabulku Klec_Voliera
INSERT INTO Klec_Voliera (id_klec, oznaceni, typ_prostoru, kapacita_zvirat, datum_posledni_dezinfekce) VALUES
(1, 'V-01', 'Velká letecká voliéra', 5, '2026-05-10'),
(2, 'V-02', 'Malá voliéra pro dravce', 2, '2026-05-12'),
(3, 'T-01', 'Teplé terárium', 10, '2026-05-20'),
(4, 'X-01', 'Venkovní oplocený výběh', 4, '2026-04-15'),
(5, 'I-01', 'Intenzivní intenzivní box', 1, '2026-06-01'),
(6, 'I-02', 'Intenzivní intenzivní box', 1, '2026-06-02'),
(7, 'V-03', 'Vodní voliéra s bazénkem', 6, '2026-05-25'),
(8, 'X-02', 'Malý venkovní výběh', 3, '2026-05-01');

-- 4. Data pro tabulku Osetrovatel
INSERT INTO Osetrovatel (id_osetrovatel, jmeno, prijmeni, telefon, specializace) VALUES
(1, 'Karel', 'Marek', '+420777000111', 'Dravci a rorýsi'),
(2, 'Alena', 'Králová', '+420603222333', 'Drobní savci (ježci, veverky)'),
(3, 'Jiří', 'Beneš', '+420724444555', 'Vodní ptactvo'),
(4, 'Veronika', 'Blažková', '+420732666777', 'Všeobecná péče'),
(5, 'Pavel', 'Kříž', '+420608888999', 'Noční živočichové a netopýři'),
(6, 'Monika', 'Čermáková', '+420775111444', 'První příjem a JIP'),
(7, 'Filip', 'Kopecký', '+420721333999', 'Dravci'),
(8, 'Tereza', 'Malá', '+420604555222', 'Drobní savci');

-- 5. Data pro tabulku Sponzor
INSERT INTO Sponzor (id_sponzor, nazev_sponzora, kontaktni_osoba, email, typ_sponzora) VALUES
(1, 'EkoLes s.r.o.', 'Ing. Petr Zelený', 'info@ekoles.cz', 'Firma'),
(2, 'Zdeněk Urban', 'Zdeněk Urban', 'zdenek.urban@seznam.cz', 'Fyzická osoba'),
(3, 'BioKrmiva a.s.', 'Marta Sladká', 'sladka@biokrmiva.cz', 'Firma'),
(4, 'Anna Dlouhá', 'Anna Dlouhá', 'anna.dlouha@gmail.com', 'Fyzická osoba'),
(5, 'Zelená pro Přírodu o.p.s.', 'Jakub Černý', 'info@zelenaproprirodu.cz', 'Firma'),
(6, 'Michal Kolář', 'Michal Kolář', 'kolar.m@outlook.com', 'Fyzická osoba'),
(7, 'PetFood District s.r.o.', 'Jan Bílý', 'bily@petfood.cz', 'Firma'),
(8, 'Helena Šedivá', 'Helena Šedivá', 'helena.sediva@seznam.cz', 'Fyzická osoba');

-- 6. Data pro tabulku Zviratko
INSERT INTO Zviratko (id_zviratko, id_druh, id_klec, id_nalezce, prezdivka, datum_prijmu) VALUES
(1, 1, 3, 1, 'Pepa', '2026-04-10'),
(2, 2, 2, 2, 'Očko', '2026-05-01'),
(3, 3, 7, 3, 'Goliáš', '2026-05-05'),
(4, 4, 4, 4, 'Ryšavka', '2026-05-15'),
(5, 5, 1, 1, 'Blesk', '2026-05-20'),
(6, 1, 3, 5, 'Žofka', '2026-05-22'),
(7, 7, 2, 6, 'Vilda', '2026-05-28'),
(8, 8, 5, 7, 'Netík', '2026-06-02');

-- 7. Data pro tabulku Denni_Zaznam (Identifikační závislost)
INSERT INTO Denni_Zaznam (id_zviratko, datum_zaznamu, id_osetrovatel, vaha_gramy, zdravotni_stav_popis) VALUES
(1, '2026-04-11', 2, 450, 'Podvyživený, nalezeny blechy, aplikován postřik.'),
(1, '2026-04-12', 2, 465, 'Stabilizovaný stav, přijímá potravu.'),
(2, '2026-05-02', 1, 190, 'Zlomenina levého křídla, fixováno dlahou.'),
(2, '2026-05-10', 7, 205, 'Křídlo se hojí dobře, klidový režim.'),
(3, '2026-05-06', 3, 9200, 'Otravné symptomy po požití olova, nasazena detoxikační kúra.'),
(4, '2026-05-16', 2, 280, 'Otřes mozku po pádu ze stromu, pozorování v temnu.'),
(6, '2026-05-23', 8, 310, 'Nezraněné mládě, vyžaduje dokrmování mlékem.'),
(7, '2026-05-29', 1, 850, 'Poranění od kočky na zádech, rána vyčištěna a sešita.');

-- 8. Data pro tabulku Financni_Dar
INSERT INTO Financni_Dar (id_dar, id_sponzor, id_zviratko, castka_kc, datum_platby) VALUES
(1, 1, 1, 1500.00, '2026-04-15'),
(2, 2, 2, 3000.00, '2026-05-05'),
(3, 3, NULL, 10000.00, '2026-05-10'), -- Obecný dar stanici
(4, 4, 3, 2500.00, '2026-05-12'),
(5, 5, 4, 5000.00, '2026-05-18'),
(6, 1, 1, 1200.00, '2026-05-20'), -- Druhý dar od stejné firmy na stejné zvíře
(7, 6, 6, 800.00, '2026-05-25'),
(8, 7, NULL, 15000.00, '2026-06-01');
