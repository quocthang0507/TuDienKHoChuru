USE [master]
GO
/****** Object:  Database [TuDienKHo_Viet_Churu]    Script Date: 7/4/2021 10:22:20 PM ******/
CREATE DATABASE [TuDienKHo_Viet_Churu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TuDien_data', FILENAME = N'D:\Github\TuDienKHoChuru\tudien_data.mdf' , SIZE = 8192KB , MAXSIZE = 2097152KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'TuDien_log', FILENAME = N'D:\Github\TuDienKHoChuru\tudien_log.ldf' , SIZE = 5120KB , MAXSIZE = 2097152KB , FILEGROWTH = 5120KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TuDienKHo_Viet_Churu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ARITHABORT OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET  MULTI_USER 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET QUERY_STORE = OFF
GO
USE [TuDienKHo_Viet_Churu]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](100) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](10) NULL,
	[Address] [nvarchar](200) NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BILINGUAL_PASSAGE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILINGUAL_PASSAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DictType] [tinyint] NOT NULL,
	[PassageType] [varchar](10) NOT NULL,
	[Source] [nvarchar](max) NULL,
	[Destination] [nvarchar](max) NULL,
	[AddedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[Creator] [varchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DICT_TYPE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DICT_TYPE](
	[DictType] [tinyint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DictType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMPLE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMPLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MeaningID] [int] NOT NULL,
	[Example] [nvarchar](max) NOT NULL,
	[Meaning] [nvarchar](max) NOT NULL,
	[PronunPath] [nvarchar](max) NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEANING]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEANING](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WordID] [int] NULL,
	[Meaning] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PASSAGE_TYPE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASSAGE_TYPE](
	[PassageType] [varchar](10) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PassageType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WORD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Word] [nvarchar](max) NOT NULL,
	[DictType] [tinyint] NULL,
	[WordType] [varchar](10) NULL,
	[PronunPath] [nvarchar](max) NULL,
	[ImgPath] [nvarchar](max) NULL,
	[AddedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[Creator] [varchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORD_TYPE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WORD_TYPE](
	[WordType] [varchar](10) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WordType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ACCOUNT] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] ADD  DEFAULT ('OTHERS') FOR [PassageType]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[EXAMPLE] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[MEANING] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[WORD] ADD  DEFAULT ('Others') FOR [WordType]
GO
ALTER TABLE [dbo].[WORD] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE]  WITH CHECK ADD FOREIGN KEY([Creator])
REFERENCES [dbo].[ACCOUNT] ([Username])
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE]  WITH CHECK ADD FOREIGN KEY([DictType])
REFERENCES [dbo].[DICT_TYPE] ([DictType])
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE]  WITH CHECK ADD FOREIGN KEY([PassageType])
REFERENCES [dbo].[PASSAGE_TYPE] ([PassageType])
GO
ALTER TABLE [dbo].[EXAMPLE]  WITH CHECK ADD FOREIGN KEY([MeaningID])
REFERENCES [dbo].[MEANING] ([ID])
GO
ALTER TABLE [dbo].[MEANING]  WITH CHECK ADD FOREIGN KEY([WordID])
REFERENCES [dbo].[WORD] ([ID])
GO
ALTER TABLE [dbo].[WORD]  WITH CHECK ADD FOREIGN KEY([Creator])
REFERENCES [dbo].[ACCOUNT] ([Username])
GO
ALTER TABLE [dbo].[WORD]  WITH CHECK ADD FOREIGN KEY([DictType])
REFERENCES [dbo].[DICT_TYPE] ([DictType])
GO
ALTER TABLE [dbo].[WORD]  WITH CHECK ADD FOREIGN KEY([WordType])
REFERENCES [dbo].[WORD_TYPE] ([WordType])
GO
/****** Object:  StoredProcedure [dbo].[proc_ACTIVATE_ACCOUNT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_ACTIVATE_ACCOUNT]
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 1
	WHERE Username = @Username
GO
/****** Object:  StoredProcedure [dbo].[proc_DEACTIVATE_ACCOUNT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_DEACTIVATE_ACCOUNT]
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 0
	WHERE Username = @Username
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_MEANINGS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_ALL_MEANINGS]
	@WordID INT
AS
	--DELETE FROM MEANING WHERE WordID = @WordID
	UPDATE MEANING SET Deleted = 1 	WHERE WordID = @WordID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_EXAMPLE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_EXAMPLE]
	@ID INT
AS
	--DELETE FROM EXAMPLE WHERE ID = @ID;
	UPDATE EXAMPLE SET Deleted = 1 WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_PASSAGE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_DELETE_PASSAGE]
	@ID INT
AS
	UPDATE BILINGUAL_PASSAGE SET Deleted = 1 WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_WORD]
	@ID INT,
	@OutputID INT OUTPUT
AS
BEGIN
	DECLARE @DictTypeID INT
	SET @DictTypeID = (SELECT DictType FROM WORD WHERE ID = @ID);
	--DELETE FROM WORD WHERE ID = @ID;
	UPDATE WORD SET Deleted = 1 WHERE ID = @ID;
	SET @OutputID = (SELECT TOP 1 ID FROM WORD WHERE ID < @ID AND DictType = @DictTypeID AND Deleted = 0 ORDER BY ID DESC)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_ACCOUNTS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_ACCOUNTS]
AS
	SELECT * FROM ACCOUNT
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_DICT_TYPES]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_DICT_TYPES]
AS
	SELECT * FROM DICT_TYPE
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLE_PAGE_NUMBERS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_EXAMPLE_PAGE_NUMBERS]
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage)
	END
	FROM EXAMPLE E, MEANING M, WORD W
	WHERE E.MeaningID = M.ID AND W.ID = M.WordID AND DictType = @DictType AND E.Deleted = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_EXAMPLES]
	@MeaningID INT
AS
	SELECT * FROM EXAMPLE WHERE MeaningID = @MeaningID AND Deleted = 0 ORDER BY EXAMPLE;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES_PAGINATION]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_EXAMPLES_PAGINATION]
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT E.ID, E.MeaningID, EXAMPLE, E.Meaning, E.PronunPath FROM EXAMPLE E, MEANING M, WORD W
	WHERE E.MeaningID = M.ID AND W.ID = M.WordID AND DictType = @DictType AND E.Deleted = 0
	ORDER BY ID OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_MAX_ID_WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_MAX_ID_WORD]
	@MAX INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT TOP(1) ID FROM WORD ORDER BY ID DESC)
		SET @MAX = (SELECT TOP(1) ID FROM WORD ORDER BY ID DESC)
	ELSE
		SET @MAX = 0
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_MEANINGS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_MEANINGS]
	@WordID INT
AS
	SELECT * FROM MEANING WHERE WordID = @WordID AND Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_PASSAGE]
	@ID INT
AS
	SELECT * FROM BILINGUAL_PASSAGE WHERE ID = @ID AND Deleted = 0
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE_TYPES]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_PASSAGE_TYPES]
AS
	SELECT * FROM PASSAGE_TYPE ORDER BY Description ASC;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGE_NUMBERS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_PASSAGES_PAGE_NUMBERS]
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage)
	END
	FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGINATION]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_PASSAGES_PAGINATION]
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT * FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0
	ORDER BY ID OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_PASSAGES]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_TOTAL_PASSAGES]
	@DictType TINYINT,
	@Total INT OUTPUT
AS
	SET @Total = (SELECT COUNT(*) FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_WORDS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_TOTAL_WORDS]
	@DictType TINYINT,
	@Total INT OUTPUT
AS
	SET @Total = (SELECT COUNT(*) FROM WORD WHERE DictType = @DictType AND Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_PAGE_NUMBERS]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_WORD_PAGE_NUMBERS]
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage)
	END
	FROM WORD WHERE WORD.DictType = @DictType AND Deleted = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_TYPES]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_WORD_TYPES]
AS
	SELECT * FROM WORD_TYPE ORDER BY [Description]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORDS_PAGINATION]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_WORDS_PAGINATION]
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT * FROM WORD WHERE DictType = @DictType AND Deleted = 0
	ORDER BY Word OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_ACCOUNT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_ACCOUNT]
	@Fullname NVARCHAR(100),
	@Username VARCHAR(50),
	@Password NVARCHAR(100),
	@Role NVARCHAR(100),
	@Email NVARCHAR(100),
	@PhoneNumber NVARCHAR(10),
	@Address NVARCHAR(200)
AS
	IF NOT EXISTS (SELECT * FROM ACCOUNT WHERE [Username] = @Username)
		INSERT INTO ACCOUNT VALUES (@Fullname, @Username, @Password, @Role, @Email, @PhoneNumber, @Address, 1);
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_EXAMPLE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_INSERT_EXAMPLE]
	@MeaningID INT,
	@Example NVARCHAR(MAX),
	@Meaning NVARCHAR(MAX),
	@PronunPath NVARCHAR(MAX)
AS
	INSERT INTO EXAMPLE VALUES (@MeaningID, @Example, @Meaning, @PronunPath, 0);
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_INSERT_MEANING]
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning, 0)
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING_OUTPUT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_MEANING_OUTPUT]
-- ALTER PROC proc_INSERT_MEANING_OUTPUT
	@ID INT OUTPUT,
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning, 0)
	SET @ID = @@IDENTITY
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_PASSAGE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_PASSAGE]
	@DictType TINYINT,
	@PassageType VARCHAR(10),
	@Source NVARCHAR(MAX),
	@Destination NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	INSERT INTO BILINGUAL_PASSAGE (DictType, PassageType, Source, Destination, AddedDate, UpdatedDate, Creator, Deleted)
	VALUES (@DictType, @PassageType, @Source, @Destination, GETDATE(), GETDATE(), @Creator, 0);
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_WORD]
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronunPath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF NOT EXISTS (SELECT * FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
		INSERT INTO WORD (Word, DictType, WordType, PronunPath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, @ImgPath, GETDATE(), GETDATE(), @Creator);
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_OUTPUT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_WORD_OUTPUT]
	@ID INT OUTPUT,
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronunPath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF EXISTS (SELECT * FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
		SET @ID = (SELECT TOP(1) ID FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
	ELSE
	BEGIN
		INSERT INTO WORD (Word, DictType, WordType, PronunPath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, @ImgPath, GETDATE(), GETDATE(), @Creator);
		SET @ID = @@IDENTITY
	END
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_TEST]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_WORD_TEST]
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronunPath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
BEGIN
	DECLARE @KQ BIT
	BEGIN TRANSACTION INSERT_WORD
		BEGIN TRY
			EXEC proc_INSERT_WORD @Word, @DictType, @WordType, @PronunPath, @ImgPath, @Creator
		END TRY
		BEGIN CATCH
		END CATCH
	ROLLBACK TRANSACTION INSERT_WORD
END
GO
/****** Object:  StoredProcedure [dbo].[proc_RESET_ALL]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_RESET_ALL]
AS
	DELETE FROM [EXAMPLE]
	DELETE FROM [MEANING]
	DELETE FROM [WORD]
	DBCC CHECKIDENT ('[EXAMPLE]', RESEED, 0);
	DBCC CHECKIDENT ('[MEANING]', RESEED, 0);
	DBCC CHECKIDENT ('[WORD]', RESEED, 0);
GO
/****** Object:  StoredProcedure [dbo].[proc_RESET_IDENTITY_WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_RESET_IDENTITY_WORD]
	@ID INT
AS
	DBCC CHECKIDENT('[WORD]', RESEED, @ID)
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_ACCOUNT]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_UPDATE_ACCOUNT]
	@ID TINYINT,
	@Fullname NVARCHAR(100),
	@Password NVARCHAR(100),
	@Role NVARCHAR(100),
	@Email NVARCHAR(100),
	@PhoneNumber NVARCHAR(10),
	@Address NVARCHAR(200)
AS
	UPDATE ACCOUNT
	SET 
		[Fullname] = @Fullname, [Password] = @Password, [Role] = @Role, 
		[Email] = @Email, [PhoneNumber] = @PhoneNumber, [Address] = @Address
	WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_AUDIO_EXAMPLE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_UPDATE_AUDIO_EXAMPLE]
	@ID INT,
	@PronunPath NVARCHAR(MAX)
AS
	UPDATE EXAMPLE
	SET PronunPath = @PronunPath
	WHERE ID = @ID AND Deleted = 0
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_PASSAGE]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_UPDATE_PASSAGE]
	@ID INT,
	@PassageType VARCHAR(10),
	@Source NVARCHAR(MAX),
	@Destination NVARCHAR(MAX)
AS
	UPDATE BILINGUAL_PASSAGE
	SET PassageType = @PassageType, Source = @Source, Destination = @Destination, UpdatedDate = GETDATE()
	WHERE ID = @ID AND Deleted = 0
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_WORD]    Script Date: 7/4/2021 10:22:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_UPDATE_WORD]
	@ID INT,
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronunPath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF EXISTS (SELECT * FROM WORD WHERE ID = @ID)
		-- Chỉ cập nhật các thông tin thay đổi thôi
		BEGIN
			IF (@PronunPath IS NULL) AND (@ImgPath IS NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE IF (@PronunPath IS NULL) AND (@ImgPath IS NOT NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE IF (@ImgPath IS NULL) AND (@PronunPath IS NOT NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronunPath = @PronunPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronunPath = @PronunPath, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
		END
GO
USE [master]
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET  READ_WRITE 
GO
