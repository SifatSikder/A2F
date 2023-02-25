-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 25, 2023 at 02:13 PM
-- Server version: 8.0.32-0ubuntu0.20.04.2
-- PHP Version: 7.4.3-4ubuntu2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `A2F`
--

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `Usertype` varchar(50) NOT NULL DEFAULT 'General',
  `Name` varchar(50) NOT NULL,
  `InstitutionalEmail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UniversityRegistrationID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `bKashNumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`Usertype`, `Name`, `InstitutionalEmail`, `UniversityRegistrationID`, `Password`, `PhoneNumber`, `bKashNumber`) VALUES
('Agent', 'Tasnia Esha', 'bsse1205@iit.du.ac.bd', '2019316865', '$2b$15$IAnX8PVojFiPELt5LTgCcebvn5d2J1q6yQUdyrsPyPkjGK9sjiYqO', '01303034075', '01973761923'),
('General', 'Tasnim samad', 'bsse1208@iit.du.ac.bd', '2019316866', '$2b$15$c8QW8PAMgvlrqNcDUlpnUOm7JDnFZiVM20wUENgBd6xiyegsyEG8K', '01630226371', '01630226371'),
('Committee Member', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', '2019316864', '$2b$15$hnRnTko6Zb.Lci7NSDzhKupN5.a7er55WKdzcDO.youLszT84MZVy', '01987959788', '01987959788'),
('Admin', 'Sakib Sir', 'sakib@iit.du.ac.bd', '', '$2b$15$x4jvPgx3oI19otYFQA/Pd.h7NyxYk59xgbg48SDQjV2EndPiUxF/S', '+8801730051232', '01730051232');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`InstitutionalEmail`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
