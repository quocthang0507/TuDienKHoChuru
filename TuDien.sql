USE master 
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'TuDienKHo_Viet_Churu')
	DROP DATABASE [TuDienKHo_Viet_Churu]
GO

CREATE DATABASE [TuDienKHo_Viet_Churu] ON
(
	NAME = N'TuDien_data', 
	FILENAME = N'D:\Github\TuDienKHoChuru\tudien_data.mdf', 
	SIZE = 5MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 5MB
)
LOG ON 
(
	NAME = N'TuDien_log', 
	FILENAME = N'D:\Github\TuDienKHoChuru\tudien_log.ldf', 
	SIZE = 5MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 5MB
)
GO

USE [TuDienKHo_Viet_Churu]
GO

/**************************************
	BẢNG ACCOUNT
***************************************/

CREATE TABLE [dbo].[ACCOUNT] (
    [ID]          TINYINT        IDENTITY (1, 1) NOT NULL,
    [Fullname]    NVARCHAR (100) NOT NULL,
    [Username]    VARCHAR (50)   NOT NULL,
    [Password]    NVARCHAR (100) NOT NULL,
    [Role]        NVARCHAR (100) NOT NULL,
    [Email]       NVARCHAR (100) NULL,
    [PhoneNumber] NVARCHAR (10)  NULL,
    [Address]     NVARCHAR (200) NULL,
    [Active]      BIT            DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC)
);
GO

INSERT INTO ACCOUNT VALUES
	(N'La Quốc Thắng', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'Admin', '1610207@dlu.edu.vn', '0987610260', N'Võ Trường Toản, Phường 8, Đà Lạt, Lâm Đồng', 1)
INSERT INTO ACCOUNT VALUES
	(N'Cộng tác viên', 'collaborator', '53adf83d9f7b4dd136fee848946a5ea6d28640406aa260d1bb6adb79dccb58ee', 'Collaborator', '', '', N'Đại học Đà Lạt, Phù Đổng Thiên Vương, Phường 8, Đà Lạt, Lâm Đồng', 1)
GO

CREATE PROC proc_GET_ACCOUNTS
AS
	SELECT * FROM ACCOUNT
GO

CREATE PROC proc_INSERT_ACCOUNT
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

CREATE PROC proc_UPDATE_ACCOUNT
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

CREATE PROC proc_DEACTIVATE_ACCOUNT
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 0
	WHERE Username = @Username
GO

CREATE PROC proc_ACTIVATE_ACCOUNT
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 1
	WHERE Username = @Username
GO

/**************************************
	BẢNG DICT_TYPE
***************************************/

CREATE TABLE [dbo].[DICT_TYPE] (
    [DictType]    TINYINT        IDENTITY (1, 1) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([DictType] ASC)
);
GO

INSERT INTO DICT_TYPE VALUES (N'Từ điển K''Ho - Việt')
INSERT INTO DICT_TYPE VALUES (N'Từ điển Việt - K''Ho')
INSERT INTO DICT_TYPE VALUES (N'Từ điển Churu - Việt')
INSERT INTO DICT_TYPE VALUES (N'Từ điển Việt - Churu')
GO

CREATE PROC proc_GET_DICT_TYPES
AS
	SELECT * FROM DICT_TYPE
GO

SET DATEFORMAT DMY;
GO

/**************************************
	BẢNG WORD_TYPE
***************************************/

CREATE TABLE [dbo].[WORD_TYPE] (
    [WordType]    VARCHAR (10)   NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([WordType] ASC)
);
GO

INSERT INTO WORD_TYPE VALUES ('Noun', N'Danh từ')
INSERT INTO WORD_TYPE VALUES ('Verb', N'Động từ')
INSERT INTO WORD_TYPE VALUES ('Adjective', N'Tính từ')
INSERT INTO WORD_TYPE VALUES ('Adverb', N'Trạng từ')
INSERT INTO WORD_TYPE VALUES ('Pronoun', N'Đại từ')
INSERT INTO WORD_TYPE VALUES ('Prep', N'Giới từ')
INSERT INTO WORD_TYPE VALUES ('Others', N'Khác')
GO

CREATE PROC proc_GET_WORD_TYPES
AS
	SELECT * FROM WORD_TYPE ORDER BY [Description]
GO

/**************************************
	BẢNG WORD
***************************************/

CREATE TABLE [dbo].[WORD] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [Word]        NVARCHAR (MAX) NOT NULL,
    [DictType]    TINYINT        NULL,
    [WordType]    VARCHAR (10)   DEFAULT ('Others') NULL,
    [PronunPath]  NVARCHAR (MAX) NULL,
    [ImgPath]     NVARCHAR (MAX) NULL,
    [AddedDate]   DATETIME       NULL,
    [UpdatedDate] DATETIME       NULL,
    [Creator]     VARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([DictType]) REFERENCES [dbo].[DICT_TYPE] ([DictType]),
    FOREIGN KEY ([WordType]) REFERENCES [dbo].[WORD_TYPE] ([WordType]),
    FOREIGN KEY ([Creator]) REFERENCES [dbo].[ACCOUNT] ([Username])
);
GO

CREATE PROC proc_INSERT_UPDATE_WORD
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
				SET Word = @Word, WordType = @WordType, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE IF @PronunPath IS NULL
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE IF @ImgPath IS NULL
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronunPath = @PronunPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
			ELSE
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronunPath = @PronunPath, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID
			END
		END
	ELSE
		BEGIN
			IF (@PronunPath IS NULL) AND (@ImgPath IS NULL)
				INSERT INTO WORD (Word, DictType, WordType, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, GETDATE(), GETDATE(), @Creator)
			ELSE IF @PronunPath IS NULL
				INSERT INTO WORD (Word, DictType, WordType, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @ImgPath, GETDATE(), GETDATE(), @Creator)
			ELSE IF @ImgPath IS NULL
				INSERT INTO WORD (Word, DictType, WordType, PronunPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, GETDATE(), GETDATE(), @Creator)
			ELSE
				INSERT INTO WORD (Word, DictType, WordType, PronunPath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronunPath, @ImgPath, GETDATE(), GETDATE(), @Creator)
		END
GO

CREATE PROC proc_DELETE_WORD
	@ID INT,
	@OutputID INT OUTPUT
AS
BEGIN
	DECLARE @DictTypeID INT
	SET @DictTypeID = (SELECT DictType FROM WORD WHERE ID = @ID);
	DELETE FROM WORD WHERE ID = @ID;
	SET @OutputID = (SELECT TOP 1 ID FROM WORD WHERE ID < @ID AND DictType = @DictTypeID ORDER BY ID DESC)
END
GO

EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'à wanh', 1, 'Verb', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'ada', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'ada prum', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'ada siam', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'adàr', 1, 'Adjective', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'adát', 1, 'Adjective', '', '', 'admin';

EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'a', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'á', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'à', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'ả', 2, 'Pronoun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD NULL, N'ạ', 2, 'Others', '', '', 'admin';
GO

CREATE PROC proc_GET_WORDS
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT * FROM WORD WHERE DictType = @DictType
	ORDER BY Word OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO

CREATE PROC proc_GET_PAGE_NUMBERS
	@DictType TINYINT,
	@RowsOfPage INT
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

/**************************************
	BẢNG MEANING
***************************************/

CREATE TABLE [dbo].[MEANING] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [WordID]  INT            NULL,
    [Meaning] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([WordID]) REFERENCES [dbo].[WORD] ([ID])
);
GO

CREATE PROC proc_INSERT_MEANING
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning)
GO

CREATE PROC proc_GET_MEANINGS
	@WordID INT
AS
	SELECT * FROM MEANING WHERE WordID = @WordID;
GO

CREATE PROC proc_DELETE_ALL_MEANINGS
	@WordID INT
AS
	DELETE FROM MEANING WHERE WordID = @WordID
GO

/**************************************
	BẢNG EXAMPLE
***************************************/

CREATE TABLE [dbo].[EXAMPLE] (
    [MeaningID]  INT            NULL,
    [Example]    NVARCHAR (MAX) NOT NULL,
    [Meaning]    NVARCHAR (MAX) NOT NULL,
    [PronunPath] NVARCHAR (MAX) NULL,
    FOREIGN KEY ([MeaningID]) REFERENCES [dbo].[MEANING] ([ID])
);
GO

/**************************************
	BẢNG BILINGUAL_PASSAGE
***************************************/

CREATE TABLE [dbo].[BILINGUAL_PASSAGE] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [DictType]    TINYINT        NULL,
    [Source]      NVARCHAR (MAX) NOT NULL,
    [Destination] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([DictType]) REFERENCES [dbo].[DICT_TYPE] ([DictType])
);
GO