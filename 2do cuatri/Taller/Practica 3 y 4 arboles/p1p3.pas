
Program p1p3;

Type

rSocio = record
	nro: integer;
	nom: string;
	edad: integer;
	end;

arbol = ^nodo;

nodo = record
	dato: rSocio;
	hi: arbol;
	hd: arbol;
	end;

{}
procedure leerSocio(var r: rSocio);
begin
	read(r.nom); read(r.nro); read(r.edad);
end;

{}
procedure cargarArbol(var a: arbol; s: rSocio);
begin
	
	if (a = nil) then begin
		new(a); 
		a^.dato:= s; a^.hi:= nil; a^.hd:= nil;
		end
		
	else begin
		if s.nro <= a^.dato.nro then cargarArbol(a^.hi, s)
		
		else cargarArbol(a^.hd, s);
		
		end;
end;

{}
procedure CargarSocios(var a: arbol);
var s: rSocio;
begin
	a:= nil;
	leerSocio(s);
	while s.nro <> 0 do begin
		cargarArbol(a, s);
		leerSocio(s);
		end;
end;
	

{i}
function NroSocioMasGrande(a: arbol): integer;
begin
	if ( a <> nil ) then begin 
	
		if (a^.hd <> nil) then NroSocioMasGrande:= NroSocioMasGrande(a^.hd)
		
		else NroSocioMasGrande:= a^.dato.nro;
			
		end;
end;


{ii}
function NroSocioMasChico(a: arbol): integer;
begin
	if ( a <> nil ) then begin 
	
		if (a^.hi <> nil) then NroSocioMasChico:= NroSocioMasChico(a^.hi)
		
		else NroSocioMasChico:= a^.dato.nro;
			
		end;
end;
 
 
{iii}
procedure NroSocioMayorEdad(a: arbol; var max: integer; var numSocio: integer);
	begin
		
		if a <> nil then begin
			NroSocioMayorEdad(a^.hi, max, numSocio);
			if a^.dato.edad > max then begin
				max:= a^.dato.edad;
				numSocio:= a^.dato.nro;
				end;
			NroSocioMayorEdad(a^.hd, max, numSocio);
			end;
		
	end;

{iv}
procedure AumentarEdadEn1(a: arbol);
	begin
		
		if a <> nil then begin
			AumentarEdadEn1(a^.hi);
			
			a^.dato.edad:= a^.dato.edad + 1;
			
			AumentarEdadEn1(a^.hd);
			end;
		
	end;



{v}
function existeOno(a: arbol; valor: integer): boolean;
begin
    if (a<>nil) then begin
    
		if (valor < a^.dato.nro) then existeOno:= existeOno(a^.hi, valor)
		
        else
        
			if (a^.dato.nro = valor) then existeOno:= True
			
			else existeOno:= existeOno(a^.hd, valor);
    end
    
    else existeOno:= False;

end;


{vi}
function nombreExisteOno(a: arbol; nom: string): boolean;
begin
    if (a<>nil) then begin
    
		nombreExisteOno:= nombreExisteOno(a^.hi, nom);
		
		if (nom = a^.dato.nom) then nombreExisteOno:= True;
		
        nombreExisteOno:= nombreExisteOno(a^.hd, nom);
        
        end
    
    else nombreExisteOno:= False;

end;

{vii}
procedure cantSocios(a: arbol; var cant: integer);
begin
	if a <> nil then begin
		cantSocios(a^.hi, cant);
		cant:= cant + 1;
		cantSocios(a^.hd, cant);
		end;
end;


{para el viii}
procedure sumarEdades(a: arbol; var suma: integer);
begin
		if a <> nil then begin
			sumarEdades(a^.hi, suma);
			
			suma:= suma + a^.dato.edad;
			
			sumarEdades(a^.hd, suma);
			end;
end;

{viii}
function promEdad(a: arbol): real;
var cant, suma: integer;
begin
	cant:=0; suma:=0;
	cantSocios(a, cant);
	sumarEdades(a, suma);
	promEdad:= suma / cant;
	
end;

{ix}
procedure informarCreciente(a: arbol);
begin
	
	if a <> nil then begin
		informarCreciente(a^.hi);
		
		writeln(a^.dato.nro);
			
		informarCreciente(a^.hd);
		end;
		
end;

{x}
procedure informarDecreciente(a: arbol);
begin
	if a <> nil then begin
		informarDecreciente(a^.hd);
		
		writeln(a^.dato);
			
		informarDecreciente(a^.hi);
		end;
end;

 
{} {}
var a: arbol;
	max, min, mayor, numSocio, valor, cant: integer;
	existeNro, existeNom: boolean; 
	nombre: string;
	edadPromedio: real;
begin
	
	CargarSocios(a); // a)
	
	{ Todo del b) }
	max:= NroSocioMasGrande(a); // i) 
	
	min:= NroSocioMasChico(a); // ii) 
	
	mayor:=-1;
	NroSocioMayorEdad(a, mayor, numSocio); // iii)
	write('Numero de socio con mayor edad: ', numSocio);
	
	AumentarEdadEn1(a); // iv)
	
	readln(valor);
	existeNro:= existeOno(a, valor); // v)
	
	readln(nombre);
	existeNom:= nombreExisteOno(a, nombre); // vi)
	
	cant:=0;
	cantSocios(a, cant); // vii)
	
	edadPromedio:= promEdad(a); // viii)
	
end.
