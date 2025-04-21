
% vehiculo(marca, Referencia, Tipo, Precio, año).

vehiculo(toyota, rav4, suv, 28000, 2022).
vehiculo(toyota, corolla, sedan, 22000, 2021).
vehiculo(toyota, tacoma, pickup, 35000, 2023).
vehiculo(ford, mustang, sport, 45000, 2023).
vehiculo(ford, explorer, suv, 32000, 2022).
vehiculo(ford, fusion, sedan, 25000, 2020).
vehiculo(bmw, x5, suv, 60000, 2021).
vehiculo(bmw, m3, sport, 70000, 2022).
vehiculo(chevrolet, silverado, pickup, 40000, 2023).
vehiculo(honda, civic, sedan, 23000, 2022).
vehiculo(honda, crv, suv, 27000, 2023).

% Predicado para mirar si la referencia del vehiculo sabe su presupuesto
saber_presupuesto(Referencia, PresupuestoMax) :-
    vehiculo(_, Referencia, _, Precio, _),
    Precio =< PresupuestoMax.

% Predicado para obtener todas las referencias con las marcas
vehiculos_por_marca(Marca, List) :-
    findall(Referencia, vehiculo(Marca, Referencia, _, _, _), List).

% predicado para agrupar vehiculos por tipo y año para una marca
vehiculos_por_tipo_y_año(Marca, Agrupado) :-
    bagof((Tipo, Año, Referencia), vehiculo(Marca, Referencia, Tipo, _, Año), Agrupado).

%  Suma los precios de una lista de vehiculos
suma_precios([], 0).
suma_precios([(_, _, _, Precio, _) | T], Total) :-
    suma_precios(T, Subtotal),
    Total is Subtotal + Precio.



% generar_reportes(+Marca, +Tipo, +PresupuestoMax, -Resultado)
generar_reportes(Marca, Tipo, PresupuestoMax, Resultado) :-
    findall((Marca, Referencia, Tipo, Precio, Año),
            (vehiculo(Marca, Referencia, Tipo, Precio, Año),
             Precio =< PresupuestoMax),
            Vehiculos),
    suma_precios(Vehiculos, TotalValor),
    TotalValor =< 1000000,  
    Resultado = [vehiculos: Vehiculos, total_valor: TotalValor].




%casos de prueba
% Caso 1: Listar todas las referencias SUV de Toyota con precio menor a $30,000
% ?- findall(Ref, (vehiculo(toyota, Ref, suv, Precio, _), Precio < 30000), Resultado).

% Caso 2: Mostrar los vehículos de la marca Ford agrupados por tipo y año usando bagof/3
% ?- bagof((Tipo, Año, Ref), vehiculo(ford, Ref, Tipo, _, Año), Agrupado).

% Caso 3: Calcular el valor total del inventario tipo sedan sin exceder $500,000
% ?- findall((Marca, Ref, sedan, Precio, Año),
%            (vehiculo(Marca, Ref, sedan, Precio, Año), Precio =< 500000),
%            Lista),
%    suma_precios(Lista, Total),
%    Total =< 500000.

