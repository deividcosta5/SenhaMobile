CREATE TABLE SENHA.CADASTRO(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ID_CELULAR VARCHAR(255) NOT NULL,
ID_SENHA INT NOT NULL,
ID_CLIENTE INT NOT NULL,
DATAHORA DATETIME NOT NULL DEFAULT(GETDATE()),
FINALIZADA BIT NOT NULL DEFAULT 0)

CREATE TABLE SENHA.STATUS(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
SETOR VARCHAR(100) NOT NULL,
SALA INT NOT NULL,
DESCR_SALA VARCHAR(25) NOT NULL,
TIPO CHAR(3) NOT NULL,
DATAHORA DATETIME NOT NULL DEFAULT GETDATE())