CREATE OR REPLACE FUNCTION func_existeixclient (par_clie INTEGER)
    RETURNS BOOLEAN AS
    $$
    DECLARE
        var_clie CLIENTES.NUM_CLIE%TYPE;
    BEGIN
        SELECT num_clie
        INTO STRICT var_clie
        FROM clientes
        WHERE num_clie = par_clie;

        RETURN TRUE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
            WHEN OTHERS THEN
              RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$ LANGUAGE plpgsql;

select func_existeixclient(2111);
select func_existeixclient(99);

CREATE OR REPLACE FUNCTION func_stockok (par_quantitat INTEGER, par_fab CHAR(3), par_prod CHAR(5))
    RETURNS BOOLEAN AS
    $$
    DECLARE
        var_existencies PRODUCTOS.EXISTENCIAS%TYPE;
    BEGIN
        SELECT existencias
        INTO STRICT var_existencies
        FROM productos
        WHERE id_fab = par_fab AND id_producto = par_prod;

        IF(par_quantitat >= var_existencies) THEN
            return FALSE;
        ELSE
            return TRUE;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
            WHEN OTHERS THEN
              RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$ LANGUAGE plpgsql;

select func_stockok(210,'rei','2a45c');
select func_stockok(213,'rei','2a45c');
select func_stockok(209,'rei','2a45c');


SELECT existencias FROM productos WHERE id_fab = 'rei' AND id_producto = '2a45c';


CREATE TRIGGER trig_altacomanda BEFORE INSERT
ON pedidos
FOR EACH ROW
EXECUTE PROCEDURE func_altacomanda();

CREATE OR REPLACE FUNCTION func_altacomanda()
   RETURNS TRIGGER
AS $$
BEGIN
    IF  func_existeixclient(NEW.clie) IS FALSE THEN
        RAISE EXCEPTION 'El client % no existeix', NEW.clie;
    ELSIF func_stockok(NEW.cant,NEW.fab,NEW.producto) IS FALSE THEN
        RAISE EXCEPTION  'No hi ha prou stock del producte %', NEW.producto;
    ELSE
        RAISE NOTICE 'stock abans %', (SELECT existencias FROM productos WHERE id_fab = NEW.fab AND id_producto = NEW.producto); -- ATENCIÓ
        UPDATE productos
        SET existencias = existencias - NEW.cant
        WHERE id_fab = NEW.fab AND id_producto = NEW.producto;
        RAISE NOTICE 'stock després %', (SELECT existencias FROM productos WHERE id_fab = NEW.fab AND id_producto = NEW.producto); -- ATENCIÓ
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

insert into pedidos values (12,now(),2111,105,'aci','41003',400,12.0);
insert into pedidos values (11,now(),2111,105,'aci','41003',200,12.0);