IF DB_ID(N'$(DBNAME)') IS NULL
BEGIN
    DECLARE @sql nvarchar(max) = N'CREATE DATABASE [' + N'$(DBNAME)' + N']';
    EXEC (@sql);
END
GO
