USE [master]
GO
/****** Object:  Database [TuDienKHo_Viet_Churu]    Script Date: 6/17/2021 9:56:54 PM ******/
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
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 6/17/2021 9:56:54 PM ******/
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
	[Address] [nvarchar](200) NOT NULL,
	[Active] [bit] NULL,
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
/****** Object:  Table [dbo].[BILINGUAL_PASSAGE]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILINGUAL_PASSAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DictType] [tinyint] NULL,
	[Source] [nvarchar](max) NOT NULL,
	[Destination] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DICT_TYPE]    Script Date: 6/17/2021 9:56:54 PM ******/
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
/****** Object:  Table [dbo].[EXAMPLE]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMPLE](
	[MeaningID] [int] NULL,
	[Example] [nvarchar](max) NOT NULL,
	[Meaning] [nvarchar](max) NOT NULL,
	[PronunPath] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEANING]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEANING](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WordID] [int] NULL,
	[Meaning] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORD]    Script Date: 6/17/2021 9:56:54 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORD_TYPE]    Script Date: 6/17/2021 9:56:54 PM ******/
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
ALTER TABLE [dbo].[WORD] ADD  DEFAULT ('Others') FOR [WordType]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE]  WITH CHECK ADD FOREIGN KEY([DictType])
REFERENCES [dbo].[DICT_TYPE] ([DictType])
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
/****** Object:  StoredProcedure [dbo].[proc_ACTIVATE_ACCOUNT]    Script Date: 6/17/2021 9:56:54 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DEACTIVATE_ACCOUNT]    Script Date: 6/17/2021 9:56:54 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_MEANINGS]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_ALL_MEANINGS]
	@WordID INT
AS
	DELETE FROM MEANING WHERE WordID = @WordID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_WORD]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_WORD]
	@ID INT
AS
	DELETE FROM WORD WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_ACCOUNTS]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_ACCOUNTS]
AS
SELECT * FROM ACCOUNT
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_DICT_TYPES]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_DICT_TYPES]
AS
SELECT * FROM DICT_TYPE
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_MEANINGS]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_MEANINGS]
	@WordID INT
AS
	SELECT * FROM MEANING WHERE WordID = @WordID;

/*
	Bảng này lưu (các) ví dụ của từ
*/
CREATE TABLE EXAMPLE
(
	[MeaningID] INT REFERENCES MEANING(ID),
	[Example] NVARCHAR(MAX) NOT NULL,
	[Meaning] NVARCHAR(MAX) NOT NULL,
	[PronunPath] NVARCHAR(MAX) NULL
);
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PAGE_NUMBERS]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_PAGE_NUMBERS]
(
	@DictType TINYINT,
	@RowsOfPage INT
)
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CEILING(COUNT(*) / @RowsOfPage)
	END
	FROM WORD WHERE WORD.DictType = @DictType;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_TYPES]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_WORD_TYPES]
AS
SELECT * FROM WORD_TYPE ORDER BY [Description]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORDS]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_WORDS]
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
SELECT *
FROM WORD
WHERE DictType = @DictType
ORDER BY Word
	OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_ACCOUNT]    Script Date: 6/17/2021 9:56:54 PM ******/
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
INSERT INTO ACCOUNT VALUES (
	@Fullname, 
	@Username, 
	@Password, 
	@Role, 
	@Email,
	@PhoneNumber,
	@Address,
	1
)
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_INSERT_MEANING]
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning)
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_UPDATE_WORD]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_INSERT_UPDATE_WORD]
	@ID INT,
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronunPath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF EXISTS (SELECT * FROM WORD WHERE ID = @ID)
		BEGIN
			IF (@PronunPath IS NULL) AND (@ImgPath IS NULL)
			BEGIN
				UPDATE WORD
				SET 
					Word = @Word,
					WordType = @WordType,
					Creator = @Creator,
					UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE IF @PronunPath IS NULL
			BEGIN
				UPDATE WORD
				SET 
					Word = @Word,
					WordType = @WordType, 
					ImgPath = @ImgPath,
					Creator = @Creator,
					UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE IF @ImgPath IS NULL
			BEGIN
				UPDATE WORD
				SET 
					Word = @Word,
					WordType = @WordType, 
					PronunPath = @PronunPath,
					Creator = @Creator,
					UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE
			BEGIN
				UPDATE WORD
				SET 
					Word = @Word,
					WordType = @WordType, 
					PronunPath = @PronunPath,
					ImgPath = @ImgPath,
					Creator = @Creator,
					UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
		END
	ELSE
		IF (@PronunPath IS NULL) AND (@ImgPath IS NULL)
			INSERT INTO WORD (Word, DictType, WordType, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, GETDATE(), GETDATE(), @Creator)
		ELSE IF @PronunPath IS NULL
			INSERT INTO WORD (Word, DictType, WordType, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @ImgPath, GETDATE(), GETDATE(), @Creator)
		ELSE IF @ImgPath IS NULL
			INSERT INTO WORD (Word, DictType, WordType, PronunPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, GETDATE(), GETDATE(), @Creator)
		ELSE
			INSERT INTO WORD (Word, DictType, WordType, PronunPath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, @ImgPath, GETDATE(), GETDATE(), @Creator)
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_ACCOUNT]    Script Date: 6/17/2021 9:56:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_UPDATE_ACCOUNT]
	@ID TINYINT,
	@Fullname NVARCHAR(100),
	@Username VARCHAR(50),
	@Password NVARCHAR(100),
	@Role NVARCHAR(100),
	@Email NVARCHAR(100),
	@PhoneNumber NVARCHAR(10),
	@Address NVARCHAR(200)
AS
UPDATE ACCOUNT
	SET 
		[Fullname] = @Fullname, 
		[Username] = @Username, 
		[Password] = @Password, 
		[Role] = @Role, 
		[Email] = @Email,
		[PhoneNumber] = @PhoneNumber,
		[Address] = @Address
	WHERE ID = @ID
GO
USE [master]
GO
ALTER DATABASE [TuDienKHo_Viet_Churu] SET  READ_WRITE 
GO
