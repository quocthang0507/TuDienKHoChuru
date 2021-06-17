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

CREATE TABLE ACCOUNT
(
	[ID] TINYINT IDENTITY(1, 1) PRIMARY KEY,
	[Fullname] NVARCHAR(100) NOT NULL,
	[Username] VARCHAR(50) NOT NULL UNIQUE,
	[Password] NVARCHAR(100) NOT NULL, --SHA256
	[Role] NVARCHAR(100) NOT NULL,
	[Email] NVARCHAR(100) NULL,
	[PhoneNumber] NVARCHAR(10) NULL,
	[Address] NVARCHAR(200) NOT NULL,
	[Active] BIT DEFAULT 1
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
INSERT INTO ACCOUNT VALUES (
	@Fullname, 
	@Username, 
	@Password, 
	@Role, 
	@Email,
	@PhoneNumber,
	@Address
)
GO

CREATE PROC proc_UPDATE_ACCOUNT
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

CREATE TABLE DICT_TYPE
(
	[DictType] TINYINT IDENTITY(1, 1) PRIMARY KEY,
	[Description] NVARCHAR(MAX) NOT NULL
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

CREATE TABLE WORD_TYPE
(
	[WordType] VARCHAR(10) PRIMARY KEY,
	[Description] NVARCHAR(MAX) NOT NULL
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

/*
	Bảng này lưu trữ từ vựng
*/
CREATE TABLE WORD
(
	[ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Word] NVARCHAR(MAX) NOT NULL,
	[DictType] TINYINT REFERENCES DICT_TYPE([DictType]),
	[WordType] VARCHAR(10) REFERENCES WORD_TYPE([WordType]) DEFAULT 'Others',
	[PronunPath] NVARCHAR(MAX) NULL,
	[ImgPath] NVARCHAR(MAX) NULL,
	[AddedDate] DATETIME NULL,
	[UpdatedDate] DATETIME NULL,
	[Creator] VARCHAR(50) NOT NULL REFERENCES ACCOUNT([Username])
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

CREATE PROC proc_DELETE_WORD
	@ID INT
AS
	DELETE FROM WORD WHERE ID = @ID
GO

EXEC dbo.proc_INSERT_UPDATE_WORD N'à wanh', 1, 'Verb', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'ada', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'ada prum', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'ada siam', 1, 'Noun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'adàr', 1, 'Adjective', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'adát', 1, 'Adjective', '', '', 'admin';

EXEC dbo.proc_INSERT_UPDATE_WORD N'a', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'á', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'à', 2, 'Others', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'ả', 2, 'Pronoun', '', '', 'admin';
EXEC dbo.proc_INSERT_UPDATE_WORD N'ạ', 2, 'Others', '', '', 'admin';

GO

CREATE PROC proc_GET_WORDS
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

CREATE PROC proc_GET_PAGE_NUMBERS
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

--SELECT DBO.func_GET_PAGE_NUMBERS(1, 10)

/*
	Bảng này lưu (các) nghĩa của từ
*/
CREATE TABLE MEANING
(
	[ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[WordID] INT REFERENCES WORD(ID),
	[Meaning] NVARCHAR(MAX) NOT NULL,
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

/*
	Bảng này lưu các đoạn văn song ngữ
*/
CREATE TABLE BILINGUAL_PASSAGE
(
	[ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[DictType] TINYINT REFERENCES DICT_TYPE(DictType),
	[Source] NVARCHAR(MAX) NOT NULL,
	[Destination] NVARCHAR(MAX) NOT NULL
);
GO