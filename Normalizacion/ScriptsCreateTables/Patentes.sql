CREATE TABLE [dbo].[Patentes] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [MES]         NVARCHAR (255) NULL,
    [AÑO]         NVARCHAR (255) NULL,
    [Provincia]   NVARCHAR (255) NULL,
    [Ciudad]      NVARCHAR (255) NULL,
    [Localidad]   NVARCHAR (255) NULL,
    [Direccion]   NVARCHAR (255) NULL,
    [CP]          NVARCHAR (255) NULL,
    [Titular]     NVARCHAR (255) NULL,
    [Segmento]    NVARCHAR (255) NULL,
    [Marca]       NVARCHAR (255) NULL,
    [Modelo]      NVARCHAR (255) NULL,
    [NOMVER]      NVARCHAR (255) NULL,
    [Línea]       NVARCHAR (255) NULL,
    [Normalizado] NVARCHAR (10)  NULL,
    [FechaNorm]   DATE           NULL,
    [CDTO]        BIT            NULL
);



