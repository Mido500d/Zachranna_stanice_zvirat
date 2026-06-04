-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Počítač: localhost
-- Vytvořeno: Čtv 04. čen 2026, 06:31
-- Verze serveru: 5.7.11
-- Verze PHP: 5.6.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `záchranná stanice`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `denni_zaznam`
--

CREATE TABLE `denni_zaznam` (
  `id_zviratko` int(11) NOT NULL,
  `datum_zaznamu` date NOT NULL,
  `id_osetrovatel` int(11) NOT NULL,
  `vaha_gramy` int(11) NOT NULL,
  `zdravotni_stav_popis` text COLLATE utf8mb4_czech_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `druh_zvirete`
--

CREATE TABLE `druh_zvirete` (
  `id_druh` int(11) NOT NULL,
  `nazev_druhu` varchar(100) COLLATE utf8mb4_czech_ci NOT NULL,
  `latinsky_nazev` varchar(100) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `stupen_ohrozeni` varchar(30) COLLATE utf8mb4_czech_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `financni_dar`
--

CREATE TABLE `financni_dar` (
  `id_dar` int(11) NOT NULL,
  `id_sponzor` int(11) NOT NULL,
  `id_zviratko` int(11) DEFAULT NULL,
  `castka_kc` decimal(10,2) NOT NULL,
  `datum_platby` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `klec_voliera`
--

CREATE TABLE `klec_voliera` (
  `id_klec` int(11) NOT NULL,
  `oznaceni` varchar(10) COLLATE utf8mb4_czech_ci NOT NULL,
  `typ_prostoru` varchar(50) COLLATE utf8mb4_czech_ci NOT NULL,
  `kapacita_zvirat` int(11) NOT NULL,
  `datum_posledni_dezinfekce` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `nalezce`
--

CREATE TABLE `nalezce` (
  `id_nalezce` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf8mb4_czech_ci NOT NULL,
  `prijmeni` varchar(50) COLLATE utf8mb4_czech_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_czech_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `osetrovatel`
--

CREATE TABLE `osetrovatel` (
  `id_osetrovatel` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf8mb4_czech_ci NOT NULL,
  `prijmeni` varchar(50) COLLATE utf8mb4_czech_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `specializace` varchar(100) COLLATE utf8mb4_czech_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `sponzor`
--

CREATE TABLE `sponzor` (
  `id_sponzor` int(11) NOT NULL,
  `nazev_sponzora` varchar(100) COLLATE utf8mb4_czech_ci NOT NULL,
  `kontaktni_osoba` varchar(100) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `typ_sponzora` varchar(20) COLLATE utf8mb4_czech_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `zviratko`
--

CREATE TABLE `zviratko` (
  `id_zviratko` int(11) NOT NULL,
  `id_druh` int(11) NOT NULL,
  `id_klec` int(11) DEFAULT NULL,
  `id_nalezce` int(11) DEFAULT NULL,
  `prezdivka` varchar(50) COLLATE utf8mb4_czech_ci DEFAULT NULL,
  `datum_prijmu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `denni_zaznam`
--
ALTER TABLE `denni_zaznam`
  ADD PRIMARY KEY (`id_zviratko`,`datum_zaznamu`),
  ADD KEY `id_osetrovatel` (`id_osetrovatel`);

--
-- Klíče pro tabulku `druh_zvirete`
--
ALTER TABLE `druh_zvirete`
  ADD PRIMARY KEY (`id_druh`);

--
-- Klíče pro tabulku `financni_dar`
--
ALTER TABLE `financni_dar`
  ADD PRIMARY KEY (`id_dar`),
  ADD KEY `id_sponzor` (`id_sponzor`),
  ADD KEY `id_zviratko` (`id_zviratko`);

--
-- Klíče pro tabulku `klec_voliera`
--
ALTER TABLE `klec_voliera`
  ADD PRIMARY KEY (`id_klec`);

--
-- Klíče pro tabulku `nalezce`
--
ALTER TABLE `nalezce`
  ADD PRIMARY KEY (`id_nalezce`);

--
-- Klíče pro tabulku `osetrovatel`
--
ALTER TABLE `osetrovatel`
  ADD PRIMARY KEY (`id_osetrovatel`);

--
-- Klíče pro tabulku `sponzor`
--
ALTER TABLE `sponzor`
  ADD PRIMARY KEY (`id_sponzor`);

--
-- Klíče pro tabulku `zviratko`
--
ALTER TABLE `zviratko`
  ADD PRIMARY KEY (`id_zviratko`),
  ADD KEY `id_druh` (`id_druh`),
  ADD KEY `id_klec` (`id_klec`),
  ADD KEY `id_nalezce` (`id_nalezce`);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `denni_zaznam`
--
ALTER TABLE `denni_zaznam`
  ADD CONSTRAINT `denni_zaznam_ibfk_1` FOREIGN KEY (`id_zviratko`) REFERENCES `zviratko` (`id_zviratko`) ON DELETE CASCADE,
  ADD CONSTRAINT `denni_zaznam_ibfk_2` FOREIGN KEY (`id_osetrovatel`) REFERENCES `osetrovatel` (`id_osetrovatel`);

--
-- Omezení pro tabulku `financni_dar`
--
ALTER TABLE `financni_dar`
  ADD CONSTRAINT `financni_dar_ibfk_1` FOREIGN KEY (`id_sponzor`) REFERENCES `sponzor` (`id_sponzor`),
  ADD CONSTRAINT `financni_dar_ibfk_2` FOREIGN KEY (`id_zviratko`) REFERENCES `zviratko` (`id_zviratko`) ON DELETE SET NULL;

--
-- Omezení pro tabulku `zviratko`
--
ALTER TABLE `zviratko`
  ADD CONSTRAINT `zviratko_ibfk_1` FOREIGN KEY (`id_druh`) REFERENCES `druh_zvirete` (`id_druh`),
  ADD CONSTRAINT `zviratko_ibfk_2` FOREIGN KEY (`id_klec`) REFERENCES `klec_voliera` (`id_klec`),
  ADD CONSTRAINT `zviratko_ibfk_3` FOREIGN KEY (`id_nalezce`) REFERENCES `nalezce` (`id_nalezce`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
