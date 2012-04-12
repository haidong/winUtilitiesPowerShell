USE
[myDb]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[serverDiskInfo]') AND type in (N'U'))
DROP TABLE [dbo].[serverDiskInfo]
GO
CREATE TABLE [dbo].[serverDiskInfo](
[ID] [int]
IDENTITY(1,1) NOT NULL,
[serverName] [varchar]
(20) NOT NULL,
[driveLetter] [char]
(1) NOT NULL,
[diskFormat] [varchar]
(10) NULL,
[diskLabel] [varchar]
(50) NULL,
[diskTotalSize] [int]
NOT NULL,
[diskAvailableSize] [int]
NOT NULL,
[collectionTime] [smalldatetime]
NOT NULL,
CONSTRAINT [PK_serverDiskInfo] PRIMARY KEY CLUSTERED
( [ID] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[serverDiskInfo] ADD CONSTRAINT [DF_serverDiskInfo_collectionTime] DEFAULT (getdate()) FOR [collectionTime]
GO
--INSERT INTO serverDiskInfo (serverName, driveLetter, diskFormat, diskLabel, diskTotalSize, diskAvailableSize) VALUES ('myServer', 'C', 'NTFS', '', 136.69, 52.31)
CREATE procedure [dbo].[serverDiskInfoInsert]
@serverName [varchar] (20),
@driveLetter [char] (1),
@diskFormat [varchar] (10),
@diskLabel [varchar] (50),
@diskTotalSize [int] ,
@diskAvailableSize [int]
AS
INSERT
INTO serverDiskInfo (serverName, driveLetter, diskFormat, diskLabel, diskTotalSize, diskAvailableSize) VALUES ( @serverName ,
@driveLetter
,@diskFormat
,@diskLabel
,@diskTotalSize
,@diskAvailableSize)
