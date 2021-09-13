USE [TuDienKHo_Viet_Churu]
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_UPDATE_WORD]
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_UPDATE_PASSAGE]
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_AUDIO_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_UPDATE_AUDIO_EXAMPLE]
GO
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_UPDATE_ACCOUNT]
GO
/****** Object:  StoredProcedure [dbo].[proc_RESET_IDENTITY_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_RESET_IDENTITY_WORD]
GO
/****** Object:  StoredProcedure [dbo].[proc_RESET_ALL]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_RESET_ALL]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_TEST]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_WORD_TEST]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_OUTPUT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_WORD_OUTPUT]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_WORD]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_PASSAGE]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING_OUTPUT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_MEANING_OUTPUT]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_MEANING]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_EXAMPLE]
GO
/****** Object:  StoredProcedure [dbo].[proc_INSERT_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_INSERT_ACCOUNT]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORDS_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_WORDS_PAGINATION]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_WORD_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_WORD_PAGE_NUMBERS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_WORDS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_TOTAL_WORDS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_PASSAGES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_TOTAL_PASSAGES]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_PASSAGES_PAGINATION]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_PASSAGES_PAGE_NUMBERS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_PASSAGE_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_PASSAGE]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_MEANINGS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_MEANINGS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_MAX_ID_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_MAX_ID_WORD]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_EXAMPLES_PAGINATION]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_EXAMPLES]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLE_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_EXAMPLE_PAGE_NUMBERS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_DICT_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_DICT_TYPES]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_ACCOUNTS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_GET_ACCOUNTS]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_WORD]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_PASSAGE]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_MEANING]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_EXAMPLE]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_MEANINGS]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_ALL_MEANINGS]
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_EXAMPLES]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DELETE_ALL_EXAMPLES]
GO
/****** Object:  StoredProcedure [dbo].[proc_DEACTIVATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_DEACTIVATE_ACCOUNT]
GO
/****** Object:  StoredProcedure [dbo].[proc_ACTIVATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP PROCEDURE [dbo].[proc_ACTIVATE_ACCOUNT]
GO
ALTER TABLE [dbo].[WORD] DROP CONSTRAINT [FK__WORD__WordType__35BCFE0A]
GO
ALTER TABLE [dbo].[WORD] DROP CONSTRAINT [FK__WORD__DictType__34C8D9D1]
GO
ALTER TABLE [dbo].[WORD] DROP CONSTRAINT [FK__WORD__Creator__36B12243]
GO
ALTER TABLE [dbo].[MEANING] DROP CONSTRAINT [FK__MEANING__WordID__403A8C7D]
GO
ALTER TABLE [dbo].[EXAMPLE] DROP CONSTRAINT [FK__EXAMPLE__Meaning__46E78A0C]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] DROP CONSTRAINT [FK__BILINGUAL__Passa__72C60C4A]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] DROP CONSTRAINT [FK__BILINGUAL__DictT__71D1E811]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] DROP CONSTRAINT [FK__BILINGUAL__Creat__73BA3083]
GO
ALTER TABLE [dbo].[WORD] DROP CONSTRAINT [DF__WORD__Deleted__33D4B598]
GO
ALTER TABLE [dbo].[WORD] DROP CONSTRAINT [DF__WORD__WordType__32E0915F]
GO
ALTER TABLE [dbo].[MEANING] DROP CONSTRAINT [DF__MEANING__Deleted__3F466844]
GO
ALTER TABLE [dbo].[EXAMPLE] DROP CONSTRAINT [DF__EXAMPLE__Deleted__45F365D3]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] DROP CONSTRAINT [DF__BILINGUAL__Delet__70DDC3D8]
GO
ALTER TABLE [dbo].[BILINGUAL_PASSAGE] DROP CONSTRAINT [DF__BILINGUAL__Passa__6FE99F9F]
GO
ALTER TABLE [dbo].[ACCOUNT] DROP CONSTRAINT [DF__ACCOUNT__Active__25869641]
GO
/****** Object:  Index [UQ__ACCOUNT__536C85E48C7B6504]    Script Date: 9/13/2021 7:49:15 PM ******/
ALTER TABLE [dbo].[ACCOUNT] DROP CONSTRAINT [UQ__ACCOUNT__536C85E48C7B6504]
GO
/****** Object:  Table [dbo].[WORD_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WORD_TYPE]') AND type in (N'U'))
DROP TABLE [dbo].[WORD_TYPE]
GO
/****** Object:  Table [dbo].[WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WORD]') AND type in (N'U'))
DROP TABLE [dbo].[WORD]
GO
/****** Object:  Table [dbo].[PASSAGE_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PASSAGE_TYPE]') AND type in (N'U'))
DROP TABLE [dbo].[PASSAGE_TYPE]
GO
/****** Object:  Table [dbo].[MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MEANING]') AND type in (N'U'))
DROP TABLE [dbo].[MEANING]
GO
/****** Object:  Table [dbo].[EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EXAMPLE]') AND type in (N'U'))
DROP TABLE [dbo].[EXAMPLE]
GO
/****** Object:  Table [dbo].[DICT_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DICT_TYPE]') AND type in (N'U'))
DROP TABLE [dbo].[DICT_TYPE]
GO
/****** Object:  Table [dbo].[BILINGUAL_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BILINGUAL_PASSAGE]') AND type in (N'U'))
DROP TABLE [dbo].[BILINGUAL_PASSAGE]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ACCOUNT]') AND type in (N'U'))
DROP TABLE [dbo].[ACCOUNT]
GO
USE [master]
GO
/****** Object:  Database [TuDienKHo_Viet_Churu]    Script Date: 9/13/2021 7:49:15 PM ******/
DROP DATABASE [TuDienKHo_Viet_Churu]
GO
/****** Object:  Database [TuDienKHo_Viet_Churu]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BILINGUAL_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[DICT_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[PASSAGE_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  Table [dbo].[WORD_TYPE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
SET IDENTITY_INSERT [dbo].[ACCOUNT] ON 

INSERT [dbo].[ACCOUNT] ([ID], [Fullname], [Username], [Password], [Role], [Email], [PhoneNumber], [Address], [Active]) VALUES (1, N'La Quốc Thắng', N'admin', N'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', N'Admin', N'1610207@dlu.edu.vn', N'0987610260', N'Võ Trường Toản, Phường 8, Đà Lạt, Lâm Đồng', 1)
INSERT [dbo].[ACCOUNT] ([ID], [Fullname], [Username], [Password], [Role], [Email], [PhoneNumber], [Address], [Active]) VALUES (2, N'Cộng tác viên', N'collaborator', N'53adf83d9f7b4dd136fee848946a5ea6d28640406aa260d1bb6adb79dccb58ee', N'Collaborator', N'', N'', N'Đại học Đà Lạt, Phù Đổng Thiên Vương, Phường 8, Đà Lạt, Lâm Đồng', 1)
SET IDENTITY_INSERT [dbo].[ACCOUNT] OFF
GO
SET IDENTITY_INSERT [dbo].[BILINGUAL_PASSAGE] ON 

INSERT [dbo].[BILINGUAL_PASSAGE] ([ID], [DictType], [PassageType], [Source], [Destination], [AddedDate], [UpdatedDate], [Creator], [Deleted]) VALUES (1, 1, N'BAOCHI', N'Alo ahihi huhu', N'Xin chào các bạn', CAST(N'2021-07-06T10:25:34.520' AS DateTime), CAST(N'2021-07-06T10:42:39.063' AS DateTime), N'admin', 0)
INSERT [dbo].[BILINGUAL_PASSAGE] ([ID], [DictType], [PassageType], [Source], [Destination], [AddedDate], [UpdatedDate], [Creator], [Deleted]) VALUES (2, 1, N'SINHHOAT', N'Arigatou', N'Cảm ơn', CAST(N'2021-07-06T10:26:37.380' AS DateTime), CAST(N'2021-07-06T10:27:11.900' AS DateTime), N'admin', 0)
INSERT [dbo].[BILINGUAL_PASSAGE] ([ID], [DictType], [PassageType], [Source], [Destination], [AddedDate], [UpdatedDate], [Creator], [Deleted]) VALUES (3, 1, N'BAOCHI', N'xuống dòng
nè


ahihi', N'khoảng trắng          nhiều    vô 
số kể', CAST(N'2021-07-06T10:27:59.453' AS DateTime), CAST(N'2021-07-06T10:29:05.643' AS DateTime), N'admin', 0)
INSERT [dbo].[BILINGUAL_PASSAGE] ([ID], [DictType], [PassageType], [Source], [Destination], [AddedDate], [UpdatedDate], [Creator], [Deleted]) VALUES (4, 1, N'KHAC', N'<script>alert(1);</script>', NULL, CAST(N'2021-07-06T10:28:39.957' AS DateTime), CAST(N'2021-07-06T10:28:39.957' AS DateTime), N'admin', 1)
INSERT [dbo].[BILINGUAL_PASSAGE] ([ID], [DictType], [PassageType], [Source], [Destination], [AddedDate], [UpdatedDate], [Creator], [Deleted]) VALUES (5, 1, N'SINHHOAT', N'Itadakimatsu', N'Chúc ngon miệng', CAST(N'2021-07-06T10:43:13.000' AS DateTime), CAST(N'2021-07-06T11:03:44.563' AS DateTime), N'admin', 0)
SET IDENTITY_INSERT [dbo].[BILINGUAL_PASSAGE] OFF
GO
SET IDENTITY_INSERT [dbo].[DICT_TYPE] ON 

INSERT [dbo].[DICT_TYPE] ([DictType], [Description]) VALUES (1, N'Từ điển K''Ho - Việt')
INSERT [dbo].[DICT_TYPE] ([DictType], [Description]) VALUES (2, N'Từ điển Việt - K''Ho')
INSERT [dbo].[DICT_TYPE] ([DictType], [Description]) VALUES (3, N'Từ điển Churu - Việt')
INSERT [dbo].[DICT_TYPE] ([DictType], [Description]) VALUES (4, N'Từ điển Việt - Churu')
SET IDENTITY_INSERT [dbo].[DICT_TYPE] OFF
GO
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'BAOCHI', N'Báo chí')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'CHINHLUAN', N'Chính luận')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'HANHCHINH', N'Hành chính')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'KHAC', N'Chưa phân loại')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'KHOAHOC', N'Khoa học')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'NGHETHUAT', N'Nghệ thuật')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'PHAPLUAT', N'Quy phạm pháp luật')
INSERT [dbo].[PASSAGE_TYPE] ([PassageType], [Description]) VALUES (N'SINHHOAT', N'Sinh hoạt')
GO
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Adjective', N'Tính từ')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Adverb', N'Trạng từ')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Noun', N'Danh từ')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Others', N'Khác')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Prep', N'Giới từ')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Pronoun', N'Đại từ')
INSERT [dbo].[WORD_TYPE] ([WordType], [Description]) VALUES (N'Verb', N'Động từ')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ACCOUNT__536C85E48C7B6504]    Script Date: 9/13/2021 7:49:15 PM ******/
ALTER TABLE [dbo].[ACCOUNT] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[proc_ACTIVATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DEACTIVATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_EXAMPLES]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_ALL_EXAMPLES]
-- ALTER PROC proc_DELETE_ALL_EXAMPLES
	@WordID INT
AS
	UPDATE EXAMPLE SET Deleted = 1 
	WHERE ID IN (SELECT E.ID FROM WORD W, MEANING M, EXAMPLE E WHERE W.ID = M.WordID AND M.ID = E.MeaningID AND W.ID = @WordID)
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_ALL_MEANINGS]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DELETE_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_DELETE_MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_DELETE_MEANING]
-- ALTER PROC proc_DELETE_MEANING
	@ID INT
AS
	--DELETE FROM MEANING WHERE ID = @ID
	UPDATE MEANING SET Deleted = 1 	WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_DELETE_PASSAGE]
	@ID INT
AS
	UPDATE BILINGUAL_PASSAGE SET Deleted = 1 WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[proc_DELETE_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
	EXEC proc_DELETE_ALL_MEANINGS @ID
	EXEC proc_DELETE_ALL_EXAMPLES @ID 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_ACCOUNTS]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_ACCOUNTS]
AS
	SELECT * FROM ACCOUNT
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_DICT_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_DICT_TYPES]
AS
	SELECT * FROM DICT_TYPE
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLE_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_EXAMPLES]
	@MeaningID INT
AS
	SELECT * FROM EXAMPLE WHERE MeaningID = @MeaningID AND Deleted = 0 ORDER BY EXAMPLE;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_EXAMPLES_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_MAX_ID_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_MEANINGS]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_MEANINGS]
	@WordID INT
AS
	SELECT * FROM MEANING WHERE WordID = @WordID AND Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_PASSAGE]
	@ID INT
AS
	SELECT * FROM BILINGUAL_PASSAGE WHERE ID = @ID AND Deleted = 0
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGE_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GET_PASSAGE_TYPES]
AS
	SELECT * FROM PASSAGE_TYPE ORDER BY Description ASC;
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_PASSAGES_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_PASSAGES]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_TOTAL_WORDS]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_PAGE_NUMBERS]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_GET_WORD_TYPES]    Script Date: 9/13/2021 7:49:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_GET_WORD_TYPES]
AS
	SELECT * FROM WORD_TYPE ORDER BY [Description]
GO
/****** Object:  StoredProcedure [dbo].[proc_GET_WORDS_PAGINATION]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_MEANING_OUTPUT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_OUTPUT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_INSERT_WORD_TEST]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_RESET_ALL]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_RESET_IDENTITY_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_ACCOUNT]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_AUDIO_EXAMPLE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_PASSAGE]    Script Date: 9/13/2021 7:49:15 PM ******/
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
/****** Object:  StoredProcedure [dbo].[proc_UPDATE_WORD]    Script Date: 9/13/2021 7:49:15 PM ******/
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
