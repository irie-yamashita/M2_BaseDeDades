# M2_BaseDeDades

### Instal·lació POstgreSQL Portable

[Instal·lació PostgreSQL Portable Linux - Classroom](https://classroom.google.com/c/NzA1MTYyMjgyNDU1/m/NzI2NDA1NDEzOTI1/details)

[Instal·lació PostgreSQL Portable WINDOWS - Classroom](https://classroom.google.com/c/NzA1MTYyMjgyNDU1/m/NzI2NjI1NjE5OTgx/details)

```
cd C:\Users\Usuario\Desktop\PostgreSQL\pgsql\bin  
psql -U postgres
```
>[!WARNING]  
>Si no pots iniciar usuari prova de fer això:
>```sql
>   psql -U  irie.yamashita.7e8 -d postgres
>   \q
>```

### Iniciar PostgreSQl Portable
Inicio programa:  
`bash startSql.sh`

Ens connectem al client de PostgreSQL.  
`psql postgres`
  
-- Crea un **base de dades** anomenada training  
`CREATE DATABASE training;`

-- Crea un **usuari** amb **contrasenya** i perfil de **superusuari**   
`CREATE USER training WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'training';`

-- Assigna l'usuari training com a **propietari** de la BBDD training  
`ALTER DATABASE training OWNER TO training;`

-- Assigna tots els **privilegis** a l'usuari training sobre la BBDD training  
`GRANT ALL PRIVILEGES ON DATABASE training TO training;`

>[!NOTE]
> Compovació que base de dades s'ha creat: `\l`

>[!NOTE]
> Compovació que l'usuari s'ha creat: `\du`

Surto del client PostgreSQL  
`\q`

--Ara ens connectarem a la BBDD training amb l'usuari training.  
`psql -U training -W -d training`

>[!NOTE]
>Comprova quin usuari està connectat: `SELECT CURRENT_USER;`

Comencem a crear taules (següent apartat)

### ELIMINAR
`DROP DATABASE <database-name>;`


