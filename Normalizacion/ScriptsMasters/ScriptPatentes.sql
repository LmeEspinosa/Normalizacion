USE [master]
GO
/****** Object:  Database [PatentesPru]    Script Date: 1/1/2019 20:12:50 ******/
CREATE DATABASE [PatentesPru]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'PatentesPru', FILENAME = N'C:\Users\lucas.espinosa\PatentesPru.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'PatentesPru_log', FILENAME = N'C:\Users\lucas.espinosa\PatentesPru_log.ldf' , SIZE = 466944KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PatentesPru] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PatentesPru].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PatentesPru] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PatentesPru] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PatentesPru] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PatentesPru] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PatentesPru] SET ARITHABORT OFF 
GO
ALTER DATABASE [PatentesPru] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PatentesPru] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PatentesPru] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PatentesPru] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PatentesPru] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PatentesPru] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PatentesPru] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PatentesPru] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PatentesPru] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PatentesPru] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PatentesPru] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PatentesPru] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PatentesPru] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PatentesPru] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PatentesPru] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PatentesPru] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PatentesPru] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PatentesPru] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PatentesPru] SET  MULTI_USER 
GO
ALTER DATABASE [PatentesPru] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PatentesPru] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PatentesPru] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PatentesPru] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PatentesPru] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PatentesPru] SET QUERY_STORE = OFF
GO
USE [PatentesPru]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [PatentesPru]
GO
/****** Object:  UserDefinedFunction [dbo].[BuscarCandidato]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[BuscarCandidato](@TCadena VARCHAR(100),@CP INT) 
RETURNS @Candidato TABLE
(    
    Id INT,
    Titular VARCHAR(100),
	CP INT,
	Provincia VARCHAR (200),
	Localidad VARCHAR (200),
	Ciudad VARCHAR (200),
	Direccion VARCHAR (200),   
	CDTO BIT
) AS BEGIN
         IF @CP IS NOT NULL
		 BEGIN
            IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND CP = @CP AND CDTO = 1) > 0
		    BEGIN
		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CDTO = 1
		    END
		    ELSE
		    BEGIN
		       IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND Direccion IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		       BEGIN
		          INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND Direccion IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)
		       END
			   ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		       BEGIN
		          INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)
		       END
			   ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		       BEGIN
		          INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)
		       END
			   ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		       BEGIN
		          INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)
		       END
			   ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		       BEGIN
 		          INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP = @CP AND (CDTO <> 1 OR CDTO IS NULL)
		       END
            END
		 END
		 ELSE
		 BEGIN		    
		    IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND Direccion IS NOT NULL AND CP IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		    BEGIN
		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CP IS NOT NULL AND Provincia IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)
		    END
			ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND Localidad IS NOT NULL AND CP IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		    BEGIN
		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CP IS NOT NULL AND Provincia IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)
		    END
			ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND Ciudad IS NOT NULL AND CP IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		    BEGIN
		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CP IS NOT NULL AND Provincia IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)
		    END
			ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		    BEGIN
		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CP IS NOT NULL AND Provincia IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)
		    END
			ELSE IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @TCadena AND Provincia IS NOT NULL AND CP IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)) > 0
		    BEGIN
 		       INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Ciudad,Provincia,Localidad,Direccion,CDTO FROM Patentes WHERE Titular = @TCadena AND CP IS NOT NULL AND Provincia IS NOT NULL AND (CDTO <> 1 OR CDTO IS NULL)
		    END
	     END
   RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[distance]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[distance](@s1 nvarchar(3999), @s2 nvarchar(3999))
RETURNS int
AS
BEGIN
 DECLARE @s1_len int, @s2_len int
 DECLARE @i int, @j int, @s1_char nchar, @c int, @c_temp int
 DECLARE @cv0 varbinary(8000), @cv1 varbinary(8000)

 SELECT
  @s1_len = LEN(@s1),
  @s2_len = LEN(@s2),
  @cv1 = 0x0000,
  @j = 1, @i = 1, @c = 0

 WHILE @j <= @s2_len
  SELECT @cv1 = @cv1 + CAST(@j AS binary(2)), @j = @j + 1

 WHILE @i <= @s1_len
 BEGIN
  SELECT
   @s1_char = SUBSTRING(@s1, @i, 1),
   @c = @i,
   @cv0 = CAST(@i AS binary(2)),
   @j = 1

  WHILE @j <= @s2_len
  BEGIN
   SET @c = @c + 1
   SET @c_temp = CAST(SUBSTRING(@cv1, @j+@j-1, 2) AS int) +
    CASE WHEN @s1_char = SUBSTRING(@s2, @j, 1) THEN 0 ELSE 1 END
   IF @c > @c_temp SET @c = @c_temp
   SET @c_temp = CAST(SUBSTRING(@cv1, @j+@j+1, 2) AS int)+1
   IF @c > @c_temp SET @c = @c_temp
   SELECT @cv0 = @cv0 + CAST(@c AS binary(2)), @j = @j + 1
 END

 SELECT @cv1 = @cv0, @i = @i + 1
 END

 RETURN @c
END
GO
/****** Object:  UserDefinedFunction [dbo].[RazonSocialPorPalabra]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[RazonSocialPorPalabra](@TCadena VARCHAR(100)) 
RETURNS @RazonSocial TABLE
(    
    Id INT IDENTITY,
    Cadena VARCHAR(100)
) AS BEGIN     	 
     DECLARE @cadena varchar(1000) = @TCadena;
	 DECLARE @CadenaAux VARCHAR(50);
     DECLARE @pos INT;
     DECLARE @LEN INT;
	 DECLARE @LENAux INT;	  	 
     SET @Pos = PATINDEX('% %',@cadena)
     IF (@pos)>0
     BEGIN
	    IF SUBSTRING(@cadena,1,@Pos)='MERCEDESBENZ'
	    BEGIN
		   SET @CadenaAux = SUBSTRING(@cadena,0,@pos-4);
		   SET @LENAux = LEN(@CadenaAux);
		   SET @cadena = @CadenaAux+' '+ SUBSTRING(@cadena,@pos-4,LEN(@cadena));
	    END
		ELSE
		BEGIN
	       SET @CadenaAux = SUBSTRING(@cadena,0,@pos);
		   SET @LENAux = LEN(@CadenaAux)
        END
		IF @LENAux = 1 
		BEGIN
		   SET @cadena = STUFF(@cadena,@pos,1,'');			
		END	
        ELSE
	    BEGIN
	       SET @LEN = LEN(@CadenaAux)+1;		
	       INSERT INTO @RazonSocial (Cadena) VALUES (@CadenaAux);
	       SET @cadena = STUFF(@cadena,1,@LEN,'');
	    END
     END		
     WHILE @Pos > 0 
     BEGIN
	    SET @Pos = 0	     
        SET @Pos = PATINDEX('% %',@cadena);		
		IF @Pos = 1
		BEGIN
		   SET @cadena = STUFF(@cadena,@pos,1,'');
		  END
        ELSE
		BEGIN
	       IF @Pos = 0 AND LEN(@cadena)>0
	       BEGIN	      
		      SET @CadenaAux = SUBSTRING(@cadena,1,LEN(@cadena));      
	          INSERT INTO @RazonSocial (Cadena) VALUES (@CadenaAux);   
	          SET @cadena = STUFF(@cadena,1,LEN(@cadena),'');
	       END
		   ELSE
		   BEGIN	   
              IF  @Pos > 0		    
	          BEGIN
	             SET @CadenaAux = SUBSTRING(@cadena,1,@pos);
		         SET @LENAux = LEN(@CadenaAux)
		      END
		      IF (@LENAux<3 AND (SUBSTRING(@CadenaAux,1,2) ='SR' OR (SUBSTRING(@CadenaAux,1,2)='SA') OR (SUBSTRING(@CadenaAux,1,2)='SH')))  
		      OR (@LENAux=1 AND (SUBSTRING(@CadenaAux,1,2) ='S'))
		      BEGIN
		         SET @cadena = STUFF(@cadena,@pos,1,'');			
		      END	
              ELSE
	          BEGIN
		         SET @LEN = LEN(@CadenaAux)+1;		      
	             INSERT INTO @RazonSocial (Cadena) VALUES (@CadenaAux);
		         SET @cadena = STUFF(@cadena,1,@LEN,'');
		         SET @CadenaAux ='';		
              END
           END
	    END  
     END
  RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[RecorrerTabla]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[RecorrerTabla](@cadena varchar(100))
RETURNS VARCHAR(100)
AS BEGIN
DECLARE @TablaAux TABLE (Id INT,TCad VARCHAR(100));
INSERT INTO @TablaAux SELECT * FROM dbo.RazonSocialPorPalabra(@cadena);
DECLARE @id int,@count int;
DECLARE @cadenaRET VARCHAR(100);
SET @id=1;
SELECT @count=COUNT(*)FROM @TablaAux;

WHILE (@id<=@count)
BEGIN
SET @cadenaRET = CONCAT(@cadenaRET,' ',(SELECT TCad 
	                  FROM @TablaAux
                     WHERE Id=@id))

   SET @id+=1   
   END
   RETURN @cadenaRET
END
GO
/****** Object:  UserDefinedFunction [dbo].[RecorrerTablaSociedades]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE FUNCTION [dbo].[RecorrerTablaSociedades](@cadena varchar(100))
RETURNS VARCHAR(100)
AS BEGIN
DECLARE @TablaAux TABLE (Id INT,TCad VARCHAR(100));
INSERT INTO @TablaAux SELECT * FROM dbo.RazonSocialPorPalabra(@cadena);
DECLARE @id int,@count int;
DECLARE @cadenaRET VARCHAR(100)
DECLARE @Aux VARCHAR (100);
DECLARE @Soc VARCHAR (100);
DECLARE @IdSoc INT;
SET @id=1;
SELECT @count=COUNT(*)FROM @TablaAux;

WHILE (@id<=@count)
BEGIN
   SET @Aux   = (SELECT TCad FROM @TablaAux WHERE Id=@id)
   IF @IdSoc +1 = @id
   BEGIN
      IF LEN(@Aux)>=2 AND PATINDEX('DE',@Aux) = 0 AND PATINDEX('EN',@Aux) = 0
	  BEGIN 
         SET @Aux   = RTRIM(LTRIM((SELECT TCad FROM @TablaAux WHERE Id=@id)))
         SET @Soc   = RTRIM(LTRIM((SELECT TOP 1 Abrev  FROM TipoSociedades WHERE (NombreSociedad LIKE '%'+@Aux+'%') OR (Opcion1 IS NOT NULL AND Opcion1 LIKE '%'+@Aux+'%') 
		              OR (Opcion2 IS NOT NULL AND Opcion2 LIKE '%'+@Aux+'%') OR (Opcion3 IS NOT NULL AND Opcion3 LIKE '%'+@Aux+'%'))))
		 SET @cadenaRET = RTRIM(LTRIM(CONCAT(@cadenaRET,' ',@Soc)))
		 SET @id+=@count		 
		 BREAK
	  END
	  ELSE
	  IF @Aux = SUBSTRING('DE',1,LEN(@Aux)) OR @Aux = SUBSTRING('EN',1,LEN(@Aux))
	  BEGIN	            
		SET @Aux = ''
	    SET @IdSoc = @id
		SET @id+=1
	  END
	  ELSE
	  SET @id+=1      --hacer BREAK
   END
   ELSE
   BEGIN
      IF @id <>1 AND (@Aux = SUBSTRING('SOCIEDAD',1,LEN(@Aux)) OR dbo.distance('SOCIEDAD',@Aux)<3)
      BEGIN         
	     SET @IdSoc = @id
      END
	  ELSE IF (@Aux = SUBSTRING('COMPAÑIA',1,LEN(@Aux)) OR dbo.distance('COMPAÑIA',@Aux)<3) OR (@Aux = SUBSTRING('TRANSPORTE',1,LEN(@Aux)) OR dbo.distance('TRANSPORTE',@Aux)<3)
	  BEGIN
         SET @Aux   = RTRIM(LTRIM((SELECT TCad FROM @TablaAux WHERE Id=@id)))
         SET @Soc   = RTRIM(LTRIM((SELECT TOP 1 Abrev  FROM TipoSociedades WHERE (NombreSociedad LIKE '%'+@Aux+'%') OR (Opcion1 IS NOT NULL AND Opcion1 LIKE '%'+@Aux+'%') 
		              OR (Opcion2 IS NOT NULL AND Opcion2 LIKE '%'+@Aux+'%') OR (Opcion3 IS NOT NULL AND Opcion3 LIKE '%'+@Aux+'%'))))
		 SET @cadenaRET = RTRIM(LTRIM(CONCAT(@cadenaRET,' ',@Soc)))		 
	  END
      ELSE
      BEGIN
         SET @cadenaRET = RTRIM(LTRIM(CONCAT(@cadenaRET,' ',(SELECT TCad 
	                  FROM @TablaAux
                     WHERE Id=@id))))
      END
      SET @id+=1   
   END   
END
RETURN @cadenaRET
END


GO
/****** Object:  UserDefinedFunction [dbo].[RemoveChars]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[RemoveChars](@cadena varchar(1000))
RETURNS VARCHAR(1000)
BEGIN
  DECLARE @pos INT
  SET @Pos = PATINDEX('%[^abcdefghijlmnñopqrstuvxyzABCDEFGHIJKLMNÑOPQRSTUVXYZ0123456789 ]%',@cadena)
  IF (@pos)>0	   
	 SET @cadena = STUFF(@cadena,@pos,1,'')  
  WHILE @Pos > 0
     BEGIN    
     SET @Pos = PATINDEX('%[^abcdefghijlmnñopqrstuvxyzABCDEFGHIJKLMNÑOPQRSTUVXYZ0123456789 ]%',@cadena)
     IF (@pos)>0	   
	    SET @cadena = STUFF(@cadena,@pos,1,'')  
     END
  RETURN @cadena
END
GO
/****** Object:  Table [dbo].[CP]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CP](
	[IdCP] [int] IDENTITY(1,1) NOT NULL,
	[PROVINCIA] [nvarchar](255) NULL,
	[LOCALIDAD] [nvarchar](255) NULL,
	[CodigoPostal] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Marca] [varchar](100) NULL,
	[Abrev] [varchar](100) NULL,
	[Opcion1] [varchar](100) NULL,
	[Opcion2] [varchar](100) NULL,
	[Opcion3] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patentes]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patentes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MES] [nvarchar](255) NULL,
	[AÑO] [nvarchar](255) NULL,
	[Provincia] [nvarchar](255) NULL,
	[Ciudad] [nvarchar](255) NULL,
	[Localidad] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL,
	[Titular] [nvarchar](255) NULL,
	[Segmento] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[Modelo] [nvarchar](255) NULL,
	[NOMVER] [nvarchar](255) NULL,
	[Línea] [nvarchar](255) NULL,
	[Normalizado] [nvarchar](10) NULL,
	[FechaNorm] [date] NULL,
	[CDTO] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoSociedades]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoSociedades](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreSociedad] [varchar](100) NULL,
	[Abrev] [varchar](100) NULL,
	[Opcion1] [varchar](100) NULL,
	[Opcion2] [varchar](100) NULL,
	[Opcion3] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRegistros]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarRegistros] 
@Id_Origen INT,
@Id_Destino INT,
@Titular VARCHAR (200),
@Provincia VARCHAR (200),
@Ciudad VARCHAR (200),
@Localidad VARCHAR (200),
@Direccion VARCHAR (200),
@CP INT,
@CDTO BIT

AS
BEGIN
   SET NOCOUNT ON;
   DECLARE @MSGS VARCHAR (1000);
   DECLARE @MSGE VARCHAR (1000);
   
  
   DECLARE @TitularAux int;
   DECLARE @Id_Aux int;
   DECLARE @ProvinciaAux VARCHAR (200);
   DECLARE @CiudadAux VARCHAR (200);
   DECLARE @LocalidadAux VARCHAR (200);
   DECLARE @DireccionAux VARCHAR (200);
   DECLARE @CPAux INT;
   DECLARE @CDTOAux BIT;

   DECLARE @Candidato TABLE
	(
	IDT INT,
	TitularT VARCHAR(200),
	CPT INT,
	ProvinciaT VARCHAR(200),
	LocalidadT VARCHAR(200),
	CiudadT VARCHAR (200),
	DireccionT VARCHAR (200),
	CDTOT                BIT
	)

    IF @Titular IS NOT NULL
    BEGIN
	   SET @Titular =LTRIM(RTRIM(@Titular))	
	   SET @Provincia = LTRIM(RTRIM(@Provincia))
       SET @Ciudad = LTRIM(RTRIM(@Ciudad))
       SET @Localidad = LTRIM(RTRIM(@Localidad))
       SET @Direccion = LTRIM(RTRIM(@Direccion))

	       IF @CDTO <> 1 OR @CDTO IS NULL
		   BEGIN  
			  INSERT INTO @Candidato SELECT * FROM dbo.BuscarCandidato(@Titular,@CP);
			  
			  SET @Id_Aux       = LTRIM(RTRIM((SELECT IDT FROM @Candidato)))
			  SET @TitularAux   = LTRIM(RTRIM((SELECT TitularT FROM @Candidato)))
			  SET @ProvinciaAux = LTRIM(RTRIM((SELECT ProvinciaT FROM @Candidato)))
			  SET @LocalidadAux = LTRIM(RTRIM((SELECT LocalidadT FROM @Candidato)))
			  SET @CiudadAux    = LTRIM(RTRIM((SELECT CiudadT FROM @Candidato)))
			  SET @DireccionAux = LTRIM(RTRIM((SELECT DireccionT FROM @Candidato)))
			  SET @CPAux        = LTRIM(RTRIM((SELECT CPT FROM @Candidato)))
			  SET @CDTOAux      = LTRIM(RTRIM((SELECT CDTOT FROM @Candidato)))
		   END	
		   IF @CDTOAux IS NOT NULL
		   BEGIN
			  BEGIN TRY
				 UPDATE Patentes SET Titular = (@TitularAux), Provincia = @ProvinciaAux, Ciudad = @CiudadAux, Localidad = @LocalidadAux, Direccion = @DireccionAux,
						CP = @CPAux, Normalizado = 'OK', CDTO = @CDTOAux  WHERE ID = @Id_Destino   								        
				 SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Destino,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
				 EXEC [DBLogs].[dbo].[LogCallNoError]
				 @Mensaje = @MSGS 		               
			  END TRY
			  BEGIN CATCH		  
				 SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Destino,' DE LA TABLA Patentes PROC ActualizarRegistrosCandidato');		  
				 EXEC [DBLogs].[dbo].[RaiseError]
				 @Name = N'SPLogs',
				 @Mensaje = @MSGE
			  END CATCH
			  BEGIN TRY
				 UPDATE Patentes SET Titular = (@TitularAux), Provincia = @ProvinciaAux, Ciudad = @CiudadAux, Localidad = @LocalidadAux, Direccion = @DireccionAux,
						CP = @CPAux, Normalizado = 'OK', CDTO = @CDTOAux  WHERE ID = @Id_Origen   								        
				 SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Origen,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
				 EXEC [DBLogs].[dbo].[LogCallNoError]
				 @Mensaje = @MSGS 		               
			  END TRY
			  BEGIN CATCH		  
				 SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Origen,' DE LA TABLA Patentes PROC ActualizarRegistrosCandidato');		  
				 EXEC [DBLogs].[dbo].[RaiseError]
				 @Name = N'SPLogs',
				 @Mensaje = @MSGE
			  END CATCH	      
		   END
		   ELSE IF @CDTO = 1 -- TITULAR 1 ES CANDIDATO
		   BEGIN
			  BEGIN TRY   -- ACTUALIZO TITULAR 2 CAMPOS Y LO MARCO COMO CANDIDATO
				 UPDATE Patentes SET Titular = (@Titular), Provincia = @Provincia, Ciudad = @Ciudad, Localidad = @Localidad, Direccion = @Direccion,
						CP = @CP, Normalizado = 'OK', CDTO = @CDTOAux  WHERE ID = @Id_Destino   								        
				 SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Destino,' TITULAR ',@Titular,' COMO CANDIDATO ')
				 EXEC [DBLogs].[dbo].[LogCallNoError]
				 @Mensaje = @MSGS 		               
			  END TRY
			  BEGIN CATCH  
				 SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Destino,' TITULAR ',@Titular,' AL MODIFICARLO COMO CANDIDATO');
				 EXEC [DBLogs].[dbo].[RaiseError]
				 @Name = N'SPLogs',
				 @Mensaje = @MSGE
			  END CATCH
			  BEGIN TRY  -- ACTUALIZO TITULAR 1	COMO CANDIDATO	  
				 UPDATE Patentes SET Normalizado = 'OK', CDTO = 1  WHERE ID = @Id_Origen
				 SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Origen,' TITULAR ',@Titular,' COMO CANDIDATO ')
				 EXEC [DBLogs].[dbo].[LogCallNoError]
				 @Mensaje = @MSGS 		               
			  END TRY
			  BEGIN CATCH		  
				 SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Origen,' TITULAR ',@Titular,' AL MODIFICARLO COMO CANDIDATO');		  
				 EXEC [DBLogs].[dbo].[RaiseError]
				 @Name = N'SPLogs',
				 @Mensaje = @MSGE
			  END CATCH			  	      
		   END
		   ELSE   -- NO CANDIDATO
		   BEGIN
		      IF @TitularAux IS NOT NULL AND @ProvinciaAux IS NOT NULL AND @CiudadAux IS NOT NULL AND @LocalidadAux IS NOT NULL AND @DireccionAux IS NOT NULL AND @CPAux IS NOT NULL AND @CDTOAux <> 1 
			  BEGIN
			     BEGIN TRY  -- EL REGISTRO ES CANDIDATO PERO NO ESTA MARCADO COMO TAL
				    UPDATE Patentes SET Normalizado = 'OK', CDTO = 1  WHERE ID = @Id_Aux   								        
				    SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Aux,' TITULAR ',@TitularAux,' COMO CANDIDATO ')
				    EXEC [DBLogs].[dbo].[LogCallNoError]
				    @Mensaje = @MSGS 		               
			     END TRY
			     BEGIN CATCH		  
				    SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Aux,' TITULAR ',@TitularAux,' AL MODIFICARLO COMO CANDIDATO');		  
				    EXEC [DBLogs].[dbo].[RaiseError]
				    @Name = N'SPLogs',
				    @Mensaje = @MSGE
			     END CATCH	      			   
			  END
			  ELSE
			  BEGIN 
			     BEGIN TRY	-- SE BUSCO PERO NO HAY CANDIDATO PARA ESA RAZON SOCIAL, ENTONCES ACTUALIZO PERO NO MARCO COMO CANDIDATO YA QUE CONTINE CAMPOS NULL		  			     
				    UPDATE Patentes SET Titular = (@TitularAux), Provincia = @ProvinciaAux, Ciudad = @CiudadAux, Localidad = @LocalidadAux, Direccion = @DireccionAux,
						   CP = @CPAux, Normalizado = 'OK', CDTO = 0 WHERE ID = @Id_Destino				        
				    SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Destino,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
				    EXEC [DBLogs].[dbo].[LogCallNoError]
				    @Mensaje = @MSGS 		               
			     END TRY
			     BEGIN CATCH		  
				    SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Destino,' DE LA TABLA Patentes PROC buscarParecidos');		  
				    EXEC [DBLogs].[dbo].[RaiseError]
				    @Name = N'SPLogs',
				    @Mensaje = @MSGE
			     END CATCH
			     BEGIN TRY	-- SE BUSCO PERO NO HAY CANDIDATO PARA ESA RAZON SOCIAL, ENTONCES ACTUALIZO PERO NO MARCO COMO CANDIDATO YA QUE CONTINE CAMPOS NULL		  			     
				    UPDATE Patentes SET Titular = (@TitularAux), Provincia = @ProvinciaAux, Ciudad = @CiudadAux, Localidad = @LocalidadAux, Direccion = @DireccionAux,
						   CP = @CPAux, Normalizado = 'OK', CDTO = 0 WHERE ID = @Id_Origen				        
				    SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@Id_Origen,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
				    EXEC [DBLogs].[dbo].[LogCallNoError]
				    @Mensaje = @MSGS 		               
			     END TRY
			     BEGIN CATCH	
				    SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id_Origen,' DE LA TABLA Patentes PROC buscarParecidos');		  
				    EXEC [DBLogs].[dbo].[RaiseError]
				    @Name = N'SPLogs',
				    @Mensaje = @MSGE
			     END CATCH	      
		      END
		   END		
    END
    BEGIN  -- ERROR LA RAZON SOCIAL ES NULL
	   SET @MSGE = CONCAT('ERROR EL REGISTRO CON ID : ',@Id_Origen,' LA RAZON SOCIAL ES NULL');		  
	   EXEC [DBLogs].[dbo].[RaiseError]
	   @Name = N'SPLogs',
	   @Mensaje = @MSGE
	END
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarParecidos]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Espinosa Lucas
-- Create date: 18-11-2018
-- Description: Buscar similares para nomrmalizacion de datos
-- =============================================
CREATE PROCEDURE [dbo].[BuscarParecidos]    
AS
BEGIN
	SET NOCOUNT ON
    DECLARE @Titular varchar(200);
    DECLARE @Id INT;	
	DECLARE @Provincia varchar(200);  
	DECLARE @Localidad varchar(200);
	DECLARE @CDTO BIT;

    DECLARE @TitularRS varchar(200);
	DECLARE @ProvinciaRS varchar(200);  
	DECLARE @LocalidadRS varchar(200);
	DECLARE @CP INT;
	DECLARE @CPRS INT;
	DECLARE @CDTORS BIT;
	
	DECLARE @IDAux INT;
    DECLARE @TitularAux varchar(200);
	DECLARE @ProvinciaAux varchar(200);  
	DECLARE @LocalidadAux varchar(200);
	DECLARE @CPAux INT;
	DECLARE @CDTOAux BIT;

	DECLARE @PATH INT;
	DECLARE @DIFF INT;
	DECLARE @IDRS INT;
	DECLARE @MSGS VARCHAR(1000);
	DECLARE @MSGE VARCHAR(1000);
	DECLARE @Candidato TABLE
	(
	IDT INT,
	TitularT VARCHAR(200),
	CPT INT,
	ProvinciaT VARCHAR(200),
	LocalidadT VARCHAR(200),
	CDTO                BIT
	)  			  		

	DECLARE Titular_Cursor CURSOR FOR SELECT ID,Titular,Provincia,Localidad,CP,CDTO FROM Patentes WHERE Normalizado IS NULL
    OPEN Titular_Cursor;

    FETCH NEXT FROM Titular_Cursor
    INTO @Id,@Titular,@Provincia,@Localidad,@CP,@CDTO

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
		DECLARE ResultSet CURSOR FOR

      SELECT Titular,Provincia,Localidad,CP,PATINDEX('%'+ @Titular + '%', Titular) AS PC,  
             DIFFERENCE(@Titular, Titular) AS DIF,ID,CDTO--@Titular--,@Titular AS String--,@StringFirst,@StringSecond
        FROM Patentes
	   WHERE DIFFERENCE(@Titular, Titular)>1 AND PATINDEX('%'+ @Titular + '%', Titular)>0 AND ID<>@ID
    --GROUP BY Titular,Provincia,CP,Localidad
      --HAVING PATINDEX('%' + @Buscar + '%', Titular)>0 AND COUNT(*)>1 
    ORDER BY DIFFERENCE(@Titular, RTRIM(Titular)) DESC;

		OPEN ResultSet;
		FETCH NEXT FROM ResultSet
		INTO @TitularRS,@ProvinciaRS,@LocalidadRS,@CPRS,@PATH,@DIFF,@IDRS,@CDTO
		   
		WHILE @@FETCH_STATUS = 0
		BEGIN
		   IF @Titular <> @TitularRS AND @TitularRS IS NOT NULL 
		   BEGIN 
		      IF dbo.distance(@Titular,@TitularRS) BETWEEN 1 AND 2
			  BEGIN
				 IF @CDTO = 1 --ES CANDIDATO
				 BEGIN
				    IF @CDTORS <> 1 --NO ES CANDIDATO
					BEGIN
					   BEGIN TRY
					      UPDATE Patentes SET Titular = RTRIM(LTRIM(@Titular)), Provincia = @Provincia, Localidad = @Localidad, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		       				     	      WHERE ID = @IDRS
					      SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
					      EXEC [DBLogs].[dbo].[LogCallNoError]
					      @Mensaje = @MSGS 		               
					   END TRY
					   BEGIN CATCH		  
					      SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
					      EXEC [DBLogs].[dbo].[RaiseError]
					      @Name = N'SPLogs',
					      @Mensaje = @MSGE
					   END CATCH
				    END
			     END						 					
				 ELSE
				 BEGIN
				    IF @CDTORS = 1 --ES CANDIDATO
					BEGIN
					   BEGIN TRY
					   UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularRS)), Provincia = @ProvinciaRS, Localidad = @LocalidadRS, CP = @CPRS, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		       		         		   WHERE ID = @ID
					   SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularRS)
					   EXEC [DBLogs].[dbo].[LogCallNoError]
					   @Mensaje = @MSGS 		               
					   END TRY
					   BEGIN CATCH		  
					   SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
					   EXEC [DBLogs].[dbo].[RaiseError]
					   @Name = N'SPLogs',
					   @Mensaje = @MSGE
					   END CATCH
					END
					ELSE   -- NO HAY CANDIDATOS
					BEGIN
					   IF @CP IS NOT NULL
					   BEGIN
					      IF @Provincia IS NOT NULL AND @Localidad IS NOT NULL
					      BEGIN
						     BEGIN TRY
						        UPDATE Patentes SET Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 WHERE ID = @ID -- AHORA ES CANDIDATO

						        UPDATE Patentes SET Titular = RTRIM(LTRIM(@Titular)), Provincia = @Provincia, Localidad = @Localidad, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 -- NUEVO CANDIDATO
		       		         			        WHERE ID = @IDRS
						        SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
						        EXEC [DBLogs].[dbo].[LogCallNoError]
						        @Mensaje = @MSGS 		               
						     END TRY
						     BEGIN CATCH		  
						        SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						        EXEC [DBLogs].[dbo].[RaiseError]
						        @Name = N'SPLogs',
						        @Mensaje = @MSGE
						     END CATCH					  					   
					      END					   
					      ELSE  -- CP NO NULO PERO PROVINCIA O LOCALIDAD SI
					      IF @CPRS IS NOT NULL
					      BEGIN
					         IF @ProvinciaRS IS NOT NULL AND @LocalidadRS IS NOT NULL
					         BEGIN
						        BEGIN TRY
						           UPDATE Patentes SET Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 WHERE ID = @IDRS -- AHORA ES CANDIDATO

						           UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularRS)), Provincia = @ProvinciaRS, Localidad = @LocalidadRS, CP = @CPRS, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 -- NUEVO CANDIDATO
		       		         			           WHERE ID = @ID
						           SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
						           EXEC [DBLogs].[dbo].[LogCallNoError]
						           @Mensaje = @MSGS 		               
						        END TRY
						        BEGIN CATCH		  
						           SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						           EXEC [DBLogs].[dbo].[RaiseError]
						           @Name = N'SPLogs',
						           @Mensaje = @MSGE
						        END CATCH
					         END
                          END
                       END
					   ELSE
					   BEGIN
                          IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @Titular AND (CDTO = 1 OR (CP IS NOT NULL AND Provincia IS NOT NULL)))>0
					      BEGIN
						     INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Provincia,Localidad,CDTO FROM Patentes WHERE Titular = @Titular AND ((CP IS NOT NULL) OR CDTO = 1)						     
						     SET @TitularAux   = (SELECT TitularT FROM @Candidato)  
						     SET @ProvinciaAux = (SELECT ProvinciaT FROM @Candidato)
						     SET @LocalidadAux = (SELECT LocalidadT FROM @Candidato)
						     SET @CPAux        = (SELECT CPT FROM @Candidato)
						     SET @CDTOAux      = (SELECT CDTO FROM @Candidato)
						     BEGIN TRY
						        UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularAux)), Provincia = @ProvinciaAux, Localidad = @LocalidadAux, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		     							        WHERE ID = @ID
						        SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@ID,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
						        EXEC [DBLogs].[dbo].[LogCallNoError]
						        @Mensaje = @MSGS 		               
						     END TRY
						     BEGIN CATCH		  
						        SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@ID,' DE LA TABLA Patentes PROC buscarParecidos');		  
						        EXEC [DBLogs].[dbo].[RaiseError]
						        @Name = N'SPLogs',
						        @Mensaje = @MSGE
						     END CATCH
						     BEGIN TRY
						        UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularAux)), Provincia = @ProvinciaAux, Localidad = @LocalidadAux, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		     							        WHERE ID = @IDRS
						        SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
						        EXEC [DBLogs].[dbo].[LogCallNoError]
						        @Mensaje = @MSGS 		               
						     END TRY
						     BEGIN CATCH		  
						        SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						        EXEC [DBLogs].[dbo].[RaiseError]
						        @Name = N'SPLogs',
						        @Mensaje = @MSGE
						     END CATCH							 				
                          END
                       END
                    END
                 END
			  END
           END
		   ELSE -- SON IGUALES
		   BEGIN
			  IF @CDTO = 1 --ES CANDIDATO
			  BEGIN
			     IF @CDTORS <> 1 --NO ES CANDIDATO
			     BEGIN
				    BEGIN TRY
					   UPDATE Patentes SET Titular = RTRIM(LTRIM(@Titular)), Provincia = @Provincia, Localidad = @Localidad, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		       				     	   WHERE ID = @IDRS
					   SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
					   EXEC [DBLogs].[dbo].[LogCallNoError]
					   @Mensaje = @MSGS 		               
				    END TRY
				    BEGIN CATCH		  
					   SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
					   EXEC [DBLogs].[dbo].[RaiseError]
					   @Name = N'SPLogs',
					   @Mensaje = @MSGE
				    END CATCH
			     END
			  END						 					
		      ELSE
			  BEGIN
			     IF @CDTORS = 1 --ES CANDIDATO
			     BEGIN
				    BEGIN TRY
				       UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularRS)), Provincia = @ProvinciaRS, Localidad = @LocalidadRS, CP = @CPRS, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		       		         	       WHERE ID = @ID
				       SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularRS)
				       EXEC [DBLogs].[dbo].[LogCallNoError]
				       @Mensaje = @MSGS 		               
				       END TRY
				    BEGIN CATCH		  
				       SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
				       EXEC [DBLogs].[dbo].[RaiseError]
				       @Name = N'SPLogs',
				       @Mensaje = @MSGE
				    END CATCH
			     END
			     ELSE   -- NO HAY CANDIDATOS
			     BEGIN
				    IF @CP IS NOT NULL
				    BEGIN
					   IF @Provincia IS NOT NULL AND @Localidad IS NOT NULL
					   BEGIN
						  BEGIN TRY
						     UPDATE Patentes SET Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 WHERE ID = @ID -- AHORA ES CANDIDATO

						     UPDATE Patentes SET Titular = RTRIM(LTRIM(@Titular)), Provincia = @Provincia, Localidad = @Localidad, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 -- NUEVO CANDIDATO
		       		         			     WHERE ID = @IDRS
						     SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
						     EXEC [DBLogs].[dbo].[LogCallNoError]
						     @Mensaje = @MSGS 		               
						  END TRY
						  BEGIN CATCH		  
						     SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						     EXEC [DBLogs].[dbo].[RaiseError]
						     @Name = N'SPLogs',
						     @Mensaje = @MSGE
						  END CATCH					  					   
					   END					   
					   ELSE  -- CP NO NULO PERO PROVINCIA O LOCALIDAD SI
					   IF @CPRS IS NOT NULL
					   BEGIN
					      IF @ProvinciaRS IS NOT NULL AND @LocalidadRS IS NOT NULL
					      BEGIN
						     BEGIN TRY
						        UPDATE Patentes SET Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 WHERE ID = @IDRS -- AHORA ES CANDIDATO

						        UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularRS)), Provincia = @ProvinciaRS, Localidad = @LocalidadRS, CP = @CPRS, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 -- NUEVO CANDIDATO
		       		         			        WHERE ID = @ID
						        SET @MSGS = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@TitularRS,' POR : ',@Titular)
						        EXEC [DBLogs].[dbo].[LogCallNoError]
						        @Mensaje = @MSGS 		               
						     END TRY
						     BEGIN CATCH		  
						        SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						        EXEC [DBLogs].[dbo].[RaiseError]
						        @Name = N'SPLogs',
						        @Mensaje = @MSGE
						     END CATCH
					      END
                       END
                    END
				    ELSE
				    BEGIN
                       IF (SELECT COUNT(*) FROM Patentes WHERE Titular = @Titular AND (CDTO = 1 OR (CP IS NOT NULL AND Provincia IS NOT NULL)))>0
					   BEGIN
						  INSERT INTO @Candidato SELECT TOP 1 ID,Titular,CP,Provincia,Localidad,CDTO FROM Patentes WHERE Titular = @Titular AND ((CP IS NOT NULL) OR CDTO = 1)						     
						  SET @TitularAux   = (SELECT TitularT FROM @Candidato)  
						  SET @ProvinciaAux = (SELECT ProvinciaT FROM @Candidato)
						  SET @LocalidadAux = (SELECT LocalidadT FROM @Candidato)
						  SET @CPAux        = (SELECT CPT FROM @Candidato)
						  SET @CDTOAux      = (SELECT CDTO FROM @Candidato)
						  BEGIN TRY
						     UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularAux)), Provincia = @ProvinciaAux, Localidad = @LocalidadAux, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		     							     WHERE ID = @ID
						     SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@ID,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
						     EXEC [DBLogs].[dbo].[LogCallNoError]
						     @Mensaje = @MSGS 		               
						  END TRY
						  BEGIN CATCH		  
						     SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@ID,' DE LA TABLA Patentes PROC buscarParecidos');		  
						     EXEC [DBLogs].[dbo].[RaiseError]
						     @Name = N'SPLogs',
						     @Mensaje = @MSGE
						  END CATCH
						  BEGIN TRY
						     UPDATE Patentes SET Titular = RTRIM(LTRIM(@TitularAux)), Provincia = @ProvinciaAux, Localidad = @LocalidadAux, CP = @CP, Normalizado = 'OK',FechaNorm = GETDATE(),CDTO = 1 
		     							     WHERE ID = @IDRS
						     SET @MSGS  = CONCAT('SE ACTUALIZO EL ID : ',@IDRS,' SE MODIFICO EL TITULAR: ',@Titular,' POR : ',@TitularAux)
						     EXEC [DBLogs].[dbo].[LogCallNoError]
						     @Mensaje = @MSGS 		               
						  END TRY
						  BEGIN CATCH		  
						     SET @MSGE = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@IDRS,' DE LA TABLA Patentes PROC buscarParecidos');		  
						     EXEC [DBLogs].[dbo].[RaiseError]
						     @Name = N'SPLogs',
						     @Mensaje = @MSGE
						  END CATCH							 				
                       END
                    END
                 END
              END
           END
		   FETCH NEXT FROM ResultSet
	       INTO @TitularRS,@ProvinciaRS,@LocalidadRS,@CPRS,@PATH,@DIFF,@IDRS,@CDTO
		END   		    
	    CLOSE ResultSet;  
	    DEALLOCATE ResultSet;	   
        FETCH NEXT FROM Titular_Cursor
        INTO @Id,@Titular,@Provincia,@Localidad,@CP,@CDTO
     END
     CLOSE Titular_Cursor;  
     DEALLOCATE Titular_Cursor;	 	                 
END
GO
/****** Object:  StoredProcedure [dbo].[Crear_DB_Y_TablaSPLogs]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Crear_DB_Y_TablaSPLogs] 
AS
	IF db_id(N'DBLogs') IS NULL
	BEGIN
       PRINT 'CREANDO DB PARA LOGS DE SP'
	   CREATE DATABASE DBLogs;	   
	END
GO
/****** Object:  StoredProcedure [dbo].[CrearTablaTipoSociedades]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CrearTablaTipoSociedades] 
AS
IF NOT EXISTS
   (  SELECT [name] 
      FROM sys.tables
      WHERE [name] = 'TipoSociedades'
   )
CREATE TABLE [dbo].[TipoSociedades](
	[Id] [int] IDENTITY,
	[NombreSociedad] [varchar](100) NULL,
	[Abrev] [varchar](100) NULL,
	[Opcion1] [varchar](100) NULL,
	[Opcion2] [varchar](100) NULL,
	[Opcion3] [varchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[EliminarCaracteresEspeciales]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarCaracteresEspeciales] 
AS
  SET NOCOUNT ON;
DECLARE Titular_Cursor CURSOR FOR SELECT ID,Titular FROM Patentes WHERE Normalizado IS NULL AND FechaNorm IS NULL  
  OPEN Titular_Cursor;
  DECLARE @Titular varchar(200);
  DECLARE @Id INT;
  FETCH NEXT FROM Titular_Cursor
  INTO @Id,@Titular
  WHILE (@@FETCH_STATUS = 0)
     BEGIN
	   DECLARE @cadena VARCHAR(200) = @Titular;	    	   
	   SET @cadena = RTRIM(LTRIM(dbo.RemoveChars(@cadena)));
	   IF @cadena LIKE '% S R L' OR @cadena LIKE '% S A' OR @cadena LIKE '% S H' OR @cadena LIKE 'MERCEDESBENZ %' OR @cadena LIKE '% S C' OR @cadena LIKE '% S C L'
	   BEGIN	     
         SET @cadena = RTRIM(LTRIM(dbo.RecorrerTabla(@cadena)))  -- Para corregir los acronimos SRL y SA con espacios 
       END
	   ELSE IF @cadena LIKE '%SOCI%' OR @cadena LIKE '%COMPAÑIA%' OR @cadena LIKE '%TRANSPORTE%' OR @cadena LIKE '%SERVICIO%'
	   BEGIN
	      SET @cadena = RTRIM(LTRIM(dbo.RecorrerTablaSociedades(@cadena))) -- Para normalizar sociedades solo con los acronimos SRL,SA,SC,SE,SCA, ETC. 
	   END

	      BEGIN TRY
	         UPDATE Patentes SET Titular = RTRIM(LTRIM(@cadena)), FechaNorm = GETDATE() WHERE ID = @Id
          END TRY
		  BEGIN CATCH		  
		  DECLARE @MSG VARCHAR (200) = CONCAT('ERROR AL ACTUALIZAR EL ID : ',@Id,' DE LA TABLA PATENTES');		  
			 EXEC [DBLogs].[dbo].[RaiseError]
					@Name = N'SPLogs',
					@Mensaje = @MSG
		  END CATCH
	   --END
	   FETCH NEXT FROM Titular_Cursor
       INTO @Id,@Titular
     END  
  CLOSE Titular_Cursor;
  DEALLOCATE Titular_Cursor;
GO
/****** Object:  StoredProcedure [dbo].[Normalizar]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Espinosa Lucas
-- Create date: 18-11-2018
-- Description: CORRER PROCESOS PARA NORMALIZAR RAZON SOCIAL
-- =============================================
CREATE PROCEDURE [dbo].[Normalizar] 
AS
BEGIN	
	SET NOCOUNT ON;

    DECLARE	@value1 int
    EXEC @value1 = [dbo].[EliminarCaracteresEspeciales]
    IF @value1 = 0
	   PRINT 'EL PROCEDIENMIENTO ELIMINAR CARACTERES ESPECIALES PARA NORMALIZACION DE DATOS SE EJECUTO SATISFACTORIAMENTE'
	ELSE
	   PRINT 'OCURRIO UN ERROR AL EJECUTAR EL PROCEDIMIENTO ELIMINAR CARACTERES ESPECIALES PARA NORMALIZACION DE DATOS'
--------------------------------------------------------------------------------------------
    DECLARE	@value2 int
    EXEC @value2 = [dbo].[BuscarParecidos]
    IF @value2 = 0
	   PRINT 'EL PROCEDIENMIENTO BUSCAR PARECIDOS PARA NORMALIZACION DE DATOS SE EJECUTO SATISFACTORIAMENTE'
	ELSE
	   PRINT 'OCURRIO UN ERROR AL EJECUTAR EL PROCEDIMIENTO BUSCAR PARECIDOS PARA NORMALIZACION DE DATOS'
	   	
END
GO
/****** Object:  StoredProcedure [dbo].[RemoveFirstBlankSpace]    Script Date: 1/1/2019 20:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveFirstBlankSpace]
AS BEGIN
DECLARE CURTIT CURSOR FOR SELECT Id,Titular FROM Patentes WHERE Titular LIKE ' %'
OPEN CURTIT
DECLARE @ID INT;
DECLARE @TITULAR VARCHAR (200);
FETCH NEXT FROM CURTIT
INTO @ID,@TITULAR
WHILE (@@FETCH_STATUS = 0)
BEGIN
   SET @TITULAR=LTRIM(@TITULAR);   
   UPDATE Patentes SET Titular=LTRIM(@TITULAR) WHERE Id=@ID
   FETCH NEXT FROM CURTIT
   INTO @ID,@TITULAR   
END
CLOSE CURTIT
DEALLOCATE CURTIT
END
GO
USE [master]
GO
ALTER DATABASE [PatentesPru] SET  READ_WRITE 
GO
