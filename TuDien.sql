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
    [Username] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(100) NOT NULL,
    [Role] NVARCHAR(100) NOT NULL,
    [Email] NVARCHAR(100) NULL,
    [PhoneNumber] NVARCHAR(10) NULL,
    [Address] NVARCHAR(200) NOT NULL
);
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
SELECT * FROM DICT_TYPE

/*
    Bảng này lưu trữ từ vựng
*/
CREATE TABLE WORD
(
    [ID] INT IDENTITY(1, 1) PRIMARY KEY,
    [Word] NVARCHAR(MAX),
    [DictType] TINYINT REFERENCES DICT_TYPE([DictType]),
    [PronunPath] NVARCHAR(MAX) NULL,
    [ImgPath] NVARCHAR(MAX) NULL
);
GO

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
    [PronunPath] NVARCHAR(MAX) NULL
);
GO

CREATE VIEW KHoViet_View AS 
    SELECT WORD.ID, Word, DICTIONARY.Meaning, WORD.ImgPath, WORD.PronunPath AS 'WordPronun', EXAMPLE.Example, EXAMPLE.PronunPath AS 'ExPronun'
    FROM 
    (
        (WORD INNER JOIN DICTIONARY ON WORD.ID = DICTIONARY.WordID)
        INNER JOIN EXAMPLE ON WORD.ID = EXAMPLE.WordID
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