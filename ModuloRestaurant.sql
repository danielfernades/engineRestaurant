SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Restaurant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Restaurant` (
  `RFC` VARCHAR(50) NOT NULL ,
  `Nombre` VARCHAR(150) NULL ,
  `Titular` VARCHAR(150) NULL ,
  `Domicilio` VARCHAR(45) NULL ,
  `Telefono` VARCHAR(45) NULL ,
  `Municipio` VARCHAR(45) NULL ,
  `Estado` VARCHAR(45) NULL ,
  PRIMARY KEY (`RFC`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registro_caja`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Registro_caja` (
  `idRegistro_caja` INT NOT NULL ,
  `montoInicial` DECIMAL NULL ,
  `montoFinal` DECIMAL NULL ,
  `Restaurant` VARCHAR(45) NULL ,
  PRIMARY KEY (`idRegistro_caja`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zonas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Zonas` (
  `idZonas` INT NOT NULL ,
  `Nombre` VARCHAR(150) NULL ,
  `Imagen` VARCHAR(250) NULL ,
  `Descripción` TEXT NULL ,
  `Restaurant` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idZonas`) ,
  CONSTRAINT `fk_Zonas_Restaurant`
    FOREIGN KEY (`Restaurant` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mesa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Mesa` (
  `idMesa` INT NOT NULL ,
  `Nombre` VARCHAR(45) NULL ,
  `Estado` INT(1) NULL ,
  `Zonas_idZonas` INT NOT NULL ,
  PRIMARY KEY (`idMesa`) ,
  CONSTRAINT `fk_Mesa_Zonas1`
    FOREIGN KEY (`Zonas_idZonas` )
    REFERENCES `mydb`.`Zonas` (`idZonas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Turno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Turno` (
  `idTurno` INT NOT NULL ,
  `Nombre` VARCHAR(45) NULL ,
  `horaInicial` TIME NULL ,
  `horaFinal` TIME NULL ,
  `Descanso` TIME NULL ,
  `Apertura` TIME NULL ,
  PRIMARY KEY (`idTurno`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Restaurant_Turno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Restaurant_Turno` (
  `Restaurant_RFC` VARCHAR(50) NOT NULL ,
  `Turno_idTurno` INT NOT NULL ,
  PRIMARY KEY (`Restaurant_RFC`, `Turno_idTurno`) ,
  CONSTRAINT `fk_Restaurant_has_Turno_Restaurant1`
    FOREIGN KEY (`Restaurant_RFC` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_has_Turno_Turno1`
    FOREIGN KEY (`Turno_idTurno` )
    REFERENCES `mydb`.`Turno` (`idTurno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mesero`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Mesero` (
  `idMesero` INT NOT NULL ,
  `Nombre` VARCHAR(200) NULL ,
  `Usuario` VARCHAR(45) NULL ,
  `Imagen` VARCHAR(45) NULL ,
  `Turno` INT NOT NULL ,
  PRIMARY KEY (`idMesero`) ,
  CONSTRAINT `fk_Mesero_Turno1`
    FOREIGN KEY (`Turno` )
    REFERENCES `mydb`.`Turno` (`idTurno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Menu` (
  `idMenu` INT NOT NULL ,
  `Nombre` VARCHAR(45) NULL ,
  `Fecha` TIMESTAMP NULL ,
  `Estado` BIT NULL ,
  `Menucol` VARCHAR(45) NULL ,
  `Restaurant_RFC` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idMenu`) ,
  CONSTRAINT `fk_Menu_Restaurant1`
    FOREIGN KEY (`Restaurant_RFC` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Restaurant_Mesero`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Restaurant_Mesero` (
  `Restaurant` VARCHAR(50) NOT NULL ,
  `Mesero` INT NOT NULL ,
  PRIMARY KEY (`Restaurant`, `Mesero`) ,
  CONSTRAINT `fk_Restaurant_has_Mesero_Restaurant1`
    FOREIGN KEY (`Restaurant` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_has_Mesero_Mesero1`
    FOREIGN KEY (`Mesero` )
    REFERENCES `mydb`.`Mesero` (`idMesero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categorias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Categorias` (
  `Nombre` VARCHAR(150) NOT NULL ,
  `Fecha` TIMESTAMP NULL ,
  `Descripcion` TEXT NULL ,
  PRIMARY KEY (`Nombre`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu_Categorias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Menu_Categorias` (
  `IdMenu` INT NOT NULL ,
  `Categoria` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`IdMenu`, `Categoria`) ,
  CONSTRAINT `fk_Menu_has_Categorias_Menu1`
    FOREIGN KEY (`IdMenu` )
    REFERENCES `mydb`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_Categorias_Categorias1`
    FOREIGN KEY (`Categoria` )
    REFERENCES `mydb`.`Categorias` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Producto` (
  `Nombre` VARCHAR(150) NOT NULL ,
  `Fecha` TIMESTAMP NULL ,
  `Descripcion` TEXT NULL ,
  `Precio` DECIMAL NULL ,
  `Imagen` VARCHAR(45) NULL ,
  `Timepo` TIME NULL ,
  `Productocol` VARCHAR(45) NULL ,
  `Categoria` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`Nombre`) ,
  CONSTRAINT `fk_Producto_Categorias1`
    FOREIGN KEY (`Categoria` )
    REFERENCES `mydb`.`Categorias` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingredientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Ingredientes` (
  `idIngredientes` INT NOT NULL ,
  `Nombre` VARCHAR(150) NULL ,
  `Medida` VARCHAR(45) NULL ,
  `Imagen` VARCHAR(200) NULL ,
  `Descripcion` TEXT NULL ,
  PRIMARY KEY (`idIngredientes`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto_Ingredientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Producto_Ingredientes` (
  `Producto` VARCHAR(150) NOT NULL ,
  `Ingrediente` INT NOT NULL ,
  `Porcion` DECIMAL NULL ,
  PRIMARY KEY (`Producto`, `Ingrediente`) ,
  CONSTRAINT `fk_Producto_has_Ingredientes_Producto1`
    FOREIGN KEY (`Producto` )
    REFERENCES `mydb`.`Producto` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Ingredientes_Ingredientes1`
    FOREIGN KEY (`Ingrediente` )
    REFERENCES `mydb`.`Ingredientes` (`idIngredientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idClientes` INT NOT NULL ,
  `Nombre` VARCHAR(150) NOT NULL ,
  `Company` VARCHAR(150) NOT NULL ,
  `Tipo` VARCHAR(45) NOT NULL ,
  `RFC` VARCHAR(45) NULL ,
  `Fecha` TIMESTAMP NULL ,
  `Tel` VARCHAR(50) NULL ,
  PRIMARY KEY (`idClientes`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes_has_Restaurant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Clientes_has_Restaurant` (
  `Clientes_idClientes` INT NOT NULL ,
  `Restaurant_RFC` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`Clientes_idClientes`, `Restaurant_RFC`) ,
  CONSTRAINT `fk_Clientes_has_Restaurant_Clientes1`
    FOREIGN KEY (`Clientes_idClientes` )
    REFERENCES `mydb`.`Clientes` (`idClientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_Restaurant_Restaurant1`
    FOREIGN KEY (`Restaurant_RFC` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oferta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Oferta` (
  `idOferta` INT NULL ,
  `fechaInicio` DATE NULL ,
  `fechaFinal` DATE NULL ,
  `horaInicio` TIME NULL ,
  `horaFinal` TIME NULL ,
  `Imagen` VARCHAR(150) NULL ,
  `Descripcion` TEXT NULL ,
  `Descuento` DECIMAL NULL ,
  PRIMARY KEY (`idOferta`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oferta_has_Clientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Oferta_has_Clientes` (
  `Oferta` INT NOT NULL ,
  `Clientes` INT NOT NULL ,
  PRIMARY KEY (`Oferta`, `Clientes`) ,
  CONSTRAINT `fk_Oferta_has_Clientes_Oferta1`
    FOREIGN KEY (`Oferta` )
    REFERENCES `mydb`.`Oferta` (`idOferta` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oferta_has_Clientes_Clientes1`
    FOREIGN KEY (`Clientes` )
    REFERENCES `mydb`.`Clientes` (`idClientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto_Oferta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Producto_Oferta` (
  `Producto` VARCHAR(150) NOT NULL ,
  `Oferta` INT NOT NULL ,
  PRIMARY KEY (`Producto`, `Oferta`) ,
  CONSTRAINT `fk_Producto_has_Oferta_Producto1`
    FOREIGN KEY (`Producto` )
    REFERENCES `mydb`.`Producto` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Oferta_Oferta1`
    FOREIGN KEY (`Oferta` )
    REFERENCES `mydb`.`Oferta` (`idOferta` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Restaurant_Mesero_has_Restaurant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Restaurant_Mesero_has_Restaurant` (
  `Restaurant_Mesero_Restaurant` VARCHAR(50) NOT NULL ,
  `Restaurant_Mesero_Mesero` INT NOT NULL ,
  `Restaurant_RFC` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`Restaurant_Mesero_Restaurant`, `Restaurant_Mesero_Mesero`, `Restaurant_RFC`) ,
  CONSTRAINT `fk_Restaurant_Mesero_has_Restaurant_Restaurant_Mesero1`
    FOREIGN KEY (`Restaurant_Mesero_Restaurant` , `Restaurant_Mesero_Mesero` )
    REFERENCES `mydb`.`Restaurant_Mesero` (`Restaurant` , `Mesero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_Mesero_has_Restaurant_Restaurant1`
    FOREIGN KEY (`Restaurant_RFC` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu_Restaurant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Menu_Restaurant` (
  `Menu` INT NOT NULL ,
  `Restaurant` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`Menu`, `Restaurant`) ,
  CONSTRAINT `fk_Menu_has_Restaurant_Menu1`
    FOREIGN KEY (`Menu` )
    REFERENCES `mydb`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_Restaurant_Restaurant1`
    FOREIGN KEY (`Restaurant` )
    REFERENCES `mydb`.`Restaurant` (`RFC` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comanda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Comanda` (
  `idComanda` INT NOT NULL ,
  `Fecha` DATE NULL ,
  `Tipo` VARCHAR(45) NULL ,
  `Area` VARCHAR(45) NULL ,
  `Estado` VARCHAR(45) NULL ,
  `Clientes` INT NOT NULL ,
  `Mesa` INT NOT NULL ,
  `Mesero` INT NOT NULL ,
  PRIMARY KEY (`idComanda`) ,
  CONSTRAINT `fk_Comanda_Clientes1`
    FOREIGN KEY (`Clientes` )
    REFERENCES `mydb`.`Clientes` (`idClientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Mesa1`
    FOREIGN KEY (`Mesa` )
    REFERENCES `mydb`.`Mesa` (`idMesa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Mesero1`
    FOREIGN KEY (`Mesero` )
    REFERENCES `mydb`.`Mesero` (`idMesero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comanda_Producto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Comanda_Producto` (
  `Comanda` INT NOT NULL ,
  `Producto` VARCHAR(150) NOT NULL ,
  `Cantidad` DECIMAL NULL ,
  PRIMARY KEY (`Comanda`, `Producto`) ,
  CONSTRAINT `fk_Comanda_has_Producto_Comanda1`
    FOREIGN KEY (`Comanda` )
    REFERENCES `mydb`.`Comanda` (`idComanda` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_has_Producto_Producto1`
    FOREIGN KEY (`Producto` )
    REFERENCES `mydb`.`Producto` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Reservacion` (
  `Id` INT NOT NULL ,
  `Comensales` VARCHAR(45) NULL ,
  `Hora` TIME NULL ,
  `Fecha` DATE NULL ,
  `Clientes` INT NOT NULL ,
  `Mesa` INT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  CONSTRAINT `fk_Reservacion_Clientes1`
    FOREIGN KEY (`Clientes` )
    REFERENCES `mydb`.`Clientes` (`idClientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservacion_Mesa1`
    FOREIGN KEY (`Mesa` )
    REFERENCES `mydb`.`Mesa` (`idMesa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pago`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Pago` (
  `idPago` INT NOT NULL ,
  `Fecha` DATE NULL ,
  `Forma` VARCHAR(45) NULL ,
  `Monto` DECIMAL NULL ,
  `Comanda` INT NOT NULL ,
  `Turno` INT NOT NULL ,
  PRIMARY KEY (`idPago`) ,
  CONSTRAINT `fk_Pago_Comanda1`
    FOREIGN KEY (`Comanda` )
    REFERENCES `mydb`.`Comanda` (`idComanda` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pago_Turno1`
    FOREIGN KEY (`Turno` )
    REFERENCES `mydb`.`Turno` (`idTurno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Variante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Variante` (
  `Nombre` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NULL ,
  `Tiempo` TIME NULL ,
  PRIMARY KEY (`Nombre`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Variante_Producto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Variante_Producto` (
  `Variante` INT NOT NULL ,
  `Producto` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`Variante`, `Producto`) ,
  CONSTRAINT `fk_Variante_has_Producto_Variante1`
    FOREIGN KEY (`Variante` )
    REFERENCES `mydb`.`Variante` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variante_has_Producto_Producto1`
    FOREIGN KEY (`Producto` )
    REFERENCES `mydb`.`Producto` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Variante_Ingredientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Variante_Ingredientes` (
  `Variante_Nombre` INT NOT NULL ,
  `Ingredientes` INT NOT NULL ,
  PRIMARY KEY (`Variante_Nombre`, `Ingredientes`) ,
  CONSTRAINT `fk_Variante_has_Ingredientes_Variante1`
    FOREIGN KEY (`Variante_Nombre` )
    REFERENCES `mydb`.`Variante` (`Nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variante_has_Ingredientes_Ingredientes1`
    FOREIGN KEY (`Ingredientes` )
    REFERENCES `mydb`.`Ingredientes` (`idIngredientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Corte`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Corte` (
)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
