USE [master]
GO
/****** Object:  Database [Library]    Script Date: 21.05.2023 20:09:35 ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'D:\SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'D:\SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY FULL 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Library', N'ON'
GO
ALTER DATABASE [Library] SET QUERY_STORE = ON
GO
ALTER DATABASE [Library] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Library]
GO
/****** Object:  Table [dbo].[Книги]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Книги](
	[Код_книги] [int] NOT NULL,
	[Название] [varchar](50) NULL,
	[Код_автора] [int] NOT NULL,
	[Год_издания] [datetime] NULL,
	[Количество] [smallint] NULL,
 CONSTRAINT [PK_Книги] PRIMARY KEY CLUSTERED 
(
	[Код_книги] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[КоличествоКниг]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[КоличествоКниг]
AS
SELECT        Название, Количество
FROM            dbo.Книги
GO
/****** Object:  Table [dbo].[Выдачи]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Выдачи](
	[Код_выдачи] [int] IDENTITY(1,1) NOT NULL,
	[Код_книги] [int] NOT NULL,
	[Дата_выдачи] [smalldatetime] NULL,
	[Дата_сдачи] [smalldatetime] NULL,
	[Чит_билет] [int] NOT NULL,
 CONSTRAINT [PK_Выдачи] PRIMARY KEY CLUSTERED 
(
	[Код_выдачи] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Читатели]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Читатели](
	[Чит_билет] [int] IDENTITY(1,1) NOT NULL,
	[ФИО] [varchar](50) NULL,
	[Адрес] [varchar](50) NULL,
	[Телефон] [varchar](50) NULL,
 CONSTRAINT [PK_Читатели] PRIMARY KEY CLUSTERED 
(
	[Чит_билет] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ВыданныеКниги]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ВыданныеКниги] (Код_выдачи, Название, Дата_выдачи, Дата_сдачи, ФИО)
as select Код_выдачи, Название, Дата_выдачи, Дата_сдачи, ФИО
from Выдачи a
LEFT JOIN Книги b ON a.Код_книги = b.Код_книги
LEFT JOIN Читатели c ON a.Чит_билет = c.Чит_билет
WHERE ФИО LIKE 'Коновалова О. И.' 
GO
/****** Object:  Table [dbo].[Авторы]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Авторы](
	[Код_автора] [int] NOT NULL,
	[ФИО] [varchar](50) NULL,
 CONSTRAINT [PK_Авторы] PRIMARY KEY CLUSTERED 
(
	[Код_автора] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[КнигиАвтора]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[КнигиАвтора] (Код_книги, Название, ФИО, Год_издания, Количество)
as select Код_книги, Название, ФИО, Год_издания, Количество
from Книги a
RIGHT JOIN Авторы b ON a.Код_автора = b.Код_автора
WHERE ФИО LIKE 'Тунсю М.'
GO
/****** Object:  View [dbo].[ВыдачиКниг]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ВыдачиКниг] (Название, Дата_выдачи, Дата_сдачи, ФИО)
as select Название, Дата_выдачи, Дата_сдачи, ФИО
from Выдачи a
LEFT JOIN Книги b ON a.Код_книги = b.Код_книги
LEFT JOIN Читатели c ON a.Чит_билет = c.Чит_билет 
GO
/****** Object:  View [dbo].[ИнфоКнигах]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ИнфоКнигах] (Название, ФИО, Год_издания, Количество)
as select Название, ФИО, Год_издания, Количество
from Книги a
RIGHT JOIN Авторы b ON a.Код_автора = b.Код_автора 
GO
/****** Object:  Table [dbo].[register]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[register](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[login_user] [varchar](50) NOT NULL,
	[password_user] [varchar](50) NOT NULL,
 CONSTRAINT [PK_register] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Выдачи]  WITH CHECK ADD  CONSTRAINT [FK_Код_книг] FOREIGN KEY([Код_книги])
REFERENCES [dbo].[Книги] ([Код_книги])
GO
ALTER TABLE [dbo].[Выдачи] CHECK CONSTRAINT [FK_Код_книг]
GO
ALTER TABLE [dbo].[Выдачи]  WITH CHECK ADD  CONSTRAINT [FK_Чит_билет] FOREIGN KEY([Чит_билет])
REFERENCES [dbo].[Читатели] ([Чит_билет])
GO
ALTER TABLE [dbo].[Выдачи] CHECK CONSTRAINT [FK_Чит_билет]
GO
ALTER TABLE [dbo].[Книги]  WITH CHECK ADD  CONSTRAINT [FK_Код_автора] FOREIGN KEY([Код_автора])
REFERENCES [dbo].[Авторы] ([Код_автора])
GO
ALTER TABLE [dbo].[Книги] CHECK CONSTRAINT [FK_Код_автора]
GO
/****** Object:  StoredProcedure [dbo].[BookInfo]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BookInfo] AS
BEGIN
    select ФИО as Автор, Название as 'Название книги'
	from Книги 
	JOIN Авторы ON Книги.Код_автора = Авторы.Код_автора
END;
GO
/****** Object:  StoredProcedure [dbo].[Extraditions]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Extraditions] AS
BEGIN
    SELECT Название AS Название_Книги, ФИО AS Читатель
    FROM Выдачи a
	LEFT JOIN Книги b ON a.Код_книги = b.Код_книги
	LEFT JOIN Читатели c ON a.Чит_билет = c.Чит_билет
END;
GO
/****** Object:  StoredProcedure [dbo].[InfoBook]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InfoBook] @Name nvarchar(50) AS
BEGIN
    select Название, Дата_выдачи, Дата_сдачи, ФИО as Читатель
	from Выдачи a
	LEFT JOIN Книги b ON a.Код_книги = b.Код_книги
	LEFT JOIN Читатели c ON a.Чит_билет = c.Чит_билет
	WHERE ФИО LIKE @Name
END;
GO
/****** Object:  StoredProcedure [dbo].[MinusBook]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MinusBook] @NameBook nvarchar(50) AS
BEGIN
    select Код_книги, Название, ФИО, Год_издания, Количество - 1 as Количество
	from Книги a
	RIGHT JOIN Авторы b ON a.Код_автора = b.Код_автора
	WHERE Название LIKE @NameBook
	
END;
GO
/****** Object:  StoredProcedure [dbo].[UsersInfo]    Script Date: 21.05.2023 20:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsersInfo] AS
BEGIN
    select login_user as Логин, password_user as Пароль
	from register
END;

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Книги"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'КоличествоКниг'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'КоличествоКниг'
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
