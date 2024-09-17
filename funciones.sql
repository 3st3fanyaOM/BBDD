/*1. 
Crea una función llamada borrarEmpleado que reciba por parámetro 
un código empno y que si, existe dicho código en la base de datos (tabla emp), 
borre dicho registro. Debe devolver "Registro borrado correctamente" si lo 
puede realizar, y si no, "No existe dicho código".*/
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
        return 'No existe el código';
end;
/

/*2. 
Crea un bloque de código anónimo que pida por teclado un código empno, 
llame a la función borrarEmpleado con dicho valor como parámetro, y 
finalmente muestre por la salida el mensaje recibido por dicha función.*/

declare
    codigoEmpno emp.empno%type := &mete_un_codigo;
begin
    dbms_output.put_line(borrarEmpleado(codigoEmpno));
end;
/

/*3. 
Realiza una función llamada actualizaNombreEmpleado que reciba por 
parámetros el código empno del empleado a modificar, y el nuevo nombre 
que sustituye a su valor en ename de la tabla emp. Se debe comprobar que 
existe el empno correspondiente al código pasado por parámetro, y solo si existe,
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
    return 'No se actualizó';
    
end;
/



/*4. 
Realiza un bloque de código anónimo que llame a la función actualizaNombreEmpleado 
que pida por teclado un código empno y después un ename, 
llame a la función actualizaNombreEmpleado con dichos valores como parámetros, 
y finalmente muestre por la salida el mensaje recibido por dicha función.*/

declare
    nombre emp.ename%type := '&dime_nombre';
    codigo emp.empno%type := &dime_codigo;
begin
    dbms_output.put_line(actualizaNombreEmpleado(codigo,nombre));
end;
/

/*5. 
Mejora la función actualizaNombreEmpleado para que compruebe que el nombre 
pasado por parámetro no coincida con el ename (independientemente de que 
se escriba en mayúsculas o minúsculas), y si coincide, la función no debe 
hacer el update y sin embargo debe devolver el mensaje "No se ha actualizado el 
registro porque ese nombre es el que tenía el empleado".*/



/*6. 
Se quiere un procedimiento mostrarAlReves que cuando se le llame 
desde un bloque de código anónimo con un parámetro, muestre por la 
salida de consola ese nombre al revés. Ej.: mostrarAlReves('HOLA') 
debe mostrar ALOH por la salida.*/