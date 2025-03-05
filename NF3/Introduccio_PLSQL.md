# APUNTS Introducció al PL/SQL - RA5

## Estructura bàsica
Elements bàsics: `DO, DECLARE, BEGIN, END`

```sql
DO $$
DECLARE
    
BEGIN

END;
$$ language plpgsql;

```

Amb consulta:  
```sql
DO $$
DECLARE
    
BEGIN
    SELECT 
    INTO
    FROM
    WHERE

END;
$$ language plpgsql;

```


## Variables

### DECLARACIÓ 
La declaració la fem entre el `DECLARE` i el `BEGIN`:
```sql
DECLARE
    nom_variable tipus_variable;
    nom_variable tipus_variable := 'valor_inicial'; //la puc inicialitzar
```

Exemple:  
```sql
DECLARE
    V_oficio VARCHAR(9);
    V_total NUMERIC(9,2) := 0;
    V_valido BOOLEAN NOT NULL := TRUE; --que no accepti nulls
    v_comision CONSTANT NUMERIC(3) := 100; -- pot ser constant
```
> Per l'assignació put utilitzar `:=` o `=`.

>[IMPORTANT] També puc donar-li el tipus d'una columna/atribut en concret:  


Exemple: 
```sql
    var_nom EMPLOYEES.first_name%TYPE
```

### ASSIGNACIÓ AMB CONSULTA
Per poder assignar un valor d'una consulta a una variable he d'utilitzar el `INTO`:
```sql
BEGIN
    SELECT first_name
    INTO var_nom -- <---
    FROM employees
    WHERE employee_id = 100;
END
```

## RAISE NOTICE
Serveic per imprimir, com un `println` o un `console.log`, però no podem posar les variables directament, posem un `%`:

```plpgsql
RAISE NOTICE 'Hola %', var_nom; // Hola Joan
```

> Va a la part del `BEGIN`  




* **TIPUS**  
Tenim 2 tipus de variables:
- Variables tipus escalars
- Variables de tipus complexes
- Varaibles **NO PL/SQL** (explicades més endavant)


# TO DO
+ Tipus complexe: ROWTYPE, RECORD, TYPE
+ Funcions i procediments
