-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tissea
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tissea` ;

-- -----------------------------------------------------
-- Schema tissea
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tissea` DEFAULT CHARACTER SET utf8 ;
USE `tissea` ;

-- -----------------------------------------------------
-- Table `tissea`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tissea`.`categories` ;

CREATE TABLE IF NOT EXISTS `tissea`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tissea`.`lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tissea`.`lines` ;

CREATE TABLE IF NOT EXISTS `tissea`.`lines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `start_city_name` VARCHAR(45) NOT NULL,
  `end_city_name` VARCHAR(45) NOT NULL,
  `start_activitie_time_minutes` INT NOT NULL,
  `end_activitie_time_minutes` INT NOT NULL,
  `is_available_during_weekend` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categories_id`),
  INDEX `fk_lines_categories1_idx` (`categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_lines_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `tissea`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tissea`.`stops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tissea`.`stops` ;

CREATE TABLE IF NOT EXISTS `tissea`.`stops` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `latitude` DECIMAL(10,4) NOT NULL,
  `longitude` DECIMAL(10,4) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tissea`.`lines_has_stops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tissea`.`lines_has_stops` ;

CREATE TABLE IF NOT EXISTS `tissea`.`lines_has_stops` (
  `lines_id` INT NOT NULL,
  `stops_id` INT NOT NULL,
  `stop_time_minutes` INT NOT NULL,
  `stop_order` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lines_id`, `stops_id`),
  INDEX `fk_lines_has_stops_stops1_idx` (`stops_id` ASC) VISIBLE,
  INDEX `fk_lines_has_stops_lines_idx` (`lines_id` ASC) VISIBLE,
  CONSTRAINT `fk_lines_has_stops_lines`
    FOREIGN KEY (`lines_id`)
    REFERENCES `tissea`.`lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lines_has_stops_stops1`
    FOREIGN KEY (`stops_id`)
    REFERENCES `tissea`.`stops` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tissea`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tissea`.`users` ;

CREATE TABLE IF NOT EXISTS `tissea`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
