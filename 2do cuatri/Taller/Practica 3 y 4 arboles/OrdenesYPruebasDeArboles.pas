
Program arboles;
Type
  arbol = ^nodo;
  nodo = record
          dato: integer;
          hi: arbol;
          hd: arbol;
         end;

{}
Procedure agregar(var a:arbol; num:integer);
Begin
  if (a = nil) then
   begin
      new(a);
      a^.dato:= num; a^.hi:= nil; a^.hd:= nil;
   end
   else
    if (num <= a^.dato) then agregar(a^.hi,num)
    else agregar (a^.hd,num);   
End;


{En preorden, la raíz se recorre antes que los recorridos de los subárboles izquierdo y derecho}
Procedure preOrden (a:arbol);
begin
   if ( a <> nil ) then 
     begin
      write (a^.dato);
      preOrden (a^.hi);
      preOrden (a^.hd);
   end;
end;

{Se respeta el orden en el que los datos fueron agregados al arbol. 
* 	NO HABLAMOS DEL ORDEN DE LECTURA, SINO DE CARGA.
* Nosotros podriamos leer los numeros en cualquier orden pero al trabajar con ABB, 
* los datos los cargamos con algun criterio. Este algoritmo recorre el arbol en ese orden
* que nosotros intencionalmente programamos con X criterio (comunmente menor a mayor).}

{la raíz se recorre entre los recorridos de los árboles izquierdo y derecho}
Procedure enOrden ( a : arbol );
begin
   if ( a <> nil ) then begin
    enOrden (a^.hi);
    write (a^.dato); //o cualquier otra acción
    enOrden (a^.hd);
   end;
end;

{En postorden, la raíz se recorre después de los recorridos por el subárbol izquierdo y el derecho}
Procedure postOrden (a:arbol);
begin
   if ( a <> nil ) then 
     begin
      postOrden (a^.hi);
      postOrden (a^.hd);
      write (a^.dato);
   end;
end;

{Para buscar valor mas grande, yendo siempre por derecha}
function MasGrande(a: arbol): integer;
begin
  if (a^.hd = nil) then 
     MasGrande:= a^.dato

  else MasGrande:= MasGrande(a^.hd);
end;

{Para meter un nro y decir si existe o no en el arbol}
function existeOno(a: arbol; valor: integer): boolean;
begin
    if (a<>nil) then begin
    
		if (valor < a^.dato) then existeOno:= existeOno(a^.hi, valor)
		
        else
        
			if (a^.dato = valor) then existeOno:= True
			
			else existeOno:= existeOno(a^.hd, valor);
    end
    
    else existeOno:= False;

end;

{Contar cantidad de nodos}
procedure cantidadDeNodos(a: arbol; var cant: integer);
begin
	if a <> nil then begin
		cantidadDeNodos(a^.hi, cant);
		cant:= cant + 1;
		cantidadDeNodos(a^.hd, cant);
		end;
end;


{sumar valores de los nodos}
procedure sumar(a: arbol; var suma: integer);
begin
	if a <> nil then begin
		sumar(a^.hi, suma);
		
		suma:= suma + a^.dato;
	
		sumar(a^.hd, suma);
		end;
end;


{Mostrar valores de forma decreciente:
* Simplemente empezamos a recorrer el arbol de derecha a izquierda}
procedure informarDecreciente(a: arbol);
begin
	if a <> nil then begin
		informarDecreciente(a^.hd);
		
		writeln(a^.dato);
			
		informarDecreciente(a^.hi);
		end;
end;



{} {}
Var
 a: arbol;  num, i, n, max, cant, suma: integer;
	ok: boolean;
Begin
	Randomize;
  a:= nil; 
	num:= 1;

  for i:=1 to 10 do
   begin
    agregar (a,num); 
    num:= random(9);
   end;
	
	writeln('Ingresando los datos de mayor a menor');
	writeln('ordenado: ');
	enOrden(a);
	
	writeln('');
	writeln('');
	writeln('PreOrden');
	preOrden(a);
	
	writeln('');
	writeln('');
	writeln('PostOrden');
	postOrden(a);
	
	writeln('');
	writeln('');
	max:= MasGrande(a);
	writeln('Mas grande: ', max);
	
	write('valor a buscar: '); read(n);
	ok:= existeOno(a, n);
	writeln(ok);
	
	writeln('');
	writeln('');
	cant:=0;
	cantidadDeNodos(a, cant);
	writeln('Cantidad de nodos: ', cant); 
	
	writeln('');
	writeln('');
	suma:= 0;
	sumar(a, suma);
	writeln('Suma total:', suma);
	
	writeln('');
	writeln('');
	writeln('Informar Decreciente: ');
	informarDecreciente(a);
	
	
	
End.

