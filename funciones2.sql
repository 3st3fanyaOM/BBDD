/*
Ejercicio 1
Haz una función llamada DevolverCodDept que reciba el nombre de un departamento y devuelva
su código
*/
set serveroutput on;
create or replace function DevolverCodDept (departamento dept.dname%type) return dept.deptno%type
is
    v_codigo dept.deptno%type;
begin
    select deptno into v_codigo from dept where dname = departamento;
    return v_codigo;
exception
    when no_data_found then
    dbms_output.put_line('No existe');
end;
/

declare
    nDept dept.dname%type := '&dime-departamento';
begin
    dbms_output.put_line(DevolverCodDept(nDept));
end;
/

/*
Ejercicio 2
Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de departamento,
muestre en pantalla el número de empleados de dicho departamento. Puedes utilizar la función
creada en el ejercicio 1.
Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el
departamento no existe se tratará la excepción correspondiente.
*/

create or replace procedure HallarNumEmp(pnombredepartamento dept.dname%type)
is
    total int;
    noexistedepartamento exception;
begin
    if DevolverCodDept(pnombredepartamento) != -1 then
        select count(*)
        into total
        from emp
        where deptno = DevolverCodDept(pnombredepartamento);
            if total != 0 then
                dbms_output.put_line(total);
            else
                dbms_output.put_line('No tiene empleados');
            end if;
    else
        raise noexistedepartamento;
    end if;
exception
    when noexistedepartamento then
    dbms_output.put_line('No existe ese departamento');
end;
/

declare
nomdept dept.dname%type := '&mete_nombre_departamento';
begin
HallarNumEmp(nomdept);
end;
/

/*
Ejercicio 3
Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
devuelva la suma de los salarios y comisiones de los empleados de dicho departamento. Trata
las excepciones que consideres necesarias.
*/

create or REPLACE function CalcularCosteSalarial (nombredepartamento dept.dname%type) return int
is
    total number (8,2);
   codigo dept.deptno%type;
begin
    codigo := DEVOLVERCODDEPT(nombredepartamento);
    select sum(sal+nvl(comm,0))
    into total 
    from emp 
    where deptno = codigo;
    if total is null then
        return 0;
    else
        return total;
    end if;
    
end;
/

/*
Ejercicio 4
Realiza un procedimiento MostrarCostesSalariales que muestre los nombres de todos los
departamentos y el coste salarial de cada uno de ellos. Puedes usar la función del ejercicio 3.
*/

create or replace procedure MostrarCostesSalariales
is
nDept dname.dept%type;
cursor cDept is
select dname into nDept from dept;

begin



end;








