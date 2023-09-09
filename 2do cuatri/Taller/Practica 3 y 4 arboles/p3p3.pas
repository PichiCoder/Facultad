
program p3p3;

type
nota_ = 1..10;

rFinal = record
	cod: integer;
	nota: nota_;
	end;

//lista para guardar codigo y nota de los finales
lFinales = ^nodol;  

nodol = record
	dato: rFinal;
	sig: lFinales;
	end;

//Lo que se guarda en el nodo del arbol
rAlumno = record
	legajo: integer;
	dni: integer;
	ingreso: integer;
	finales: lFinales; //no sabemos cuantos, es una lista.
	end;
	
aAlumnos = ^nodoa;

nodoa = record
	dato: rAlumno;
	hi: aAlumnos;
	hd: aAlumnos;
	end;
	
listaDeB = ^nodob;

rAluB = record
	dni: integer;
	legajo: integer;
	end;
	
nodob = record
	dato: rAluB;
	sig: listaDeB;
	end;

listaDeG = ^nodog;

rAluG = record
	pro: real;
	legajo: integer;
	end;
	
nodog = record
	dato: rAluG;
	sig: listaDeg;
	end;


{Para leer registro completo de un Alumno}
procedure leerAlumno(var r: rAlumno);

	{leer los finales del alumno, agregando adelante en la lista cada examen rendido}
	procedure leerFinales(var l: lFinales);
	
		{leer un final}
		procedure leerFinal(var r: rFinal);
		begin
			read(r.cod); read(r.nota);
		end;
		
	var f: rFinal; nuevo: lFinales;
	begin
		leerFinal(f);
		while f.cod <> -1 do begin
			new(nuevo); nuevo^.dato:= f; nuevo^.sig:= l; l:= nuevo;
			leerFinal(f);
			end;
	end;

var l: lFinales;
begin
	read(r.legajo); read(r.dni); read(r.ingreso);
	
	leerFinales(l); 
	//al terminar de agregar los finales, tengo que meter el puntero incial de la lista en el campo 'finales' del alumno!
	r.finales:= l;
end;


{Crear el arbol en el que cada nodo es un Alumno!}
procedure infoAlumnos(var a: aAlumnos);

	procedure cargarArbol(var a: aAlumnos; r: rAlumno);
	
	begin
		if a = nil then begin
			new(a); a^.dato:= r; a^.hi:= nil; a^.hd:= nil;
			end
		else 
			if r.legajo <= a^.dato.legajo then cargarArbol(a^.hi, r)
			else cargarArbol(a^.hd, r);
	end;
	
var r: rAlumno;	
begin
	leerAlumno(r); a:= nil;
	while r.legajo <> 0 do begin
		cargarArbol(a, r);
		leerAlumno(r);
		end;
end;


{para usar en el b) }
procedure listaParaB(var lb: listaDeB; leg: integer; dni: integer);
var nuevo: listaDeB;
begin
	new(nuevo); nuevo^.dato.dni:= dni; nuevo^.dato.legajo:= leg; 
	nuevo^.sig:= lb; lb:= nuevo;
end;	

{inciso b)
Recibe la estructura generada en a. Retorna los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior valor.}
{DUDA. Tengo que hacer un recorrido parcial del arbol respetando el orden <<<<----- CONSULTAR --------
* EL tema es como hago bien que corte e imprima bien cuando lo necesito}
procedure incisoB(a: aAlumnos; valor: integer; var lb: listaDeB);
begin
	if (a <> nil) then begin 
		
		{Nodo actual cumple con que sea menor al valor pedido ?}
		{Si no se cumple, seguimos por izquierda por las dudas porque 
		* puede pasar que hayan mas valores que si cumplan por ese lado}
		if a^.dato.legajo < valor then begin
			incisoB(a^.hi, valor, lb);
		
			listaParaB(lb, a^.dato.legajo, a^.dato.dni);
		
			incisoB(a^.hd, valor, lb);
			
			end
		
		else incisoB(a^.hi, valor, lb);
		
		end;
end;


{inciso c)

}
function legajoMasGrande(a: aAlumnos): integer;
begin
  if (a^.hd = nil) then 
     legajoMasGrande:= a^.dato.legajo

  else legajoMasGrande:= legajoMasGrande(a^.hd);
end;


{inciso d)

}
procedure dniMasGrande(a: aAlumnos; var dni: integer);
begin
	if a <> nil then begin
	
		dniMasGrande(a^.hi, dni);
		
		if a^.dato.dni > dni then dni:= a^.dato.dni;
			
		dniMasGrande(a^.hd, dni);
		
		end;
end;

{inciso e)

}
procedure legImpar(a: aAlumnos; var impares: integer);
begin
	if a <> nil then begin
	
		legImpar(a^.hi, impares);
		
		if (a^.dato.legajo MOD 2 <> 0) then impares:= impares + 1;
			
		legImpar(a^.hd, impares);
		
		end;
end;


{--------------- inciso f) ------------------}

{calcula el promedio de cada alumno segun su lista de notas}
procedure calcPromedio(l: lFinales; var prom: real);
var suma, cant: integer;
begin
	suma:= 0; cant:= 0;
	while l <> nil do begin
		suma:= suma + l^.dato.nota;
		cant:= cant + 1;
		end;
	prom:= suma / cant; //aca tendriamos el prom de un alumno ya calculado
end;

{Se recorre el arbol para comparar el promedio de cada alumno contra el maximo guardado y este se actualiza si es necesario}
procedure mejorProm(a: aAlumnos; var mejorPromedio: real; var legMejorProm: integer);
var prom: real;
begin
	if a <> nil then begin
	
		mejorProm(a^.hi, mejorPromedio, legMejorProm);
			
		calcPromedio(a^.dato.finales, prom);
			
		if prom > mejorPromedio then begin
			mejorPromedio:= prom;
			legMejorProm:= a^.dato.legajo;
			end;
				
		mejorProm(a^.hd, mejorPromedio, legMejorProm);
			
		end;
end;

{retorna lo pedido en el incisof) }
procedure legajoYpromMejorAlumno(a: aAlumnos);
var mejorPromedio: real;
	legMejorProm: integer;
begin
	mejorPromedio:= -1;
	
	mejorProm(a, mejorPromedio, legMejorProm);
	
	writeln(legMejorProm, mejorPromedio); // respondiendo el f)
end;



{--------------- inciso g) ------------------, reciclando lo que usamos para el f)}
{para usar en el g) }
procedure listaParaG(var lg: listaDeG; leg: integer; pro: real);
var nuevo: listaDeG;
begin
	new(nuevo); nuevo^.dato.pro:= pro; nuevo^.dato.legajo:= leg; 
	nuevo^.sig:= lg; lg:= nuevo;
end;	


procedure legajosYpromsMejoresAlumnos(a: aAlumnos; val: integer; var lg: listaDeG);
var prom: real;
begin
	if a <> nil then begin
	
		legajosYpromsMejoresAlumnos(a^.hi, val, lg);
			
		calcPromedio(a^.dato.finales, prom);
			
		if prom > val then listaParaG(lg, a^.dato.legajo, prom);
				
		legajosYpromsMejoresAlumnos(a^.hd, val, lg);
			
		end;
end;


var a: aAlumnos;
	valor, val, legajoMasG, dniMasG, impares: integer;
	lb: listaDeB;
	lg: listaDeG;
BEGIN

	infoAlumnos(a); // inciso a)
	
	readln(valor); lb:= nil;
	incisoB(a, valor, lb); // inciso b) 
	
	if a <> nil then legajoMasG:= legajoMasGrande(a);  // inciso c)
	
	dniMasG:= -1;
	dniMasGrande(a, dniMasG); // inciso d)
	
	impares:= 0;
	legImpar(a, impares); // inciso e)
	
	legajoYpromMejorAlumno(a);// inciso f)
	
	readln(val); lg:= nil;
	legajosYpromsMejoresAlumnos(a, val, lg);// inciso g)
	
END.

