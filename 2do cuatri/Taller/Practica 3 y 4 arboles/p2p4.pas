program p2p4;

type 
dia = 1..31;
mes = 1..12;		

rPrestamo = record
	isbn: integer; // identificacion del libro
	socio: integer;
	dd: dia;
	mm: mes;
	cant: integer; //cant de dias prestados
	end;


aPrestamos = ^nodoP; // arbol para los prestamos 

nodoP = record
	datoP: rPrestamo;
	hi: aPrestamos;
	hd: aPrestamos;
	end;
	
listaPrestamos = ^nodolibros; //para ir agregando los prestamos correspondientes a cada ISBN distinto.

nodolibros = record
	dato: rPrestamo;
	sig: listaPrestamos;
	end;	
	
aLibros = ^nodoL; // arbol donde cada nodo es una lista de prestamos de un ISBN.

nodoL = record
	datoL: listaPrestamos; // en cada nodo tenes una lista. Siempre del mismo ISBN obviamente.
	hi: aLibros;
	hd: aLibros;
	end;

//para lista del f) y el g)	
lISBN = ^nodoI;

rISBN = record
	isbn: integer;
	totalPrest: integer;
	end;

nodoI = record
	datoI: rISBN;
	sig: lISBN;
	end; 
	
	
procedure cargarArboles(var aP: aPrestamos; var aL: aLibros);
	
	{para insertar los prestamos de cada libro en un arbol, donde cada nodo es una lista de los prestamos del correspondiente libro}
	procedure insertarLibro(var aL: aLibros; p: rPrestamo);
	
		procedure agregarPrestamoAListaDelNodo(var l: listaPrestamos; p: rPrestamo);
		var nuevo: listaPrestamos;
		begin
			new(nuevo); nuevo^.dato:= p; nuevo^.sig:= l; l:= nuevo;
			
		end;
 
	begin
	
		{si el nodo del arbol es nil entonces no hay ninguna lista correspondiente al ISBN, 
		* por ende incializo una nueva y agrego el primer nodo de la lista al llamar a agregarLibroAListaDelNodo(lista, p)}
		if aL = nil then begin
			new(aL); aL^.hi:= nil; aL^.hd:= nil;
   
			aL^.datoL:= nil;
			
			agregarPrestamoAListaDelNodo(aL^.datoL, p);
			
			end
			
		else begin
			{aca tengo que evaluar si en el nodo en el que estoy parado (lista de prestamos), su ISBN coincide con el del nuevo prestamo ingresado.
			* 
			* Pensando: al tener aL^.dato estaria parado en en el puntero de la lista,
			* 
			*  entonces haciendo esto ---> aL^.datoL^.dato.isbn  accedo asi: 
			* 
			* aL^.datoL^ = Nodo del arbol, puntero de la lista, que contiene dato que es el registro y este ultimo contiene el campo isbn}
			
			if aL^.datoL^.dato.isbn = p.isbn then agregarPrestamoAListaDelNodo(aL^.datoL, p)

			else
			
				if p.isbn < aL^.datoL^.dato.isbn then insertarLibro(aL^.hi, p)
				
				else insertarLibro(aL^.hd, p);
				
			end;
			
	end;
	
	{para insertar prestamos en el arbol donde cada nodo es un rPrestamo}
	procedure insertarPrestamo(var aP: aPrestamos; p: rPrestamo);
	begin
		if aP = nil then begin
		
			new(aP); aP^.datoP:= p; aP^.hi:= nil; aP^.hd:= nil;
			
			end
			
		else begin
		
			if (p.isbn <= aP^.datoP.isbn) then begin 
				insertarPrestamo(aP^.hi, p);
				end
			
			else insertarPrestamo(aP^.hd, p); 
			
			end;
	end;
	
	procedure leerPrestamo(var r: rPrestamo);
	begin
		read(r.isbn); read(r.socio); read(r.dd); read(r.mm); read(r.cant);
	end;
	
var p: rPrestamo;	
begin
	
	aL:= nil; aP:= nil;
	
	leerPrestamo(p);
	
	while p.isbn <> -1 do begin
	
		insertarPrestamo(aP, p);
		
		insertarLibro(aL, p);
		
		leerPrestamo(p);
		end;
	
end;


{inciso b)}
procedure isbnMasGrande(aP: aPrestamos; var masG: integer);
begin
	if aP <> nil then begin
	
		if aP^.hd <> nil then isbnMasGrande(aP^.hd, masG)
		
		else masG:= aP^.datoP.isbn;
		
		end
		
	else masG:= -1;
				
end;

{inciso c)}
procedure isbnMasChico(aL: aLibros; var masC: integer);
begin
	if aL <> nil then begin
	
		if aL^.hi <> nil then isbnMasChico(aL^.hi, masC)
		
		else masC:= aL^.datoL^.dato.isbn;
		
		end
		
	else masC:= -1;
				
end;


// inciso d)
procedure prestamosAUnSocioEni(aP: aPrestamos; nroSocio: integer; var cantPresASocio: integer);
begin
	if aP <> nil then begin
	
		prestamosAUnSocioEni(aP^.hi, nroSocio, cantPresASocio);
		
		if nroSocio = aP^.datoP.socio then cantPresASocio:= cantPresASocio + 1;
		
		prestamosAUnSocioEni(aP^.hd, nroSocio, cantPresASocio);
	
		end
	
	else cantPresASocio:= 0;
	
end;


// inciso e)

procedure recorrerListaDePrestamos(l: listaPrestamos; nroSocio: integer; var cantPresASocio: integer);
begin
	while l <> nil do begin
	
		if nroSocio = l^.dato.socio then cantPresASocio:= cantPresASocio + 1;
		
		l:= l^.sig;
		end;
end;

procedure prestamosAUnSocioEnii(aL: aLibros; nroSocio: integer; var cantPresASocio: integer);
begin
	if aL <> nil then begin
	
		prestamosAUnSocioEnii(aL^.hi, nroSocio, cantPresASocio);
		
		{Este modulo va a recorrer la lista de cada ISBN para contar cuantas veces aparece el nroSocio buscado}
		{Recibe: 
		* el dato del nodo, que es el puntero de la lista,
		* el nro a comparar,
		* y la variable que cuenta para aprovechar!! }
		recorrerListaDePrestamos(aL^.datoL, nroSocio, cantPresASocio);
		
		prestamosAUnSocioEnii(aL^.hd, nroSocio, cantPresASocio);
	
		end
	
	else cantPresASocio:= 0;
	
end;	
	
	
	

{------------------------- inciso f) ---------------------------}
{Un módulo que reciba la estructura generada en i (aPrestamos) y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
}
procedure TotalPrestamosISBNeni(aP: aPrestamos; var l: lISBN);

	{mientras hacia el g tambien me di cuenta de que esto podria retornar una lista}
	procedure insertarEnaI(isbn: integer; var l: lISBN);
	var libro: rISBN; nuevo: lISBN;
	begin
		
		if l = nil then begin
		
			libro.isbn:= isbn; libro.totalPrest:= 1; new(nuevo); nuevo^.datoI:= libro; nuevo^.sig:= l; l:= nuevo;
			
			end
			
		else begin
		
			if l^.datoI.isbn = isbn then l^.datoI.isbn:= l^.datoI.isbn + 1
			
			else insertarEnaI(isbn, l^.sig);
				
			end;
	end;

begin
	if aP <> nil then begin
		TotalPrestamosISBNeni(aP^.hi, l);
		
		{este modulo recibe el isbn del nodo actual para comparar y agregar un isbn nuevo en el arbol nuevo o sumarle 1}
		insertarEnaI(aP^.datoP.isbn, l);
		
		TotalPrestamosISBNeni(aP^.hd, l);
	
	end
	
	else l:= nil;

end;



{------------------------- inciso g) ---------------------------}

procedure recorrerListaDePrestamos(lp: listaPrestamos; var cantDePrestamos: integer);
begin
	cantDePrestamos:= 0;
	while lp <> nil do begin

		cantDePrestamos:= cantDePrestamos + 1;
			
		lp:= lp^.sig;
		end;
end;

{Esto tiene que retornar lo mismo que el f) pero partimos de un arbol donde ya tenemos la lista de prestamos totales al ISBN}
procedure TotalPrestamosISBNenii(aL: aLibros; var l: lISBN);	

	{Me di cuenta que lo que se devuelve aca puede ser tranquilamente una lista, que queda ordenada, porque recibe los ISBN en orden}
	procedure insertarEnaIparaii(isbn: integer; var l: lISBN; cantDePrestamos: integer);
	var libro: rISBN; nuevo: lISBN;
	begin
		
		if l = nil then begin
			
			libro.isbn:= isbn; libro.totalPrest:= cantDePrestamos; new(nuevo); nuevo^.datoI:= libro; nuevo^.sig:= l; l:= nuevo;
			
			end
			
		else insertarEnaIparaii(isbn, l^.sig, cantDePrestamos);

	end;
	
var cantDePrestamos: integer;
begin
	if aL <> nil then begin
		TotalPrestamosISBNenii(aL^.hi, l);
		
		{este modulo recibe la lista de todos los prestamos que tiene el isbn del nodo actual y devuelve cantidad de prestamos}
		recorrerListaDePrestamos(aL^.datoL, cantDePrestamos);
		
		{recibe isbn del arbol que estamos recorriendo (que es de listas), lista nueva y la cant de prestamos}
		insertarEnaIparaii(aL^.datoL^.dato.isbn, l, cantDePrestamos);
		
		TotalPrestamosISBNenii(aL^.hd, l);
	
	end
	
	else l:= nil;

end;


{i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
}

procedure prestamos_hechos_entre_ISBN_ingresados(aP: aPrestamos; isbn1, isbn2: integer; var total: integer);
begin
	if aP <> nil then begin
	
		if ((aP^.datoP.isbn >= isbn1) and (aP^.datoP.isbn <= isbn2)) then begin
			
			total:= total + 1;
			
			prestamos_hechos_entre_ISBN_ingresados(aP^.hi, isbn1, isbn2, total);
			
			prestamos_hechos_entre_ISBN_ingresados(aP^.hd, isbn1, isbn2, total);
			
			end
		
		else begin
		
			if aP^.datoP.isbn < isbn1 then prestamos_hechos_entre_ISBN_ingresados(aP^.hd, isbn1, isbn2, total)
		
			else prestamos_hechos_entre_ISBN_ingresados(aP^.hi, isbn1, isbn2, total)
			
			end;
		end;
end;

// inciso j)

procedure prestamos_hechos_entre_ISBN_ingresados_ii(aL: aLibros; isbn1, isbn2: integer; var total: integer);
var cantDePrestamos: integer;
begin
	if aL <> nil then begin
	
		if ((aL^.datoL^.dato.isbn >= isbn1) and (aL^.datoL^.dato.isbn <= isbn2)) then begin

			recorrerListaDePrestamos(aL^.datoL, cantDePrestamos); //reutilizando esto que ya habiamos usado para contar

			total:= total + cantDePrestamos;
			
			prestamos_hechos_entre_ISBN_ingresados_ii(aL^.hi, isbn1, isbn2, total);
			
			prestamos_hechos_entre_ISBN_ingresados_ii(aL^.hd, isbn1, isbn2, total);
			
			end
		
		else begin
		
			if (aL^.datoL^.dato.isbn < isbn1) then prestamos_hechos_entre_ISBN_ingresados_ii(aL^.hd, isbn1, isbn2, total)
		
			else prestamos_hechos_entre_ISBN_ingresados_ii(aL^.hi, isbn1, isbn2, total)
			
			end;
		end;
end;


var aP: aPrestamos;
	aL: aLibros;
	l: lISBN; //para arbol nuevo de f)
	masG, masC, cantPresASocio, nroSocio, isbn1, isbn2, total: integer;
BEGIN

	cargarArboles(aP, aL); // inciso a)
	
	isbnMasGrande(aP, masG); // inciso b)
	
	isbnMasChico(aL, masC); // inciso c)
	
	cantPresASocio:=0;
	readln(nroSocio);
	prestamosAUnSocioEni(aP, nroSocio, cantPresASocio); // inciso d)
	
	prestamosAUnSocioEnii(aL, nroSocio, cantPresASocio);// inciso e)
	
	l:= nil;
	TotalPrestamosISBNeni(aP, l); // inciso f)
	
	TotalPrestamosISBNenii(aL, l);// inciso g)
	
	// inciso h) ni idea exdi
	
	readln(isbn1); readln(isbn2);
	total:= 0;
	prestamos_hechos_entre_ISBN_ingresados(aP, isbn1, isbn2, total);// inciso i)
	
	
	prestamos_hechos_entre_ISBN_ingresados_ii(aL, isbn1, isbn2, total);// inciso j)
	
END.
