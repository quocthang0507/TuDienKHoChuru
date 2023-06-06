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

--DROP TABLE [dbo].[ACCOUNT]
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
-- DROP PROC proc_GET_ACCOUNTS
AS
	SELECT * FROM ACCOUNT
GO

CREATE PROC proc_INSERT_ACCOUNT
-- DROP PROC proc_INSERT_ACCOUNT
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
-- DROP PROC proc_UPDATE_ACCOUNT
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
-- DROP PROC proc_DEACTIVATE_ACCOUNT
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 0
	WHERE Username = @Username
GO

CREATE PROC proc_ACTIVATE_ACCOUNT
-- DROP PROC proc_ACTIVATE_ACCOUNT
	@Username VARCHAR(50)
AS
	UPDATE ACCOUNT
	SET Active = 1
	WHERE Username = @Username
GO

/**************************************
	BẢNG DICT_TYPE
***************************************/

--DROP TABLE [dbo].[DICT_TYPE]
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

--DELETE FROM [DICT_TYPE]
--DBCC CHECKIDENT ('[DICT_TYPE]', RESEED, 0);

CREATE PROC proc_GET_DICT_TYPES
-- DROP PROC proc_GET_DICT_TYPES
AS
	SELECT * FROM DICT_TYPE
GO

SET DATEFORMAT DMY;
GO

/**************************************
	BẢNG WORD_TYPE
***************************************/

--DROP TABLE [dbo].[WORD_TYPE]
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
-- DROP PROC proc_GET_WORD_TYPES
AS
	SELECT * FROM WORD_TYPE ORDER BY [Description]
GO

/**************************************
	BẢNG WORD
***************************************/

--DROP TABLE [dbo].[WORD]
CREATE TABLE [dbo].[WORD] (
    [ID]			INT            IDENTITY (1, 1) NOT NULL,
    [Word]			NVARCHAR (MAX) NOT NULL,
    [DictType]		TINYINT        NULL,
    [WordType]		VARCHAR (10)   DEFAULT ('Others') NULL,
    [PronouncePath]	NVARCHAR (MAX) NULL,
    [ImgPath]		NVARCHAR (MAX) NULL,
    [AddedDate]		DATETIME       NULL,
    [UpdatedDate]	DATETIME       NULL,
    [Creator]		VARCHAR (50)   NOT NULL,
	[Deleted]		BIT			 NOT NULL DEFAULT 0,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([DictType]) REFERENCES [dbo].[DICT_TYPE] ([DictType]),
    FOREIGN KEY ([WordType]) REFERENCES [dbo].[WORD_TYPE] ([WordType]),
    FOREIGN KEY ([Creator]) REFERENCES [dbo].[ACCOUNT] ([Username])
);
GO

--DELETE FROM [WORD]
--DBCC CHECKIDENT ('[WORD]', RESEED, 0);

CREATE PROC proc_INSERT_WORD
-- ALTER PROC proc_INSERT_WORD
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronouncePath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF NOT EXISTS (SELECT * FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
		INSERT INTO WORD (Word, DictType, WordType, PronouncePath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronouncePath, @ImgPath, GETDATE(), GETDATE(), @Creator);
GO

CREATE PROC proc_INSERT_WORD_OUTPUT
-- ALTER PROC proc_INSERT_WORD_OUTPUT
	@ID INT OUTPUT,
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronouncePath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF EXISTS (SELECT * FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
		SET @ID = (SELECT TOP(1) ID FROM WORD WHERE [Word] = @Word AND [DictType] = @DictType AND [WordType] = @WordType AND [Deleted] = 0)
	ELSE
	BEGIN
		INSERT INTO WORD (Word, DictType, WordType, PronouncePath, ImgPath, AddedDate, UpdatedDate, Creator) VALUES (@Word, @DictType, @WordType, @PronouncePath, @ImgPath, GETDATE(), GETDATE(), @Creator);
		SET @ID = @@IDENTITY
	END
GO

CREATE PROC proc_GET_MAX_ID_WORD
-- ALTER PROC proc_GET_MAX_ID_WORD
	@MAX INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT TOP(1) ID FROM WORD ORDER BY ID DESC)
		SET @MAX = (SELECT TOP(1) ID FROM WORD ORDER BY ID DESC)
	ELSE
		SET @MAX = 0
END
GO

CREATE PROC proc_INSERT_WORD_TEST
-- ALTER PROC proc_INSERT_WORD_TEST
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronouncePath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
BEGIN
	DECLARE @KQ BIT
	BEGIN TRANSACTION INSERT_WORD
		BEGIN TRY
			EXEC proc_INSERT_WORD @Word, @DictType, @WordType, @PronouncePath, @ImgPath, @Creator
		END TRY
		BEGIN CATCH
		END CATCH
	ROLLBACK TRANSACTION INSERT_WORD
END
GO

CREATE PROC proc_UPDATE_WORD
-- ALTER PROC proc_UPDATE_WORD
	@ID INT,
	@Word NVARCHAR(MAX),
	@DictType TINYINT,
	@WordType VARCHAR(10),
	@PronouncePath NVARCHAR(MAX),
	@ImgPath NVARCHAR(MAX),
	@Creator VARCHAR(50)
AS
	IF EXISTS (SELECT * FROM WORD WHERE ID = @ID)
		--Chỉ cập nhật các thông tin thay đổi thôi
		BEGIN
			IF (@PronouncePath IS NULL) AND (@ImgPath IS NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE IF (@PronouncePath IS NULL) AND (@ImgPath IS NOT NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE IF (@ImgPath IS NULL) AND (@PronouncePath IS NOT NULL)
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronouncePath = @PronouncePath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
			ELSE
			BEGIN
				UPDATE WORD
				SET Word = @Word, WordType = @WordType, PronouncePath = @PronouncePath, ImgPath = @ImgPath, Creator = @Creator, UpdatedDate = GETDATE()
				WHERE ID = @ID AND Deleted = 0
			END
		END
GO

/*
EXEC dbo.proc_INSERT_WORD N'à wanh', 1, 'Verb', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'ada', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'ada prum', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'ada siam', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'adàr', 1, 'Adjective', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'adát', 1, 'Adjective', '', '', 'admin';

EXEC dbo.proc_INSERT_WORD N'a', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'á', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'à', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'ả', 2, 'Pronoun', '', '', 'admin';
EXEC dbo.proc_INSERT_WORD N'ạ', 2, 'Others', '', '', 'admin';
*/
GO

CREATE PROC proc_GET_TOTAL_WORDS
-- ALTER PROC proc_GET_TOTAL_WORDS
	@DictType TINYINT,
	@Total INT OUTPUT
AS
	SET @Total = (SELECT COUNT(*) FROM WORD WHERE DictType = @DictType AND Deleted = 0)
GO

CREATE PROC proc_GET_WORDS_PAGINATION
-- ALTER PROC proc_GET_WORDS_PAGINATION
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT * FROM WORD WHERE DictType = @DictType AND Deleted = 0
	ORDER BY Word OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO

-- EXEC proc_GET_WORDS_PAGINATION 2, 1, 10

CREATE PROC proc_GET_WORD_PAGE_NUMBERS
-- ALTER PROC proc_GET_WORD_PAGE_NUMBERS
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CONVERT(INT, CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage))
	END
	FROM WORD WHERE WORD.DictType = @DictType AND Deleted = 0;
END
GO

-- EXEC proc_GET_WORD_PAGE_NUMBERS 1, 10

/**************************************
	BẢNG MEANING
***************************************/

--DROP TABLE [dbo].[MEANING]
CREATE TABLE [dbo].[MEANING] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [WordID]  INT            NULL,
    [Meaning] NVARCHAR (MAX) NOT NULL,
	[Deleted] BIT			 NOT NULL DEFAULT 0,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([WordID]) REFERENCES [dbo].[WORD] ([ID])
);
GO

--DELETE FROM [MEANING]
--DBCC CHECKIDENT ('[MEANING]', RESEED, 0);

CREATE PROC proc_INSERT_MEANING
-- ALTER PROC proc_INSERT_MEANING
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning, 0)
GO

CREATE PROC proc_INSERT_MEANING_OUTPUT
-- ALTER PROC proc_INSERT_MEANING_OUTPUT
	@ID INT OUTPUT,
	@WordID INT,
	@Meaning NVARCHAR(MAX)
AS
	INSERT INTO MEANING VALUES (@WordID, @Meaning, 0)
	SET @ID = @@IDENTITY
GO


CREATE PROC proc_GET_MEANINGS
-- ALTER PROC proc_GET_MEANINGS
	@WordID INT
AS
	SELECT * FROM MEANING WHERE WordID = @WordID AND Deleted = 0;
GO

CREATE PROC proc_DELETE_MEANING
-- ALTER PROC proc_DELETE_MEANING
	@ID INT
AS
	--DELETE FROM MEANING WHERE ID = @ID
	UPDATE MEANING SET Deleted = 1 	WHERE ID = @ID
GO

CREATE PROC proc_DELETE_ALL_MEANINGS
-- ALTER PROC proc_DELETE_ALL_MEANINGS
	@WordID INT
AS
	--DELETE FROM MEANING WHERE WordID = @WordID
	UPDATE MEANING SET Deleted = 1 	WHERE WordID = @WordID
GO

/**************************************
	BẢNG EXAMPLE
***************************************/

--DROP TABLE [dbo].[EXAMPLE]
CREATE TABLE [dbo].[EXAMPLE] (
    [ID]			INT            IDENTITY (1, 1) NOT NULL,
    [MeaningID]		INT            NOT NULL,
    [Example]		NVARCHAR (MAX) NOT NULL,
    [Meaning]		NVARCHAR (MAX) NOT NULL,
    [PronouncePath] NVARCHAR (MAX) NULL,
	[Deleted]		BIT			NOT NULL DEFAULT 0,
    FOREIGN KEY ([MeaningID]) REFERENCES [dbo].[MEANING] ([ID]),
	PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

--DELETE FROM [EXAMPLE]
--DBCC CHECKIDENT ('[EXAMPLE]', RESEED, 0);

CREATE PROC proc_GET_EXAMPLES
-- ALTER PROC proc_GET_EXAMPLES
	@MeaningID INT
AS
	SELECT * FROM EXAMPLE WHERE MeaningID = @MeaningID AND Deleted = 0 ORDER BY EXAMPLE;
GO

CREATE PROC proc_INSERT_EXAMPLE
-- ALTER PROC proc_INSERT_EXAMPLE
	@MeaningID INT,
	@Example NVARCHAR(MAX),
	@Meaning NVARCHAR(MAX),
	@PronouncePath NVARCHAR(MAX)
AS
	INSERT INTO EXAMPLE VALUES (@MeaningID, @Example, @Meaning, @PronouncePath, 0);
GO

CREATE PROC proc_UPDATE_AUDIO_EXAMPLE
-- ALTER PROC proc_UPDATE_AUDIO_EXAMPLE
	@ID INT,
	@PronouncePath NVARCHAR(MAX)
AS
	UPDATE EXAMPLE
	SET PronouncePath = @PronouncePath
	WHERE ID = @ID AND Deleted = 0
GO

CREATE PROC proc_DELETE_EXAMPLE
-- ALTER PROC proc_DELETE_EXAMPLE
	@ID INT
AS
	--DELETE FROM EXAMPLE WHERE ID = @ID;
	UPDATE EXAMPLE SET Deleted = 1 WHERE ID = @ID
GO

CREATE PROC proc_DELETE_ALL_EXAMPLES
-- ALTER PROC proc_DELETE_ALL_EXAMPLES
	@WordID INT
AS
	UPDATE EXAMPLE SET Deleted = 1 
	WHERE ID IN (SELECT E.ID FROM WORD W, MEANING M, EXAMPLE E WHERE W.ID = M.WordID AND M.ID = E.MeaningID AND W.ID = @WordID)
GO

CREATE PROC proc_GET_EXAMPLES_PAGINATION
-- ALTER PROC proc_GET_EXAMPLES_PAGINATION
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT E.ID, E.MeaningID, EXAMPLE, E.Meaning, E.PronouncePath FROM EXAMPLE E, MEANING M, WORD W
	WHERE E.MeaningID = M.ID AND W.ID = M.WordID AND DictType = @DictType AND E.Deleted = 0
	ORDER BY ID OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO

CREATE PROC proc_GET_EXAMPLE_PAGE_NUMBERS
-- ALTER PROC proc_GET_EXAMPLE_PAGE_NUMBERS
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CONVERT(INT, CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage))
	END
	FROM EXAMPLE E, MEANING M, WORD W
	WHERE E.MeaningID = M.ID AND W.ID = M.WordID AND DictType = @DictType AND E.Deleted = 0;
END
GO

-- EXEC proc_GET_EXAMPLE_PAGE_NUMBERS 1, 10

/**************************************
	BẢNG PASSAGE_TYPE
***************************************/

--DROP TABLE [dbo].[PASSAGE_TYPE]
CREATE TABLE [dbo].[PASSAGE_TYPE] (
    [PassageType] VARCHAR (10)   NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([PassageType] ASC)
);
GO

INSERT INTO PASSAGE_TYPE VALUES ('HANHCHINH', N'Hành chính');
INSERT INTO PASSAGE_TYPE VALUES ('PHAPLUAT', N'Quy phạm pháp luật');
INSERT INTO PASSAGE_TYPE VALUES ('KHOAHOC', N'Khoa học');
INSERT INTO PASSAGE_TYPE VALUES ('BAOCHI', N'Báo chí');
INSERT INTO PASSAGE_TYPE VALUES ('SINHHOAT', N'Sinh hoạt');
INSERT INTO PASSAGE_TYPE VALUES ('NGHETHUAT', N'Nghệ thuật');
INSERT INTO PASSAGE_TYPE VALUES ('CHINHLUAN', N'Chính luận');
INSERT INTO PASSAGE_TYPE VALUES ('KHAC', N'Chưa phân loại');
GO

CREATE PROC proc_GET_PASSAGE_TYPES
-- ALTER PROC proc_GET_PASSAGE_TYPES
AS
	SELECT * FROM PASSAGE_TYPE ORDER BY Description ASC;
GO

/**************************************
	BẢNG BILINGUAL_PASSAGE
***************************************/

--DROP TABLE [dbo].[BILINGUAL_PASSAGE]
CREATE TABLE [dbo].[BILINGUAL_PASSAGE] (
    [ID]			INT            IDENTITY (1, 1) NOT NULL,
    [DictType]		TINYINT        NOT NULL,
    [PassageType]	VARCHAR (10)   NOT NULL DEFAULT 'OTHERS',
    [Source]		NVARCHAR (MAX) NULL,
    [Destination]	NVARCHAR (MAX) NULL,
    [PronouncePath]	NVARCHAR (MAX) NULL,
	[AddedDate]		DATETIME       NULL,
    [UpdatedDate]	DATETIME       NULL,
    [Creator]		VARCHAR (50)   NOT NULL,
	[Deleted]		BIT			 NOT NULL DEFAULT 0,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([DictType]) REFERENCES [dbo].[DICT_TYPE] ([DictType]),
    FOREIGN KEY ([PassageType]) REFERENCES [dbo].[PASSAGE_TYPE] ([PassageType]),
    FOREIGN KEY ([Creator]) REFERENCES [dbo].[ACCOUNT] ([Username])
);
GO

--DELETE FROM [BILINGUAL_PASSAGE]
--DBCC CHECKIDENT ('[BILINGUAL_PASSAGE]', RESEED, 0);

CREATE PROC proc_INSERT_PASSAGE
-- ALTER PROC proc_INSERT_PASSAGE
	@DictType TINYINT,
	@PassageType VARCHAR(10),
	@Source NVARCHAR(MAX),
	@Destination NVARCHAR(MAX),
	@PronouncePath NVARCHAR (MAX),
	@Creator VARCHAR(50)
AS
	IF @PronouncePath IS NOT NULL
		INSERT INTO BILINGUAL_PASSAGE (DictType, PassageType, Source, Destination, PronouncePath, AddedDate, UpdatedDate, Creator, Deleted)
		VALUES (@DictType, @PassageType, @Source, @Destination, @PronouncePath, GETDATE(), GETDATE(), @Creator, 0);
	ELSE
		INSERT INTO BILINGUAL_PASSAGE (DictType, PassageType, Source, Destination, AddedDate, UpdatedDate, Creator, Deleted)
		VALUES (@DictType, @PassageType, @Source, @Destination, GETDATE(), GETDATE(), @Creator, 0);
GO

CREATE PROC proc_INSERT_PASSAGE_TEST
-- ALTER PROC proc_INSERT_PASSAGE_TEST
	@DictType TINYINT,
	@PassageType VARCHAR(10),
	@Source NVARCHAR(MAX),
	@Destination NVARCHAR(MAX),
	@PronouncePath NVARCHAR (MAX),
	@Creator VARCHAR(50)
AS
BEGIN
	DECLARE @KQ BIT
	BEGIN TRANSACTION INSERT_PASSAGE
		BEGIN TRY
			EXEC proc_INSERT_PASSAGE @DictType, @PassageType, @Source, @Destination, @PronouncePath, @Creator
		END TRY
		BEGIN CATCH
		END CATCH
	ROLLBACK TRANSACTION INSERT_PASSAGE
END
GO

CREATE PROC proc_UPDATE_PASSAGE
-- ALTER PROC proc_UPDATE_PASSAGE
	@ID INT,
	@PassageType VARCHAR(10),
	@Source NVARCHAR(MAX),
	@Destination NVARCHAR(MAX),
	@PronouncePath NVARCHAR (MAX)
AS
	IF @PronouncePath IS NOT NULL
		UPDATE BILINGUAL_PASSAGE
		SET PassageType = @PassageType, Source = @Source, Destination = @Destination, PronouncePath = @PronouncePath, UpdatedDate = GETDATE()
		WHERE ID = @ID AND Deleted = 0
	ELSE
		UPDATE BILINGUAL_PASSAGE
		SET PassageType = @PassageType, Source = @Source, Destination = @Destination, UpdatedDate = GETDATE()
		WHERE ID = @ID AND Deleted = 0
GO

CREATE PROC proc_DELETE_PASSAGE
-- ALTER PROC proc_DELETE_PASSAGE
	@ID INT
AS
	UPDATE BILINGUAL_PASSAGE SET Deleted = 1 WHERE ID = @ID
GO

CREATE PROC proc_GET_PASSAGES_PAGINATION
-- ALTER PROC proc_GET_PASSAGES_PAGINATION
	@DictType TINYINT,
	@PageNumber INT,
	@RowsOfPage INT
AS
	SELECT * FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0
	ORDER BY ID OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;
GO

CREATE PROC proc_GET_PASSAGE
-- ALTER PROC proc_GET_PASSAGE
	@ID INT
AS
	SELECT * FROM BILINGUAL_PASSAGE WHERE ID = @ID AND Deleted = 0
GO

CREATE PROC proc_GET_PASSAGES_PAGE_NUMBERS
-- ALTER PROC proc_GET_PASSAGES_PAGE_NUMBERS
	@DictType TINYINT,
	@RowsOfPage INT
AS
BEGIN
	SELECT 
	CASE 
		WHEN COUNT(*) <= @RowsOfPage THEN 1 
		ELSE CONVERT(INT, CEILING(CONVERT(FLOAT, COUNT(*)) / @RowsOfPage))
	END
	FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0;
END
GO

-- EXEC proc_GET_PASSAGES_PAGE_NUMBERS 1, 10

CREATE PROC proc_GET_TOTAL_PASSAGES
-- ALTER PROC proc_GET_TOTAL_PASSAGES
	@DictType TINYINT,
	@Total INT OUTPUT
AS
	SET @Total = (SELECT COUNT(*) FROM BILINGUAL_PASSAGE WHERE DictType = @DictType AND Deleted = 0)
GO

CREATE PROC proc_GET_MAX_ID_PASSAGE
-- ALTER PROC proc_GET_MAX_ID_PASSAGE
	@MAX INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT TOP(1) ID FROM BILINGUAL_PASSAGE ORDER BY ID DESC)
		SET @MAX = (SELECT TOP(1) ID FROM BILINGUAL_PASSAGE ORDER BY ID DESC)
	ELSE
		SET @MAX = 0
END
GO

/**************************************
	RESET ALL
***************************************/

CREATE PROC proc_RESET_ALL
-- ALTER PROC proc_RESET_ALL
AS
	DELETE FROM [EXAMPLE]
	DELETE FROM [MEANING]
	DELETE FROM [WORD]
	DELETE FROM [BILINGUAL_PASSAGE]
	DBCC CHECKIDENT ('[EXAMPLE]', RESEED, 0);
	DBCC CHECKIDENT ('[MEANING]', RESEED, 0);
	DBCC CHECKIDENT ('[WORD]', RESEED, 0);
	DBCC CHECKIDENT ('[BILINGUAL_PASSAGE]', RESEED, 0);
GO

-- EXEC proc_RESET_ALL


CREATE PROC proc_RESET_IDENTITY_WORD
-- ALTER PROC proc_RESET_IDENTITY_WORD
	@ID INT
AS
	DBCC CHECKIDENT('[WORD]', RESEED, @ID)
	RETURN 1
GO

CREATE PROC proc_RESET_IDENTITY_PASSAGE
-- ALTER PROC proc_RESET_IDENTITY_PASSAGE
	@ID INT
AS
	DBCC CHECKIDENT('[PASSAGE]', RESEED, @ID)
	RETURN 1
GO

/**************************************
	DELETE WORD WITH MEANINGS AND EXAMPLES
***************************************/

CREATE PROC proc_DELETE_WORD
-- ALTER PROC proc_DELETE_WORD
	@ID INT,
	@OutputID INT OUTPUT
AS
BEGIN
	DECLARE @DictTypeID INT
	SET @DictTypeID = (SELECT DictType FROM WORD WHERE ID = @ID);
	--DELETE FROM WORD WHERE ID = @ID;
	UPDATE WORD SET Deleted = 1 WHERE ID = @ID;
	SET @OutputID = (SELECT TOP 1 ID FROM WORD WHERE ID < @ID AND DictType = @DictTypeID AND Deleted = 0 ORDER BY ID DESC)
	EXEC proc_DELETE_ALL_MEANINGS @ID
	EXEC proc_DELETE_ALL_EXAMPLES @ID 
END
GO
