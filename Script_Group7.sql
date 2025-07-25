USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe1]    Script Date: 24/05/2023 4:24:08 CH ******/
CREATE DATABASE [QuanLyQuanCafe1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe1', FILENAME = N'D:\Microsoft SQL SERVER\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCafe1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe1_log', FILENAME = N'D:\Microsoft SQL SERVER\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCafe1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QuanLyQuanCafe1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe1', N'ON'
GO
ALTER DATABASE [QuanLyQuanCafe1] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyQuanCafe1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyQuanCafe1]
GO
/****** Object:  User [staff2]    Script Date: 24/05/2023 4:24:08 CH ******/
CREATE USER [staff2] FOR LOGIN [staff2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [staff1]    Script Date: 24/05/2023 4:24:08 CH ******/
CREATE USER [staff1] FOR LOGIN [staff1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [staff]    Script Date: 24/05/2023 4:24:08 CH ******/
CREATE USER [staff] FOR LOGIN [staff] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [giakiet]    Script Date: 24/05/2023 4:24:08 CH ******/
CREATE USER [giakiet] FOR LOGIN [giakiet] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetListIncomeByDate]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_GetListIncomeByDate]
(@datein date,@dateout date)
returns @DanhSachThuNhap table(namee nvarchar(100),dateinn date,dateoutt date,discountt int ,totalPricee float)
as
begin
	INSERT INTO @DanhSachThuNhap(namee,dateinn,dateoutt,discountt,totalPricee)
	select t.name,b.DateCheckIn,b.DateCheckOut,b.discount,b.totalPrice 
	from dbo.Bill as b ,dbo.TableFood as t 
	where  DateCheckIn>=@datein and DateCheckOut<=@dateout 
	and b.status=1  and t.id=b.idTable
	return

end

GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetMenu]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_GetMenu] (@id1 int)
returns @Menu table(namefood nvarchar(100),countt int ,price float,totalPricee float)
as 
begin
	INSERT INTO @Menu(namefood,countt,price,totalPricee)
	Select c.name as foodname ,b.count,c.price,c.price*b.count as totalPrice from dbo.Bill as a,dbo.BillInfo as b,dbo.Food as c WHERE b.idBill = a.id and b.idFood = c.id and a.idTable =  @id1 and a.status=0
	return
end
GO
/****** Object:  UserDefinedFunction [dbo].[FN_ListAccount]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[FN_ListAccount] (@type int)
returns @DanhSachAccountTheoType table(username nvarchar(100),displayname nvarchar(100),password nvarchar(100),type int)
as
begin
	insert into @DanhSachAccountTheoType(username,displayname,password,type)
	select Username,DisplayName,Password,Type
	from dbo.Account
	where Type=@type
	return

end
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[idEmployee] [int] IDENTITY(1,1) NOT NULL,
	[nameEmpployee] [nvarchar](100) NOT NULL,
	[birthEmployye] [datetime] NULL,
	[workingEmployye] [float] NOT NULL,
	[statusEmployye] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_EmployeeActiv]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_EmployeeActiv] as
select *
from dbo.Employee
where statusEmployye=N'Working'
GO
/****** Object:  Table [dbo].[Account]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ListAccount]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListAccount] as
select * from dbo.Account
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[Discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 24/05/2023 4:24:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'giakiet', N'Coffe', N'123', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'staff', N'Coffe', N'staff', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'staff1', N'Coffe', N'staff1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'staff2', N'Coffe', N'staff2', 1)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [Discount], [totalPrice]) VALUES (7, CAST(N'2023-05-23' AS Date), CAST(N'2023-05-23' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [Discount], [totalPrice]) VALUES (8, CAST(N'2023-05-23' AS Date), CAST(N'2023-05-23' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [Discount], [totalPrice]) VALUES (9, CAST(N'2023-05-24' AS Date), CAST(N'2023-05-24' AS Date), 2, 1, 30, 196)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [Discount], [totalPrice]) VALUES (10, CAST(N'2023-05-24' AS Date), CAST(N'2023-05-24' AS Date), 5, 1, 0, 561)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (12, 9, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (13, 10, 6, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (14, 10, 7, 3)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([idEmployee], [nameEmpployee], [birthEmployye], [workingEmployye], [statusEmployye]) VALUES (1, N'Gia Kiet', CAST(N'2003-06-05T00:00:00.000' AS DateTime), 4.5, N'Working')
INSERT [dbo].[Employee] ([idEmployee], [nameEmpployee], [birthEmployye], [workingEmployye], [statusEmployye]) VALUES (6, N'tuong', CAST(N'2003-05-03T00:00:00.000' AS DateTime), 0, N'Working')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Vietnamese Salad with Yellowfin Bream ', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Rock Lobster Thermidor', 1, 220000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Mushroom Hotpot', 2, 150000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'ThaiLan Hotpot', 2, 160000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Cobb Salad', 3, 150000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Greek Salad', 3, 170000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Coke', 4, 17000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Beer Tiger', 4, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Vietnamese Salad with Yellowfin Bream ', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'Rock Lobster Thermidor', 1, 220000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'Mushroom Hotpot', 2, 150000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'ThaiLan Hotpot', 2, 160000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Cobb Salad', 3, 150000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Greek Salad', 3, 170000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Coke', 4, 17000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Beer Tiger', 4, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Vietnamese Salad with Yellowfin Bream ', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Vietnamese Salad with Yellowfin Bream ', 1, 120000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Sea Food')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Hot Pot')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Vegetable')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Beverage')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Sea Food')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Hot Pot')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Vegetable')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'Beverage')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Table 0', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Table 1', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Table 2', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Table 3', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Table 4', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Table 5', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Table 6', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Table 7', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Table 8', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Table 9', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Table 10', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Table 11', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Table 12', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Table 0', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Table 1', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Table 2', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Table 3', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Table 4', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Table 5', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Table 6', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Table 7', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (22, N'Table 8', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (23, N'Table 9', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (24, N'Table 10', N'Free')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (25, N'Table 24', N'Free')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Coffe') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (NULL) FOR [totalPrice]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT (N'NO NAME IS SET') FOR [nameEmpployee]
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT ((0)) FOR [workingEmployye]
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT (N'Off') FOR [statusEmployye]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'NO NAME IS SET') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Free') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CHECK_TUOI] CHECK  (((datepart(year,getdate())-datepart(year,[birthEmployye]))>=(18)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CHECK_TUOI]
GO
/****** Object:  StoredProcedure [dbo].[AddTable]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Update dbo.Food set name = Sting , idCategory=4 , price=16000 where id=9


--exec UpdateAccount 'giakiet' , 'Kiet' , '1' , 'giakiet'
--select * from dbo.Account

--select *from dbo.TableFood
--Go

CREATE   Proc [dbo].[AddTable]
as
begin
	DECLARE @count INT =0
	SELECT @count= MAX (id) from DBO.TableFood
	INSERT dbo.TableFood (name) 
	values(N'Table ' + cast(@count as nvarchar(100)))
End
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmploy]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE   Proc [dbo].[DeleteEmploy]
@id int
as 
begin
	
	delete from dbo.Employee where  idEmployee=@id
	declare @resetid int =@id -1
	DBCC CHECKIDENT ('dbo.Employee', RESEED, @resetid)
end



ALTER TABLE dbo.Employee ADD CONSTRAINT CHECK_TUOI CHECK
((YEAR(GETDATE())-YEAR(birthEmployye))>=18)
delete dbo.Employee
DBCC CHECKIDENT ('dbo.Employee', RESEED, 0)
GO
/****** Object:  StoredProcedure [dbo].[DeleteTable]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[DeleteTable]
as 
begin
	declare @maxid int =0
	select @maxid =MAX (id) from dbo.TableFood 
	delete from dbo.TableFood where  id=@maxid
	declare @resetid int =@maxid -1
	DBCC CHECKIDENT ('dbo.TableFood', RESEED, @resetid)
end
GO
/****** Object:  StoredProcedure [dbo].[GanQuyenNhanVien]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[GanQuyenNhanVien](@type int,@Loginname nvarchar(100) )
AS
BEGIN

		DECLARE @quyen varchar(15), @tenUser nvarchar(15),@nhom varchar(20),@Num int
		set @Num=@type 
		
 

		SELECT @tenUser=Username FROM Account WHERE type=@type and UserName=@Loginname

		-- Add người dùng vào role tương ứng (Staff hoặc Manager(sysadmin))
		if (@type= 0)
			Begin
				DECLARE @sqlString NVARCHAR(MAX);
				SET @sqlString = N'ALTER SERVER ROLE sysadmin ADD MEMBER ' + QUOTENAME(@tenUser);
				EXEC sp_executesql @sqlString;
			end 
		else
			BEGIN
				--SET @sqlString = 'ALTER ROLE Librarian ADD MEMBER ' + @tenUser;
				--exec (@sqlString)
				DECLARE @sql NVARCHAR(MAX);
				;
				SET @sql = 'GRANT SELECT, INSERT, UPDATE, DELETE ON Bill TO ' + QUOTENAME(@tenUser)+ 
				';GRANT SELECT, INSERT, UPDATE, DELETE ON BillInfo TO ' + QUOTENAME(@tenUser) +
				';GRANT SELECT, INSERT, UPDATE, DELETE ON TableFood TO ' + QUOTENAME(@tenUser)
				+ ';GRANT EXECUTE TO ' + QUOTENAME(@tenUser)
				+ ';GRANT SELECT TO ' + QUOTENAME(@tenUser)
				
				EXECUTE sp_executesql @sql;
			END
END			
GO
/****** Object:  StoredProcedure [dbo].[GetListByDate]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SELECT MAX (id) FROM dbo.Bill
--Select c.name as foodname ,b.count,c.price,c.price*b.count as totalPrice from dbo.Bill as a,dbo.BillInfo as b,dbo.Food as c WHERE b.idBill = a.id and b.idFood = c.id and a.idTable = 1 and a.status=0
--SELECT * FROM dbo.Bill Where idTable = 4 AND status =0


--go


CREATE   PROC [dbo].[GetListByDate]
@datein date,@dateout date
as begin
select t.name,b.DateCheckIn,b.DateCheckOut,b.discount,b.totalPrice from dbo.Bill as b ,dbo.TableFood as t where  DateCheckIn>=@datein and DateCheckOut<=@dateout and b.status=1  and t.id=b.idTable
end

--exec GetListByDate '20230501' ,'20230531'

GO
/****** Object:  StoredProcedure [dbo].[ThemDangNhap]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[ThemDangNhap] (@LoginName NVARCHAR(100), @password NVARCHAR(1000) ,@type int)
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY

	INSERT INTO Account(UserName, Password,Type) VALUES 
	(@LoginName,@password,@type);
	EXEC GanQuyenNhanVien @type,@LoginName

	COMMIT TRAN
	END TRY
	BEGIN CATCH
	ROLLBACK
	DECLARE @err varchar(MAX)
	SELECT @err = 'Lỗi: ' + ERROR_MESSAGE()
	RAISERROR(@err, 16,1)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccount]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[UpdateAccount]
@username nvarchar(100),@displayname nvarchar(100),@password nvarchar(100),@newPasword nvarchar(100)
as
begin
	declare @isAvailable int =0
	SELECT @isAvailable=COUNT(*) from dbo.Account where Username=@username and Password=@password
	if(@isAvailable>0)
	BEGIN
		if(@newPasword=NULL or @newPasword='')
		BEGIN
			Update dbo.Account set DisplayName=@displayname where Username=@username 
		END
		ELSE	
			Update dbo.Account set Password=@newPasword, DisplayName=@displayname where Username=@username 
	END
	select * from dbo.Account  where Username=@username and Password=@newPasword
end
GO
/****** Object:  StoredProcedure [dbo].[USP_CaculateWorkingTime]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[USP_CaculateWorkingTime]
@totaltime float
as
begin
	Begin Tran
	declare @count int=0
	Select  @count= COUNT(*) from dbo.TableFood where status=N'In Using'
	Update dbo.Employee set workingEmployye+=@totaltime where statusEmployye=N'Working'
	Update dbo.Employee set statusEmployye=N'Off' where statusEmployye=N'Working'
		if(@totaltime<4)
		begin
			rollback 
			DECLARE @err varchar(MAX)
			SELECT @err = 'Each shift must last more than 4 hour '
			RAISERROR(@err, 16,1)
		end
		else if(@count>0)
		begin
			rollback 
			
			SELECT @err = 'All table need to be pay ,before allowing all employees to end shift '
			RAISERROR(@err, 16,1)
		end
		else
			Commit Tran

	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_EmployeeWorking]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[USP_EmployeeWorking]
@id int 
as
begin
	declare @idemploy int
	SELECT @idemploy = MAX(idEmployee) from dbo.Employee
	if(@id>@idemploy)
		begin
			DECLARE @err varchar(MAX)
			SELECT @err = 'ID of employee is unavailable '
			RAISERROR(@err, 16,1)
		end
	else
	begin
		UPDATE dbo.Employee set statusEmployye=N'Working' where idEmployee=@id
	end
end


GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@username nvarchar(100)
AS 
BEGIN
	SELECT *FROM dbo.Account WHERE UserName=@username
End
GO
/****** Object:  StoredProcedure [dbo].[USP_GetBill]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetBill]
@idbill int
AS 
	SElect*FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_GetLogin]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetLogin]
@username nvarchar(100),@password nvarchar(100)
AS 
BEGIN
	SELECT *FROM dbo.Account WHERE UserName=@username AND Password=@password
End
GO
/****** Object:  StoredProcedure [dbo].[USP_GetMenu]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetMenu]
@id1 int
as 
begin
	Select c.name as foodname ,b.count,c.price,c.price*b.count as totalPrice from dbo.Bill as a,dbo.BillInfo as b,dbo.Food as c WHERE b.idBill = a.id and b.idFood = c.id and a.idTable =  @id1 and a.status=0
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS 
	SElect*FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_GetUnCheckTable]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetUnCheckTable]
@idtable int
as
begin
	SELECT * FROM dbo.Bill Where idTable = @idtable AND status =0
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[USP_InsertBill]
@idTable int
AS
BEGIN
	INSERT dbo.Bill
			(DateCheckIn,
			DateCheckOut,
			idTable,
			status,
			Discount
			)
	VALUES (GETDATE(),
			NULL,
			@idTable,
			0,
			0
			)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE   PROC [dbo].[USP_InsertBillInfo]
@idBill int,@idFood int,@count int
AS
BEGIN
	DECLARE @isExistsBillInfo INT
	DECLARE @foodCount INT =1
	SELECT @isExistsBillInfo=id ,@foodCount= a.count from dbo.BillInfo as a Where idBill=@idBill and idFood=@idFood
	if(@isExistsBillInfo>0)
		Begin
			DECLARE @newCount Int=@foodCount+@count
			if(@newCount >0)
				Update dbo.BillInfo SET count=@foodCount+@count where idFood=@idFood and idBill=@idBill
			Else
				DELETE from dbo.BillInfo   Where idBill=@idBill and  idFood=@idFood
		End
	ELSE
		Begin
			INSERT dbo.BillInfo(idBill,idFood,count)
			VALUES(@idBill,@idFood,@count)
		End
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThanhToanLuong]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_ThanhToanLuong] (@idEmployee int)
as
begin
	declare @thoigianlamviec float=0
	SELECT @thoigianlamviec=workingEmployye from dbo.Employee  where idEmployee=@idEmployee
	if(@thoigianlamviec<1)
	begin
		DECLARE @err varchar(MAX)
		SELECT @err =  'Working time must greater than 1 hour'
		RAISERROR(@err, 16,1)
	end
	else 
		Update dbo.Employee set workingEmployye=0 where idEmployee=@idEmployee		
end

GO
/****** Object:  StoredProcedure [dbo].[USP_ThemNhanVien1]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedure Them Nhan Vien
CREATE   PROCEDURE [dbo].[USP_ThemNhanVien1] (@HoTen nvarchar(50), @NgaySinh DateTime)
AS
BEGIN

	
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
	INSERT INTO dbo.Employee(nameEmpployee, birthEmployye) VALUES 
	(@HoTen,@NgaySinh);
	--EXEC GanQuyenNhanVien @maNV		

	COMMIT TRAN
	END TRY
	BEGIN CATCH
	ROLLBACK
	DECLARE @err varchar(MAX)
	SELECT @err = 'Lỗi: ' + ERROR_MESSAGE()
	RAISERROR(@err, 16,1)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XoaDangNhap]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[USP_XoaDangNhap] (@LoginName NVARCHAR(100), @password NVARCHAR(1000) ,@type int)
AS
BEGIN
	
	
	DECLARE @err varchar(MAX)
	declare @count int =0
	BEGIN TRAN
	if(@type=0)
		begin	
			select @count = COUNT(*) from dbo.Account where Type=0
			
		end
	delete dbo.Account where Username=@LoginName 
	if(@count=1)
		begin
			RollBack 
			SELECT @err='Admin account must be available at least 1'
			RAISERROR(@err, 16,1)
		end
	else
		Commit Tran
END
GO
/****** Object:  Trigger [dbo].[CreateSQLAccount]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   TRIGGER [dbo].[CreateSQLAccount] ON [dbo].[Account]
after INSERT
AS
	DECLARE @userName nvarchar(30), @passWord nvarchar(10), @type int
	SELECT @userName=nl.UserName, @passWord=nl.Password, @type = nl.Type
	FROM inserted nl
	BEGIN

		DECLARE @sqlString nvarchar(2000)
		-- Tạo tài khoản login cho nhân viên, tên người dùng và mật khẩu là tài khoản  được tạo trên bảng Đăng nhập
		SET @sqlString= 'CREATE LOGIN [' + @userName +'] WITH PASSWORD='''+ @passWord 
		+''', DEFAULT_DATABASE=[QuanLyQuanCafe1], CHECK_EXPIRATION=OFF, 
		CHECK_POLICY=OFF'
		EXEC (@sqlString)
		-- Tạo tài khoản người dùng đối với nhân viên đó trên database (tên người dùng trùng với tên login)
		SET @sqlString= 'CREATE USER ' + @userName +' From LOGIN '+ @userName
		EXEC (@sqlString)

	END
GO
ALTER TABLE [dbo].[Account] ENABLE TRIGGER [CreateSQLAccount]
GO
/****** Object:  Trigger [dbo].[DeleteSqlAccount]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   TRIGGER [dbo].[DeleteSqlAccount] ON [dbo].[Account]
after delete
AS
	DECLARE @userName nvarchar(30), @passWord nvarchar(10), @type int,@count int
	SELECT @userName=nl.UserName, @passWord=nl.Password, @type = nl.Type
	FROM deleted nl
	BEGIN
		

		DECLARE @sqlString nvarchar(2000)
		-- Tạo tài khoản login cho nhân viên, tên người dùng và mật khẩu là tài khoản  được tạo trên bảng Đăng nhập
		SET @sqlString= 'Drop LOGIN ' + @userName 
		EXEC (@sqlString)
		-- Tạo tài khoản người dùng đối với nhân viên đó trên database (tên người dùng trùng với tên login)
		SET @sqlString= 'Drop USER ' + @userName 
		EXEC (@sqlString)

	END
GO
ALTER TABLE [dbo].[Account] ENABLE TRIGGER [DeleteSqlAccount]
GO
/****** Object:  Trigger [dbo].[UpdateBill]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   TRIGGER [dbo].[UpdateBill] 
on [dbo].[Bill] for UPDATE,DELETE
AS
BEGIN
	DECLARE @idbill INT
	SELECT @idbill = id FROM Inserted
	DECLARE @idtable INT
	SELECT @idtable =idTable FROM dbo.Bill WHERE id=@idbill AND status=1
	UPDATE dbo.TableFood set status=N'Free' where id=@idTable
	
	
END 
GO
ALTER TABLE [dbo].[Bill] ENABLE TRIGGER [UpdateBill]
GO
/****** Object:  Trigger [dbo].[UpdateBillInfo]    Script Date: 24/05/2023 4:24:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--DELETE dbo.BillInfo
--delete dbo.Bill
--DBCC CHECKIDENT ('dbo.Bill', RESEED, 0)
--DBCC CHECKIDENT ('dbo.BillInfo', RESEED, 0)

--SElect*From DBO.Bill 
--Go
--SElect*From dbo.BillInfo
--SELECT MAX (id) FROM dbo.Bill
--GO 
--SELECT*FROM dbo.FoodCategory
--GO 
--SELECT*FROM dbo.Food
--Go


--UPDATE dbo.Bill set status =1 where id=1
--GO 

CREATE   TRIGGER [dbo].[UpdateBillInfo] 
on [dbo].[BillInfo] for INSERT,UPDATE
AS
BEGIN
	declare @idBill INT
	select @idBill=idBill from inserted
	declare @idTable int 
	select @idTable=idTable from.dbo.Bill where id=@idBill and status=0
	Update dbo.TableFood set status=N'In using' where id=@idTable
END 
GO
ALTER TABLE [dbo].[BillInfo] ENABLE TRIGGER [UpdateBillInfo]
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe1] SET  READ_WRITE 
GO
