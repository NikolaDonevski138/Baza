USE [task_manager]
GO
/****** Object:  Table [dbo].[tblKredencijal]    Script Date: 03-Mar-19 10:34:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKredencijal](
	[id_korisnik] [int] IDENTITY(1,1) NOT NULL,
	[korisnickoIme] [nvarchar](20) NULL,
	[lozinka] [nvarchar](50) NULL,
	[aktiven] [bit] NULL,
 CONSTRAINT [PK_tblKredencijal] PRIMARY KEY CLUSTERED 
(
	[id_korisnik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOddel]    Script Date: 03-Mar-19 10:34:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOddel](
	[id_oddel] [int] IDENTITY(1,1) NOT NULL,
	[oddel] [nvarchar](20) NULL,
 CONSTRAINT [PK_tblOddel] PRIMARY KEY CLUSTERED 
(
	[id_oddel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPozicija]    Script Date: 03-Mar-19 10:34:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPozicija](
	[id_pozicija] [int] IDENTITY(1,1) NOT NULL,
	[pozicija] [nvarchar](25) NULL,
 CONSTRAINT [PK_tblPozicija] PRIMARY KEY CLUSTERED 
(
	[id_pozicija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 03-Mar-19 10:34:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[id_status] [int] IDENTITY(1,1) NOT NULL,
	[opis] [nvarchar](15) NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[id_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblVraboten]    Script Date: 03-Mar-19 10:34:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVraboten](
	[id_vraboten] [int] IDENTITY(1,1) NOT NULL,
	[id_pozicija] [int] NOT NULL,
	[id_oddel] [int] NOT NULL,
	[id_kredencijali] [int] NOT NULL,
	[ime] [nvarchar](20) NULL,
	[prezime] [nvarchar](50) NULL,
	[telefonski_br] [nvarchar](12) NULL,
	[adresa] [nvarchar](30) NULL,
	[grad] [nvarchar](20) NULL,
 CONSTRAINT [PK_tblVraboten_1] PRIMARY KEY CLUSTERED 
(
	[id_vraboten] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblVraboten] UNIQUE NONCLUSTERED 
(
	[id_pozicija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblVraboten_1] UNIQUE NONCLUSTERED 
(
	[id_kredencijali] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblVraboten_2] UNIQUE NONCLUSTERED 
(
	[id_oddel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblZadaca]    Script Date: 03-Mar-19 10:34:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblZadaca](
	[id_zadaca] [int] IDENTITY(1,1) NOT NULL,
	[id_vraboten] [int] NOT NULL,
	[id_status] [int] NOT NULL,
	[naslov] [nvarchar](20) NULL,
	[opis] [nvarchar](70) NULL,
	[proekt] [nvarchar](50) NULL,
	[odobrena] [bit] NULL,
	[estimacija] [int] NULL,
	[datum_kreiranje] [date] NULL,
	[datum_posledna_promena] [date] NULL,
 CONSTRAINT [PK_tblZadaca_1] PRIMARY KEY CLUSTERED 
(
	[id_zadaca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblKredencijal] ADD  CONSTRAINT [df_aktiven]  DEFAULT (N'0') FOR [aktiven]
GO
ALTER TABLE [dbo].[tblZadaca] ADD  CONSTRAINT [df_odobrena]  DEFAULT (N'0') FOR [odobrena]
GO
ALTER TABLE [dbo].[tblVraboten]  WITH CHECK ADD  CONSTRAINT [FK_tblVraboten_tblKredencijal1] FOREIGN KEY([id_kredencijali])
REFERENCES [dbo].[tblKredencijal] ([id_korisnik])
GO
ALTER TABLE [dbo].[tblVraboten] CHECK CONSTRAINT [FK_tblVraboten_tblKredencijal1]
GO
ALTER TABLE [dbo].[tblVraboten]  WITH CHECK ADD  CONSTRAINT [FK_tblVraboten_tblOddel] FOREIGN KEY([id_oddel])
REFERENCES [dbo].[tblOddel] ([id_oddel])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblVraboten] CHECK CONSTRAINT [FK_tblVraboten_tblOddel]
GO
ALTER TABLE [dbo].[tblVraboten]  WITH CHECK ADD  CONSTRAINT [FK_tblVraboten_tblPozicija] FOREIGN KEY([id_pozicija])
REFERENCES [dbo].[tblPozicija] ([id_pozicija])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblVraboten] CHECK CONSTRAINT [FK_tblVraboten_tblPozicija]
GO
ALTER TABLE [dbo].[tblZadaca]  WITH CHECK ADD  CONSTRAINT [FK_tblZadaca_tblStatus1] FOREIGN KEY([id_status])
REFERENCES [dbo].[tblStatus] ([id_status])
GO
ALTER TABLE [dbo].[tblZadaca] CHECK CONSTRAINT [FK_tblZadaca_tblStatus1]
GO
ALTER TABLE [dbo].[tblZadaca]  WITH CHECK ADD  CONSTRAINT [FK_tblZadaca_tblVraboten] FOREIGN KEY([id_vraboten])
REFERENCES [dbo].[tblVraboten] ([id_vraboten])
GO
ALTER TABLE [dbo].[tblZadaca] CHECK CONSTRAINT [FK_tblZadaca_tblVraboten]
GO
