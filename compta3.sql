-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 21 juil. 2020 à 09:54
-- Version du serveur :  10.4.13-MariaDB
-- Version de PHP : 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `compta`
--
CREATE DATABASE IF NOT EXISTS `compta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `compta`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `ID` int(10) NOT NULL,
  `REF` varchar(13) NOT NULL,
  `DESIGNATION` varchar(255) NOT NULL,
  `PRIX` decimal(7,0) NOT NULL,
  `id_fourn` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_art_fou` (`id_fourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`ID`, `REF`, `DESIGNATION`, `PRIX`, `id_fourn`) VALUES
(1, 'A01', 'Perceuse P1', '75', 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', '2', 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', '4', 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', '4', 3),
(5, 'A02', 'Meuleuse 125mm', '38', 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', '2', 3),
(7, 'A03', 'Perceuse à colonne', '185', 1),
(8, 'D04', 'Coffret mêches à bois', '12', 3),
(9, 'F03', 'Coffret mêches plates', '6', 2),
(10, 'F04', 'Fraises d’encastrement', '8', 2);

-- --------------------------------------------------------

--
-- Structure de la table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE IF NOT EXISTS `bon` (
  `ID` int(10) NOT NULL,
  `NUMERO` int(10) NOT NULL,
  `DATE_CMDE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `DELAI` int(10) NOT NULL,
  `id_fourn` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_fou_bon` (`id_fourn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `bon`
--

INSERT INTO `bon` (`ID`, `NUMERO`, `DATE_CMDE`, `DELAI`, `id_fourn`) VALUES
(1, 21072020, '2020-07-21 07:46:41', 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE IF NOT EXISTS `compo` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `QTE` int(10) NOT NULL,
  `id_art` int(10) NOT NULL,
  `id_bon` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_art_compo` (`id_art`),
  KEY `FK_bon_compo` (`id_bon`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `compo`
--

INSERT INTO `compo` (`ID`, `QTE`, `id_art`, `id_bon`) VALUES
(1, 3, 1, 1),
(2, 4, 5, 1),
(3, 1, 7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `ID` int(10) NOT NULL,
  `NOM` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`ID`, `NOM`) VALUES
(1, 'Française d\'Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `FK_art_fou` FOREIGN KEY (`id_fourn`) REFERENCES `fournisseur` (`ID`);

--
-- Contraintes pour la table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `FK_fou_bon` FOREIGN KEY (`id_fourn`) REFERENCES `fournisseur` (`ID`);

--
-- Contraintes pour la table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `FK_art_compo` FOREIGN KEY (`id_art`) REFERENCES `article` (`ID`),
  ADD CONSTRAINT `FK_bon_compo` FOREIGN KEY (`id_bon`) REFERENCES `bon` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
