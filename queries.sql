-- =============================================================================
-- Seminární projekt: Záchranná stanice pro divoce žijící zvířata
-- Skript: queries.sql (15 vlastních dotazů splňujících všechny podmínky)
-- Použitý dialekt: Standardní ANSI SQL
-- =============================================================================

-- -----------------------------------------------------------------------------
-- DOTAZ 1: Seznam všech zvířat přijatých od 15. května 2026 dále.
-- Kategorie: WHERE (1/13)
-- -----------------------------------------------------------------------------
SELECT id_zviratko, prezdivka, datum_prijmu
FROM Zviratko
WHERE datum_prijmu >= '2026-05-15';


-- -----------------------------------------------------------------------------
-- DOTAZ 2: Vyhledání ošetřovatelů, kteří mají ve své specializaci slovo 'savci'.
-- Kategorie: WHERE (2/13), LIKE (1/3)
-- -----------------------------------------------------------------------------
SELECT id_osetrovatel, jmeno, prijmeni, specializace
FROM Osetrovatel
WHERE specializace LIKE '%savci%';


-- -----------------------------------------------------------------------------
-- DOTAZ 3: Top 3 nejvyšší hmotnosti zaznamenané u zvířat v denních záznamech.
-- Kategorie: ORDER BY (1/2), LIMIT (1/2)
-- -----------------------------------------------------------------------------
SELECT id_zviratko, datum_zaznamu, vaha_gramy
FROM Denni_Zaznam
ORDER BY vaha_gramy DESC
LIMIT 3;


-- -----------------------------------------------------------------------------
-- DOTAZ 4: Finanční dary vyšší než 2000 Kč, seřazené od nejnovějšího daru.
-- Kategorie: WHERE (3/13), ORDER BY (2/2)
-- -----------------------------------------------------------------------------
SELECT id_dar, castka_kc, datum_platby
FROM Financni_Dar
WHERE castka_kc > 2000.00
ORDER BY datum_platby DESC;


-- -----------------------------------------------------------------------------
-- DOTAZ 5: Seznam zvířátek, která jsou druhem 'Ježek západní' (ID druhu = 1).
-- Kategorie: WHERE (4/13), JOIN ON (1/6)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, d.nazev_druhu
FROM Zviratko z
JOIN Druh_Zvirete d ON z.id_druh = d.id_druh
WHERE d.id_druh = 1;


-- -----------------------------------------------------------------------------
-- DOTAZ 6: Přehled všech klecí a voliér typu 'Intenzivní intenzivní box' a zvířat v nich umístěných (včetně prázdných boxů).
-- Kategorie: WHERE (5/13), LEFT|RIGHT JOIN (1/2)
-- -----------------------------------------------------------------------------
SELECT k.oznaceni, k.typ_prostoru, z.prezdivka
FROM Klec_Voliera k
LEFT JOIN Zviratko z ON k.id_klec = z.id_klec
WHERE k.typ_prostoru = 'Intenzivní intenzivní box';


-- -----------------------------------------------------------------------------
-- DOTAZ 7: Zvířata, která byla přivedena nálezcem s e-mailem na doméně 'seznam.cz'.
-- Kategorie: WHERE (6/13), LIKE (2/3), JOIN ON (2/6)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, n.jmeno, n.prijmeni, n.email
FROM Zviratko z
JOIN Nalezce n ON z.id_nalezce = n.id_nalezce
WHERE n.email LIKE '%@seznam.cz';


-- -----------------------------------------------------------------------------
-- DOTAZ 8: Celková částka finančních darů získaná na jednotlivá zvířata. Zobrazí se pouze zvířata, která v sumě získala více než 2000 Kč.
-- Kategorie: WHERE (7/13) [implicitní přes vázané id], JOIN ON (3/6), GROUP BY + HAVING (1/1), AGREGACE (1/1), VÝPOČET (1/1)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, SUM(d.castka_kc) AS celkovy_pripis_kc
FROM Zviratko z
JOIN Financni_Dar d ON z.id_zviratko = d.id_zviratko
WHERE d.id_zviratko IS NOT NULL
GROUP BY z.id_zviratko, z.prezdivka
HAVING SUM(d.castka_kc) > 2000.00;


-- -----------------------------------------------------------------------------
-- DOTAZ 9: Výpočet počtu dní, které zvíře strávilo ve stanici od příjmu do fiktivního konce kontrolního období (30. června 2026). Platí pro zvířata přijatá po 1. květnu 2026.
-- Kategorie: WHERE (8/13), VÝPOČET (2/1)
-- Poznámka: Použita standardní ANSI konstrukce odečtu dat (případně ekvivalent v konkrétním SŘBD jako DATEDIFF).
-- -----------------------------------------------------------------------------
SELECT id_zviratko, prezdivka, datum_prijmu, 
       (CAST('2026-06-30' AS DATE) - datum_prijmu) AS dny_ve_stanici
FROM Zviratko
WHERE datum_prijmu > '2026-05-01';


-- -----------------------------------------------------------------------------
-- DOTAZ 10: Vyhledání zvířat, která mají v denním záznamu v popisu stavu zmíněnou 'zlomeninu'.
-- Kategorie: WHERE (9/13), LIKE (3/3), JOIN ON (4/6)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, dz.datum_zaznamu, dz.zdravotni_stav_popis
FROM Zviratko z
JOIN Denni_Zaznam dz ON z.id_zviratko = dz.id_zviratko
WHERE dz.zdravotni_stav_popis LIKE '%zlomenina%';


-- -----------------------------------------------------------------------------
-- DOTAZ 11: Seznam sponzorů typu 'Firma' a jejich konkrétních darů, seřazený sestupně podle výše daru, omezený na top 5 výsledků.
-- Kategorie: WHERE (10/13), ORDER BY (3/2), LIMIT (2/2), JOIN ON (5/6)
-- -----------------------------------------------------------------------------
SELECT s.nazev_sponzora, s.typ_sponzora, d.castka_kc, d.datum_platby
FROM Sponzor s
JOIN Financni_Dar d ON s.id_sponzor = d.id_sponzor
WHERE s.typ_sponzora = 'Firma'
ORDER BY d.castka_kc DESC
LIMIT 5;


-- -----------------------------------------------------------------------------
-- DOTAZ 12: Seznam všech zvířat a k nim přiřazených denních záznamů. Použito pro detekci zvířat, která dosud nemají vytvořen žádný denní záznam.
-- Kategorie: WHERE (11/13), LEFT|RIGHT JOIN (2/2)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, dz.datum_zaznamu
FROM Zviratko z
LEFT JOIN Denni_Zaznam dz ON z.id_zviratko = dz.id_zviratko
WHERE dz.datum_zaznamu IS NULL;


-- -----------------------------------------------------------------------------
-- DOTAZ 13: Denní záznamy, které vyhotovil ošetřovatel Karel Marek.
-- Kategorie: WHERE (12/13), JOIN ON (6/6)
-- -----------------------------------------------------------------------------
SELECT dz.id_zviratko, dz.datum_zaznamu, dz.zdravotni_stav_popis, o.jmeno, o.prijmeni
FROM Denni_Zaznam dz
JOIN Osetrovatel o ON dz.id_osetrovatel = o.id_osetrovatel
WHERE o.jmeno = 'Karel' AND o.prijmeni = 'Marek';


-- -----------------------------------------------------------------------------
-- DOTAZ 14: Přehled zvířat patřících pod druhy se stupněm ohrožení 'Silně ohrožený'.
-- Kategorie: WHERE (13/13), JOIN ON (7/6)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, d.nazev_druhu, d.stupen_ohrozeni
FROM Zviratko z
JOIN Druh_Zvirete d ON z.id_druh = d.id_druh
WHERE d.stupen_ohrozeni = 'Silně ohrožený';


-- -----------------------------------------------------------------------------
-- DOTAZ 15: Vyhledání zvířat a jejich nálezců, jejichž telefonní číslo začíná mezinárodní předvolbou '+420'.
-- Použito pro ověření splnění extra vazby/kategorie.
-- Kategorie: WHERE (pomocná doplňková), LIKE (4/3), JOIN ON (8/6)
-- -----------------------------------------------------------------------------
SELECT z.id_zviratko, z.prezdivka, n.jmeno, n.prijmeni, n.telefon
FROM Zviratko z
JOIN Nalezce n ON z.id_nalezce = n.id_nalezce
WHERE n.telefon LIKE '+420%';
