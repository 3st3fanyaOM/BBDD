/*1. 
Crea una funci�n llamada borrarEmpleado que reciba por par�metro 
un c�digo empno y que si, existe dicho c�digo en la base de datos (tabla emp), 
borre dicho registro. Debe devolver "Registro borrado correctamente" si lo 
puede realizar, y si no, "No existe dicho c�digo".*/
set serveroutput on;
create or replace function borrarEmpleado (codigo emp.empno%type) return  varchar
is
    fila emp%rowtype;
begin
    select * into fila from emp where empno = codigo;
        if fila.empno = codigo then
            delete from emp where empno = codigo;
            return 'Registro borrado';
        end if;
exception
    when no_data_found then
        return 'No existe el c�digo';
end;
/

/*2. 
Crea un bloque de c�digo an�nimo que pida por teclado un c�digo empno, 
llame a la funci�n borrarEmpleado con dicho valor como par�metro, y 
finalmente muestre por la salida el mensaje recibido por dicha funci�n.*/

declare
    codigoEmpno emp.empno%type := &mete_un_codigo;
begin
    dbms_output.put_line(borrarEmpleado(codigoEmpno));
end;
/

/*3. 
Realiza una funci�n llamada actualizaNombreEmpleado que reciba por 
par�metros el c�digo empno del empleado a modificar, y el nuevo nombre 
que sustituye a su valor en ename de la tabla emp. Se debe comprobar que 
existe el empno correspondiente al c�digo pasado por par�metro, y solo si existe,
modificarlo. Debe devolver un mensaje indicando si se hizo o no el cambio de nombre.*/

create or replace function actualizaNombreEmpleado
    (codigo emp.empno%type, nombre emp.ename%type) return varchar
is
    empno emp.empno%type; 
    
begin
    select empno into empno from emp where empno = codigo;
    if codigo = empno then
        update emp set emp.ename = nombre where empno = codigo;
        return 'Actualizado';
    end if;
exception
    when no_data_found then
    return 'No se actualiz�';
    
end;
/



/*4. 
Realiza un bloque de c�digo an�nimo que llame a la funci�n actualizaNombreEmpleado 
que pida por teclado un c�digo empno y despu�s un ename, 
llame a la funci�n actualizaNombreEmpleado con dichos valores como par�metros, 
y finalmente muestre por la salida el mensaje recibido por dicha funci�n.*/

declare
    nombre emp.ename%type := '&dime_nombre';
    codigo emp.empno%type := &dime_codigo;
begin
    dbms_output.put_line(actualizaNombreEmpleado(codigo,nombre));
end;
/

/*5. 
Mejora la funci�n actualizaNombreEmpleado para que compruebe que el nombre 
pasado por par�metro no coincida con el ename (independientemente de que 
se escriba en may�sculas o min�sculas), y si coincide, la funci�n no debe 
hacer el update y sin embargo debe devolver el mensaje "No se ha actualizado el 
registro porque ese nombre es el que ten�a el empleado".*/



/*6. 
Se quiere un procedimiento mostrarAlReves que cuando se le llame 
desde un bloque de c�digo an�nimo con un par�metro, muestre por la 
salida de consola ese nombre al rev�s. Ej.: mostrarAlReves('HOLA') 
debe mostrar ALOH por la salida.*/