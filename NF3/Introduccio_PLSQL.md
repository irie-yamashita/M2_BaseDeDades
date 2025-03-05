# APUNTS Introducció al PL/SQL - RA5

## Estructura bàsica
Elements bàsics: `DO, DECLARE, BEGIN, END`

```plpgsql
DO $$
DECLARE
    
BEGIN

END;
$$ language plpgsql;

```


## VARIABLES

* **DECLARACIÓ** 
La declaració la fem entre el `DECLARE` i el `BEGIN`:
```plpgsql
DECLARE
    nom_variable tipus_variable;
    nom_variable tipus_variable := 'valor_inicial'; //la puc inicialitzar
```

Exemple:  
```plpgsql
DECLARE
    V_oficio VARCHAR(9);
    V_total NUMERIC(9,2) := 0;
    V_fecha DATE := CURRENT_DATE + 9; 
    V_valido BOOLEAN NOT NULL := TRUE; //que no accepti nulls
    v_comision CONSTANT NUMERIC(3) := 100; //pot ser constant
```

>[IMPORTANT] També puc donar-li el tipus d'una columna/atribut en concret:  

```plpgsql
    nom taula.columna%TYPE
```

Exemple: 
```plpgsql
    nom_empleat EMPLOYEES.first_name%TYPE
```


### VARIABLES ESCALARS




* **TIPUS**  
Tenim 2 tipus de variables:
- Variables tipus escalars
- Variables de tipus complexes
- Varaibles **NO PL/SQL** (explicades més endavant)



## RAISE NOTICE
Serveic per imprimir, com un `println` o un `console.log`, però no podem posar les variables directament, posem un `%`:

```plpgsql
RAISE NOTICE 'Hola %', var_nom; // Hola Joan
```

> Va a la part del `BEGIN`  
