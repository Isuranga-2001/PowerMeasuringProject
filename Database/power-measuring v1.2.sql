-- MySQL Script generated by MySQL Workbench
-- Sat Nov 11 20:00:50 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema power_project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `power_project` ;

-- -----------------------------------------------------
-- Schema power_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `power_project` DEFAULT CHARACTER SET utf8 ;
USE `power_project` ;

-- -----------------------------------------------------
-- Table `power_project`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_project`.`user` ;

CREATE TABLE IF NOT EXISTS `power_project`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(30) NOT NULL,
  `hospital_name` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `power_project`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_project`.`location` ;

CREATE TABLE IF NOT EXISTS `power_project`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `location_name` VARCHAR(45) NULL,
  PRIMARY KEY (`location_id`),
  INDEX `user-pk_idx` (`user_id` ASC),
  CONSTRAINT `user-fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `power_project`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `power_project`.`device_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_project`.`device_type` ;

CREATE TABLE IF NOT EXISTS `power_project`.`device_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`type_id`),
  INDEX `use-fk_idx` (`user` ASC),
  CONSTRAINT `use-fk`
    FOREIGN KEY (`user`)
    REFERENCES `power_project`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `power_project`.`device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_project`.`device` ;

CREATE TABLE IF NOT EXISTS `power_project`.`device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `device_name` VARCHAR(45) NULL,
  `device_type` INT NULL,
  `device_location` INT NULL,
  `device_threshold` VARCHAR(45) NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `location-fk_idx` (`device_location` ASC),
  INDEX `device-fk_idx` (`device_type` ASC),
  INDEX `user-fk_idx` (`user` ASC),
  CONSTRAINT `location-fk`
    FOREIGN KEY (`device_location`)
    REFERENCES `power_project`.`location` (`location_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `device-fk`
    FOREIGN KEY (`device_type`)
    REFERENCES `power_project`.`device_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id-fk`
    FOREIGN KEY (`user`)
    REFERENCES `power_project`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `power_project`.`records`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_project`.`records` ;

CREATE TABLE IF NOT EXISTS `power_project`.`records` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `device_id` INT NULL,
  `record_timestamp` DATETIME NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`record_id`),
  INDEX `records-pk_idx` (`device_id` ASC),
  CONSTRAINT `records-pk`
    FOREIGN KEY (`device_id`)
    REFERENCES `power_project`.`device` (`device_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
