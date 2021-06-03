USE master 
GO

IF EXISTS(SELECT *
FROM sys.databases
WHERE name = 'TuDienKHo_Viet_Churu')
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
    [Username] NVARCHAR(50) NOT NULL UNIQUE,
    [Password] NVARCHAR(100) NOT NULL,
    --SHA256
    [Role] NVARCHAR(100) NOT NULL,
    [Email] NVARCHAR(100) NULL,
    [PhoneNumber] NVARCHAR(10) NULL,
    [Address] NVARCHAR(200) NOT NULL
);
GO

INSERT INTO ACCOUNT
VALUES
    (N'La Quốc Thắng', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'Admin', '1610207@dlu.edu.vn', '0987610260', N'Võ Trường Toản, Phường 8, Đà Lạt, Lâm Đồng')
INSERT INTO ACCOUNT
VALUES
    (N'Cộng tác viên', 'collaborator', '53adf83d9f7b4dd136fee848946a5ea6d28640406aa260d1bb6adb79dccb58ee', 'Collaborator', '', '', N'Đại học Đà Lạt, Phù Đổng Thiên Vương, Phường 8, Đà Lạt, Lâm Đồng')
GO

CREATE PROC GET_ACCOUNTS
AS
SELECT *
FROM ACCOUNT
GO

CREATE PROC UPDATE_ACCOUNT
    @ID TINYINT,
    @Fullname NVARCHAR(100),
    @Username NVARCHAR(50),
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

CREATE TABLE DICT_TYPE
(
    [DictType] TINYINT IDENTITY(1, 1) PRIMARY KEY,
    [Description] NVARCHAR(MAX) NOT NULL
);
GO

INSERT INTO DICT_TYPE
VALUES
    (N'Từ điển K''Ho - Việt')
INSERT INTO DICT_TYPE
VALUES
    (N'Từ điển Việt - K''Ho')
INSERT INTO DICT_TYPE
VALUES
    (N'Từ điển Churu - Việt')
INSERT INTO DICT_TYPE
VALUES
    (N'Từ điển Việt - Churu')
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

/*
    Bảng này lưu trữ từ vựng
*/
CREATE TABLE WORD
(
    [ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Word] NVARCHAR(MAX) NOT NULL,
    [DictType] TINYINT REFERENCES DICT_TYPE([DictType]),
    [PronunPath] NVARCHAR(MAX) NULL,
    [ImgPath] NVARCHAR(MAX) NULL,
    [AddedDate] DATETIME NULL,
    [UpdatedDate] DATETIME NULL,
    [Creator] NVARCHAR(50) REFERENCES Account(Username)
);

/*
    Bảng này lưu (các) nghĩa của từ
*/
CREATE TABLE DICTIONARY
(
    [ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [WordID] INT REFERENCES WORD(ID),
    [Meaning] NVARCHAR(MAX) NOT NULL,
);
GO

/*
    Bảng này lưu (các) ví dụ của từ
*/
CREATE TABLE EXAMPLE
(
    [ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [WordID] INT REFERENCES WORD(ID),
    [Example] NVARCHAR(MAX) NOT NULL,
    [Meaning] NVARCHAR(MAX) NOT NULL,
    [PronunPath] NVARCHAR(MAX) NULL
);
GO

CREATE PROC KHoVietView_procedure
    @PageNumber INT,
    @RowsOfPage INT
AS
SELECT WORD.ID, Word, DICTIONARY.Meaning, WORD.ImgPath, WORD.PronunPath AS 'WordPronun', EXAMPLE.Example, EXAMPLE.PronunPath AS 'ExPronun'
FROM
    (
    (WORD INNER JOIN DICTIONARY ON WORD.ID = DICTIONARY.WordID)
    INNER JOIN EXAMPLE ON WORD.ID = EXAMPLE.WordID
    )
WHERE DictType = 1
ORDER BY Word
    OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
    FETCH NEXT @RowsOfPage ROWS ONLY;
GO

CREATE PROC ChuruVietView_procedure
    @PageNumber INT,
    @RowsOfPage INT
AS
SELECT WORD.ID, Word, DICTIONARY.Meaning, WORD.ImgPath, WORD.PronunPath AS 'WordPronun', EXAMPLE.Example, EXAMPLE.PronunPath AS 'ExPronun'
FROM
    (
    (WORD INNER JOIN DICTIONARY ON WORD.ID = DICTIONARY.WordID)
    INNER JOIN EXAMPLE ON WORD.ID = EXAMPLE.WordID
    )
WHERE DictType = 3
ORDER BY Word
    OFFSET (@PageNumber - 1) * @RowsOfPage ROWS
    FETCH NEXT @RowsOfPage ROWS ONLY;
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