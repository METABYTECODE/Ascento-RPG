-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 19, 2023 at 10:45 AM
-- Server version: 8.0.24
-- PHP Version: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dota2`
--

-- --------------------------------------------------------

--
-- Table structure for table `ascento_discord_chat`
--

CREATE TABLE `ascento_discord_chat` (
  `id` int NOT NULL,
  `user` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `from` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'discord',
  `match_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `date_add` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ascento_rpg_inventory`
--

CREATE TABLE `ascento_rpg_inventory` (
  `id` int NOT NULL,
  `steamid` varchar(100) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `dota_name` varchar(500) DEFAULT NULL,
  `type` varchar(500) DEFAULT NULL,
  `count` int NOT NULL DEFAULT '1',
  `Info` varchar(500) DEFAULT NULL,
  `date_add` date DEFAULT NULL,
  `date_end` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ascento_rpg_online_table`
--

CREATE TABLE `ascento_rpg_online_table` (
  `id` int NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `date_time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ascento_rpg_players`
--

CREATE TABLE `ascento_rpg_players` (
  `id` int NOT NULL,
  `steamid` varchar(100) NOT NULL DEFAULT '',
  `coins` int NOT NULL DEFAULT '0',
  `gametime` varchar(1000) NOT NULL DEFAULT '0',
  `telegram` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `steam_id_full` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `steam_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `easy_win` int NOT NULL DEFAULT '0',
  `normal_win` int NOT NULL DEFAULT '0',
  `hard_win` int NOT NULL DEFAULT '0',
  `unfair_win` int NOT NULL DEFAULT '0',
  `impossible_win` int NOT NULL DEFAULT '0',
  `hell_win` int NOT NULL DEFAULT '0',
  `hardcore_win` int NOT NULL DEFAULT '0',
  `ny_win` int NOT NULL DEFAULT '0',
  `hard_event_win` int NOT NULL DEFAULT '0',
  `ny_open` int NOT NULL DEFAULT '0',
  `reincarnation` int NOT NULL DEFAULT '0',
  `creep_kills` int NOT NULL DEFAULT '0',
  `boss_kills` int NOT NULL DEFAULT '0',
  `deaths` int NOT NULL DEFAULT '0',
  `endless_1` int NOT NULL DEFAULT '0',
  `endless_2` int NOT NULL DEFAULT '0',
  `endless_3` int NOT NULL DEFAULT '0',
  `endless_4` int NOT NULL DEFAULT '0',
  `endless_5` int NOT NULL DEFAULT '0',
  `endless_6` int NOT NULL DEFAULT '0',
  `endless_7` int NOT NULL DEFAULT '0',
  `endless_8` int NOT NULL DEFAULT '0',
  `endless_9` int NOT NULL DEFAULT '0',
  `endless_10` int NOT NULL DEFAULT '0',
  `endless_11` int NOT NULL DEFAULT '0',
  `endless_12` int NOT NULL DEFAULT '0',
  `endless_13` int NOT NULL DEFAULT '0',
  `endless_14` int NOT NULL DEFAULT '0',
  `endless_15` int NOT NULL DEFAULT '0',
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ascento_rpg_save`
--

CREATE TABLE `ascento_rpg_save` (
  `id` int NOT NULL,
  `steamid` int NOT NULL,
  `difficulty` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `hero_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `slot_0` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_4` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_6` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_7` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_8` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `slot_neutral` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `hero_lvl` int NOT NULL DEFAULT '1',
  `checkpoint` int NOT NULL DEFAULT '1',
  `creep_kills` int NOT NULL DEFAULT '0',
  `boss_kills` int NOT NULL DEFAULT '0',
  `deaths` int NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `match_id` varchar(100) NOT NULL DEFAULT '0',
  `gametime` varchar(100) NOT NULL DEFAULT '0',
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `online_players_ascento_rpg`
--

CREATE TABLE `online_players_ascento_rpg` (
  `id` int NOT NULL,
  `steamid` varchar(100) NOT NULL,
  `steam_id_full` varchar(100) NOT NULL DEFAULT '',
  `difficulty` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `match_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `date_online` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ascento_discord_chat`
--
ALTER TABLE `ascento_discord_chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ascento_rpg_inventory`
--
ALTER TABLE `ascento_rpg_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ascento_rpg_online_table`
--
ALTER TABLE `ascento_rpg_online_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_time` (`date_time`);

--
-- Indexes for table `ascento_rpg_players`
--
ALTER TABLE `ascento_rpg_players`
  ADD PRIMARY KEY (`id`),
  ADD KEY `steam_id_full` (`steam_id_full`),
  ADD KEY `steamid` (`steamid`);

--
-- Indexes for table `ascento_rpg_save`
--
ALTER TABLE `ascento_rpg_save`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hero_name` (`hero_name`),
  ADD KEY `difficulty` (`difficulty`),
  ADD KEY `steamid` (`steamid`);

--
-- Indexes for table `online_players_ascento_rpg`
--
ALTER TABLE `online_players_ascento_rpg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `steamid` (`steamid`),
  ADD KEY `difficulty` (`difficulty`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ascento_discord_chat`
--
ALTER TABLE `ascento_discord_chat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ascento_rpg_inventory`
--
ALTER TABLE `ascento_rpg_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ascento_rpg_online_table`
--
ALTER TABLE `ascento_rpg_online_table`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ascento_rpg_players`
--
ALTER TABLE `ascento_rpg_players`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ascento_rpg_save`
--
ALTER TABLE `ascento_rpg_save`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_players_ascento_rpg`
--
ALTER TABLE `online_players_ascento_rpg`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
