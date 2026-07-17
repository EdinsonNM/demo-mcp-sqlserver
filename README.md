# Demo SQL Server (Docker)

Levanta una instancia de Microsoft SQL Server 2022 en Docker y crea automaticamente
la base de datos `DemoDB` (o la que definas en `.env`).

## Uso

```bash
cd demo
docker compose up -d
```

Esto levanta:
- `mssql-demo`: el contenedor de SQL Server (puerto expuesto segun `.env`).
- `mssql-demo-init`: un job que espera a que SQL Server este saludable y crea la
  base de datos indicada en `MSSQL_DATABASE` si no existe. Termina y queda "Exited (0)".

Para detener:

```bash
docker compose down
```

Para borrar tambien los datos persistidos:

```bash
docker compose down -v
```

## Parametros de conexion

Definidos en [`.env`](.env):

| Parametro | Valor por defecto     |
|-----------|-----------------------|
| Server    | `localhost`           |
| Port      | `1433`                |
| Database  | `DemoDB`              |
| User      | `sa`                  |
| Password  | `YourStrong!Passw0rd` |

> Cambia `MSSQL_PASSWORD` en `.env` antes de usar esto fuera de tu maquina local.
> SQL Server exige contrasenas fuertes (mayuscula, minuscula, numero y simbolo, 8+ caracteres).

## Cadenas de conexion de ejemplo

**ADO.NET / .NET**
```
Server=localhost,1433;Database=DemoDB;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=True;
```

**Node.js (`mssql`)**
```js
{
  server: "localhost",
  port: 1433,
  database: "DemoDB",
  user: "sa",
  password: "YourStrong!Passw0rd",
  options: { trustServerCertificate: true }
}
```

**Python (`pyodbc`)**
```
DRIVER={ODBC Driver 18 for SQL Server};SERVER=localhost,1433;DATABASE=DemoDB;UID=sa;PWD=YourStrong!Passw0rd;TrustServerCertificate=yes;
```

**JDBC**
```
jdbc:sqlserver://localhost:1433;databaseName=DemoDB;user=sa;password=YourStrong!Passw0rd;encrypt=true;trustServerCertificate=true;
```

## Notas

- Imagen usada: `mcr.microsoft.com/mssql/server:2022-latest`.
- Los datos persisten en el volumen `mssql-data` entre reinicios.
- Si cambias `MSSQL_DATABASE` en `.env`, el job `mssql-init` creara esa base de datos.
