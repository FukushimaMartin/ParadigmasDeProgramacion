%creeEn (Persona, Personaje)
creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoDePascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

%quiere(Persona, Tipo Sueño)
quiere(gabriel,ganarLoteria([5,9])).
quiere(gabriel,serFutbolista(arsenal)).
quiere(juan,serCantante(100000)).
quiere(macarena,serCantante(10000)).

%que conceptos aparecen?
%functores, principio de universo cerrado, predicados

%generadores
persona(Persona):- creeEn(Persona,_).
personaje(Personaje):- creeEn(_,Personaje).


%Punto 2
esAmbiciosa(Persona):-
    persona(Persona),%lo hago inversible
    totalDificultadSuenio(Persona,Dificultad),
    Dificultad > 20.
%de cada sueño toma dificultad y lo lista.. luego lo suma
totalDificultadSuenio(Persona,TotalDif):-
    findall(Dificultad,dificultadPorSuenio(Persona,Dificultad),ListaDificultades),
    sumlist(ListaDificultades, TotalDif).
%calcula la dificultad de cada sueño por persona
dificultadPorSuenio(Persona,Dificultad):-
    quiere(Persona,Suenio),
    dificultad(Suenio,Dificultad).


%ganarLoteria con listaNumeros
dificultad(ganarLoteria(Numeros),Dificultad):-
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.
%serCantante con ventas superiores o ventas inferiores
dificultad(serCantante(Ventas),6):-
    Ventas > 500000.
dificultad(serCantante(Ventas),4):-
    Ventas =< 500000.
%serFutbolista de equipoChico o de No equipoChico
dificultad(serFutbolista(Equipo),3):-
    equipoChico(Equipo).
dificultad(serFutbolista(Equipo),16):-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).


% Punto 3
tieneQuimica(Persona,Personaje):-
    creeEn(Persona,Personaje),
    cumpleCondiciones(Persona,Personaje).

cumpleCondiciones(Persona,campanita):-
    dificultadPorSuenio(Persona,Dificultad),
    Dificultad < 5.
cumpleCondiciones(Persona,Personaje):-
    Personaje \= campanita,
    todosLosSueniosSonPuros(Persona), not(esAmbiciosa(Persona)).

todosLosSueniosSonPuros(Persona):- 
    forall(quiere(Persona, Suenio), esPuro(Suenio)).

esPuro(serFutbolista(_)).
esPuro(serCantante(Ventas)):-
    Ventas < 200000.


%Punto 4
puedeAlegrar(Personaje,Persona):-
    quiere(Persona,_),personaje(Personaje).
puedeAlegrar(Personaje,Persona):-
    tieneQuimica(Persona,Personaje),
    not(estaEnfermo(Personaje)).
puedeAlegrar(Personaje,Persona):-
    tieneQuimica(Persona,Personaje),
    amigosDeBackUp(Personaje,OtroPersonaje),
    not(estaEnfermo(OtroPersonaje)).

amigosDeBackUp(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje).
amigosDeBackUp(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,Intermedio),
    sonAmigos(Intermedio,OtroPersonaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).
sonAmigos(campanita,reyesMagos).
sonAmigos(campanita,conejoDePascua).
sonAmigos(conejoDePascua,cavenaghi).
