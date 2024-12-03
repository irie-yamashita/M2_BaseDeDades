>[!WARNING]  
> Coses pendents:  
> * Canviar de varchar a numèric (apartat ALTER)
> * Practicar VISTES i ÍNDEXS
> * Repassar SEQÜÈNCIA
> * Data format Espanya


### Data format Espanya
```sql
-- Per canviar format data a Europeu posar: dd/mm/aaaa
SET DATESTYLE TO PostgreSQL,European;
SHOW datestyle;

-- Si volem canviar a model altre: SET DATESTYLE TO ISO;
```
