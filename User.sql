-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 11, 2023 at 09:27 PM
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
  `UserID` int NOT NULL,
  `Usertype` varchar(50) NOT NULL DEFAULT 'General',
  `Name` varchar(50) NOT NULL,
  `InstitutionalEmail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UniversityRegistrationID` int NOT NULL,
  `Password` varchar(50) NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `bKashNumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`UserID`, `Usertype`, `Name`, `InstitutionalEmail`, `UniversityRegistrationID`, `Password`, `PhoneNumber`, `bKashNumber`) VALUES
(1, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '01711813256', '01987959788', '01987959788'),
(2, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '1234567890', '+8801618551063', '01973761923'),
(3, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '12345678920', '01973761923', '01987959788'),
(4, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '12345678920', '01973761923', '01987959788'),
(5, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '1234567890', '01973761923', '01987959788'),
(6, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '123456789', '01973761923', '01987959788'),
(7, 'General', 'Sifat Sikder', 'bsse1221@iit.du.ac.bd', 2019316864, '123456789', '01973761923', '01987959788');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
