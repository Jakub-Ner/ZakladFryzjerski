CREATE TABLE `Usluga` (
  `NazwaU` String PRIMARY KEY,
  `CenaBazowa` float,
  `CzasWykonania` integer,
  `Opis` varchar(100) COMMENT 'Opis usługi, który będzie widoczny na stronie'
);

CREATE TABLE `Wizyta` (
  `IdW` Integer PRIMARY KEY,
  `Data` timestamp,
  `IdU` Usluga,
  `Status` ENUM ('oczekujaca', 'wTrakcie', 'zakonczona', 'odwolana') DEFAULT (oczekujaca),
  `Obslugujacy` Fryzjer,
  `Obslugiwany` Klient,
  `Ocena` integer COMMENT 'Ocena w skali 1-5',
  `OpiniaKlienta` varchar(100) COMMENT 'Ustawiana przez klienta, gdy Wizyta.Status = zakonczona',
  `Rabat` float DEFAULT 0,
  `DoZaplaty` float
);

CREATE TABLE `DzienPracy` (
  `IdD` Integer PRIMARY KEY,
  `IdF` Fryzjer,
  `Poczatek` timestamp,
  `Koniec` timestamp,
  `Nadgodziny` integer DEFAULT 0
);

CREATE TABLE `Fryzjer` (
  `IdF` Integer PRIMARY KEY,
  `Pensja` integer,
  `DataZatrudnienia` timestamp,
  `Opis` varchar(400) COMMENT 'Opis fryzjera, który będzie widoczny na stronie',
  `ImieF` varchar(15),
  `NazwiskoF` varchar(30),
  `TelefonF` varchar(25),
  `EmailF` varchar(30),
  `DataUrodzeniaF` timestamp,
  `PlecF` ENUM ('m', 'k')
);

CREATE TABLE `Klient` (
  `IdK` Integer PRIMARY KEY,
  `NIP` varchar(10),
  `DataRejestracji` timestamp DEFAULT (now()),
  `ImieK` varchar(15),
  `NazwiskoK` varchar(30),
  `TelefonK` varchar(25),
  `EmailK` varchar(30),
  `DataUrodzeniaK` timestamp,
  `PlecK` ENUM ('m', 'k')
);

ALTER TABLE `Wizyta` ADD FOREIGN KEY (`Obslugujacy`) REFERENCES `Fryzjer` (`IdF`);

ALTER TABLE `Wizyta` ADD FOREIGN KEY (`Obslugiwany`) REFERENCES `Klient` (`IdK`);

ALTER TABLE `Wizyta` ADD FOREIGN KEY (`IdU`) REFERENCES `Usluga` (`NazwaU`);

ALTER TABLE `DzienPracy` ADD FOREIGN KEY (`IdF`) REFERENCES `Fryzjer` (`IdF`);
