-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2021 at 05:29 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medilog`
--

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `id` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` varchar(255) NOT NULL,
  `file` varchar(255) NOT NULL,
  `date_created` date NOT NULL,
  `date_updated` date NOT NULL,
  `user_id` int(10) NOT NULL,
  `flag` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`id`, `title`, `body`, `file`, `date_created`, `date_updated`, `user_id`, `flag`) VALUES
(82, 'Pradeep Patil', '2', 'file-1618862333478.jpg', '2021-04-19', '2021-04-19', 60, 0),
(83, 'Pradeep Patil', '2', 'file-1618862459425.jpg', '2021-04-19', '2021-04-19', 60, 0),
(84, 'Pradeep Patil', '3', 'file-1618862466965.JPG', '2021-04-19', '2021-04-19', 60, 0),
(85, 'Pradeep Patil', '4', 'file-1618862473684.png', '2021-04-19', '2021-04-19', 60, 0),
(86, 'Pradeep Patil', '5', 'file-1618862483561.png', '2021-04-19', '2021-04-19', 60, 0),
(87, 'Pradeep Patil', '6', 'file-1618862493401.jpg', '2021-04-19', '2021-04-19', 60, 0),
(88, 'Pradeep Patil', '7', 'file-1618862502390.jpg', '2021-04-19', '2021-04-19', 60, 0),
(89, 'Pradeep Patil', '8', 'file-1618862510050.JPG', '2021-04-19', '2021-04-19', 60, 0),
(90, 'Pradeep Patil', '9', 'file-1618862516225.png', '2021-04-19', '2021-04-19', 60, 0),
(91, 'Pradeep Patil', '10', 'file-1618862523288.jpg', '2021-04-19', '2021-04-19', 60, 0),
(92, 'Pradeep Patil', '11', 'file-1618862530303.png', '2021-04-19', '2021-04-19', 60, 0),
(94, 'Pradeep Patil', '2', 'file-1618868035034.jpg', '2021-04-19', '2021-04-19', 61, 0);

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

CREATE TABLE `shares` (
  `id` int(100) NOT NULL,
  `r_table` int(1) NOT NULL,
  `r_id` int(100) NOT NULL,
  `r_key` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shares`
--

INSERT INTO `shares` (`id`, `r_table`, `r_id`, `r_key`) VALUES
(36, 1, 28, 282),
(37, 1, 28, 561),
(38, 0, 82, 249),
(40, 0, 82, 971);

-- --------------------------------------------------------

--
-- Table structure for table `test_reports`
--

CREATE TABLE `test_reports` (
  `id` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` varchar(255) NOT NULL,
  `file` varchar(255) NOT NULL,
  `date_created` date NOT NULL,
  `date_updated` date NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_reports`
--

INSERT INTO `test_reports` (`id`, `title`, `body`, `file`, `date_created`, `date_updated`, `user_id`) VALUES
(28, 'Pradeep Patil', '2', 'file-1618862341706.jpg', '2021-04-19', '2021-04-19', 60);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `flag` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `flag`) VALUES
(1, 'admin@medilog.com', '1234', 1),
(60, 'papatil@ncsu.edu', '91849109092.14954', 1),
(61, 'pmap101@gmail.com', '14724703429.82617', 1),
(63, 'papatil@my.waketech.edu', '1234', 1),
(64, 'arunpatil18@gmail.com', '1234', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_reports`
--
ALTER TABLE `test_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `shares`
--
ALTER TABLE `shares`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `test_reports`
--
ALTER TABLE `test_reports`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
