program p2p3;
Type
dia = 1..31;
mes = 1..12;
an = 1900..2023;

rFecha = record
	dd: dia;
	mm: mes;
	yy: an;
	end;

rVenta = record
	cod: integer; // codigo del producto
	date: rFecha;
	cant: integer; //cant de unidades vendidas (en esta venta en particular)
	end;
	
arbol = ^nodo;

nodo = record
	dato: rVenta;
	hi: arbol;
	hd: arbol;
	end;

procedure leerVenta(var v: rVenta);

	procedure leerFecha(var f: rFecha);
	begin
		read(f.dd); read(f.mm); read(f.yy); 
	end;

var f: rFecha;
begin
	leerFecha(f); read(v.cod); read(v.cant);
end;

{a i) y ii).
- a retorna lo pedido en i) que es el ABB ordenado por codigo de producto.
- a2 retorna, usando la misma info que tiene el arbol a, un ABB ordenado con el mismo criterio
* 	pero donde cada nodo es un producto unico con la cantidad total vendida de este}
procedure generarArboles(var a, a2: arbol);
	
	{para crear el arbol principal que pide i)}
	procedure generarA(var a: arbol; v: rVenta);
	begin
		if (a = nil) then begin
			new(a); a^.hi:= nil; a^.hd:= nil; a^.dato:= v;
			end
		else 
		
			if (v.cod <= a^.dato.cod) then generarA(a^.hi, v)
			
			else generarA(a^.hd, v);				
	end;
	
	{para crear el arbol que pide ii).
	Aca uso el mismo tipo de arbol y el mismo registro porque me sirve igual.
	En cada nodo me queda un registro venta con un codigo de producto unico en el arbol, con la 
	cantidad total de vendidos. la fecha la ignoramos. Difiere con el arbol a en
	donde cada nodo es una venta que pudo haber sido de X producto con su respectiva cantidad y
	* esta compuesto de varios nodos con ventas donde los codigos se pueden repetir}
	procedure generarA2(var a2: arbol; v: rVenta);
	begin
		 if (a2 = nil) then begin
			new(a2); a2^.hi:= nil; a2^.hd:= nil; a2^.dato:= v;
			end
		else
			{Si el codigo se repite es el mismo producto --> sumo a la cantidad vendida existente}
			if (v.cod = a2^.dato.cod) then a2^.dato.cant:= a2^.dato.cant + v.cant
			
			{si no es el mismo codigo, ahi si avanzo en la creacion del arbol!}
			else
				if (v.cod <= a2^.dato.cod) then generarA2(a2^.hi, v)
				else generarA2(a2^.hd, v);
	end;
	
	procedure recorrerAparaGenerarA2(a: arbol; var a2: arbol);
	begin
		if a <> nil then begin
			recorrerAparaGenerarA2(a^.hi, a2);
			generarA2(a2, a^.dato);
			recorrerAparaGenerarA2(a^.hd, a2);
			end;
	end;
	
var v: rVenta;

begin
	leerVenta(v); a:= nil; a2:= nil;
	while v.cod <> 0 do begin
		generarA(a, v);
		leerVenta(v);
		end;
	{una vez que tengo generado el a, puedo recorrerlo e ir armando el a2}
	recorrerAparaGenerarA2(a, a2);
end;

{b) }
procedure recorrerAyRetornarUdsVend(a: arbol; codigo: integer; var cantidad: integer);
begin
	if a <> nil then begin
		if codigo < a^.dato.cod then recorrerAyRetornarUdsVend(a^.hi, codigo, cantidad)
		else
		
			if (a^.dato.cod = codigo) then begin 
				cantidad:= cantidad + a^.dato.cant;
				recorrerAyRetornarUdsVend(a^.hi, codigo, cantidad);
				end
			
			else recorrerAyRetornarUdsVend(a^.hd, codigo, cantidad);
		end;
end;


{c) }
function recorrerA2yRetornaUdsVend(a2: arbol; codigo: integer): integer;
begin
	if a2 <> nil then begin
		if codigo < a2^.dato.cod then 
		
			recorrerA2yRetornaUdsVend:= recorrerA2yRetornaUdsVend(a2^.hi, codigo)
		
		else
		
			if (a2^.dato.cod = codigo) then  recorrerA2yRetornaUdsVend:= a2^.dato.cant
		
			else recorrerA2yRetornaUdsVend:= recorrerA2yRetornaUdsVend(a2^.hd, codigo);
		end
	else
		{por si no existiese el codigo}
		recorrerA2yRetornaUdsVend:= -1;
end;


var a, a2: arbol;
	codigo, cantidad: integer;

BEGIN
	{ a) i) y ii) }
	generarArboles(a, a2);
	
	{ b) }
	read(codigo); cantidad:= 0;
	recorrerAyRetornarUdsVend(a, codigo, cantidad);
	
	{c) }
	read(codigo);
	cantidad:= recorrerA2yRetornaUdsVend(a2, codigo);
	
END.

