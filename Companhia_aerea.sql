-- MySQL Script generated by MySQL Workbench
-- Tue Oct 13 04:05:16 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`AEROPORTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AEROPORTO` (
  `Codigo_aeroporto` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`Codigo_aeroporto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VOO` (
  `Numero_voo` INT NOT NULL,
  `Companhia_aerea` VARCHAR(45) NULL,
  `Dias da Semana` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero_voo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRECHO_VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRECHO_VOO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Codigo_aeroporto_partida` INT NULL,
  `Horario_partida_previsto` INT NULL,
  `Codigo_aeroporto_chegada` INT NULL,
  `Horario_chegada_previsto` INT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_AERONAVE` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Qtd_max_assentos` INT NULL,
  `Companhia` VARCHAR(45) NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AERONAVE` (
  `Codigo_aeronave` INT NOT NULL,
  `Numero_total_assentos` INT NULL,
  `Tipo_aeronave` VARCHAR(45) NULL,
  PRIMARY KEY (`Codigo_aeronave`),
  INDEX `Tipo_aeronave_idx` (`Tipo_aeronave` ASC) VISIBLE,
  CONSTRAINT `Tipo_aeronave`
    FOREIGN KEY (`Tipo_aeronave`)
    REFERENCES `mydb`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INSTANCIA_TRECHO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INSTANCIA_TRECHO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Numero_assentos_disponiveis` INT NULL,
  `Codigo_aeronave` INT NULL,
  `Codigo_aeroporto_partida` INT NULL,
  `Horario_partida` INT NULL,
  `Codigo_aeroporto_chegada` INT NULL,
  `Horario_chegada` INT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`),
  INDEX `Numero_trecho_idx` (`Numero_trecho` ASC) VISIBLE,
  INDEX `Codigo_aeronave_idx` (`Codigo_aeronave` ASC) VISIBLE,
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Numero_trecho`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `mydb`.`TRECHO_VOO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeronave`
    FOREIGN KEY (`Codigo_aeronave`)
    REFERENCES `mydb`.`AERONAVE` (`Codigo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TARIFA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TARIFA` (
  `Numero_voo` INT NOT NULL,
  `Codigo_tarifa` INT NOT NULL,
  `Quantidade` INT NULL,
  `Restricoes` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero_voo`, `Codigo_tarifa`),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `mydb`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RESERVA_ASSENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESERVA_ASSENTO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Numero_assento` INT NOT NULL,
  `Nome_cliente` VARCHAR(45) NULL,
  `Telefone_cliente` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`, `Numero_assento`),
  INDEX `Numero_trecho_idx` (`Numero_trecho` ASC) VISIBLE,
  CONSTRAINT `Numero_trecho`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `mydb`.`TRECHO_VOO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PODE_POUSAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PODE_POUSAR` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Codigo_aeroporto` INT NOT NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`, `Codigo_aeroporto`),
  INDEX `Codigo_aeroporto_idx` (`Codigo_aeroporto` ASC) VISIBLE,
  CONSTRAINT `Codigo_aeroporto`
    FOREIGN KEY (`Codigo_aeroporto`)
    REFERENCES `mydb`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Nome_tipo_aeronave`
    FOREIGN KEY (`Nome_tipo_aeronave`)
    REFERENCES `mydb`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;