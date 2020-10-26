
/*  Punto 1 */
quedaEn(laComarca,eriador).
quedaEn(rivendel,eriador).
quedaEn(moria,montaniasNubladas).
quedaEn(lothlorien,montaniasNubladas).
quedaEn(edoras,rohan).
quedaEn(isengard,rohan).
quedaEn(abismoDeHelm,rohan).
quedaEn(minasTirith,gondor).
quedaEn(minasMorgul,mordor).
quedaEn(monteDelDestino,mordor).


/*  Punto 2 */
caminoPosible([laComarca,rivendel,moria,lothlorien,edoras,minasTirith,minasMorgul,monteDelDestino]).


/*  Punto 3 */
zonasLimitrofes(Zona1,Zona2):-
    quedaEn(Zona1,Region),
    quedaEn(Zona2,Region),
    Zona1 \= Zona2.
zonasLimitrofes(Zona1,Zona2):-
    limitrofes(Zona2,Zona1).
zonasLimitrofes(Zona1,Zona2):-
    limitrofes(Zona1,Zona2).
limitrofes(rivendel,moria).
limitrofes(moria,isengard).
limitrofes(lothlorien,edoras).
limitrofes(edoras,minasTirith).
limitrofes(minasTirith,minasMorgul).


/*  Punto 4 -   A */
regionesLimitrofes(Region1,Region2):-
    quedaEn(Zona1,Region1),
    quedaEn(Zona2,Region2),
    zonasLimitrofes(Zona1,Zona2), Region1 \= Region2.

/*  Punto 4 -   B */
regionesLejanas(Region1,Region2):-
    quedaEn(_, Region1),
    quedaEn(_, Region2),
    not(regionesLimitrofes(Region1,Region2)),
    regionesLimitrofes(Region1,Region3),
    not(regionesLimitrofes(Region2,Region3)).


/*  Punto 5 -   A */
puedeSeguirCon(Camino,Zona):-
    last(Camino,UltZona),
    zonasLimitrofes(Zona,UltZona).
/*  Punto 5 -   B */
sonConsecutivos(Camino1,[Zona|_]):-
    puedeSeguirCon(Camino1,Zona).


/*  Punto 6 -   A */
caminoLogico([Zona1,Zona2|Zonas]):-
    zonasLimitrofes(Zona1,Zona2),
    caminoLogico([Zona2|Zonas]).
caminoLogico([_]).

/*  Punto 6 -   B */

caminoSeguro([_]).

caminoSeguro([_,_]).

caminoSeguro([Zona1,Zona2,Zona3|Zonas]):-
    not((quedaEn(Zona1,Region),
    quedaEn(Zona2,Region),
    quedaEn(Zona3,Region))),
    caminoSeguro([Zona2,Zona3|Zonas]).
caminoSeguro([Zona1,Zona2,Zona3|[]]):-
    not((quedaEn(Zona1,Region),
    quedaEn(Zona2,Region),
    quedaEn(Zona3,Region))).

otroCamino([laComarca,rivendel,lothlorien,edoras,monteDelDestino]).
otroCamino2([rivendel,lothlorien,edoras,isengard,abismoDeHelm,minasTirith,minasMorgul]).





/* 2da Entrega */

/* Punto 1 -    A */
cantidadDeRegiones(Camino,CantidadRegiones):-
    findall(Region,(member(Zona, Camino),quedaEn(Zona,Region)),Regiones),
    list_to_set(Regiones,RegionesSinRepetir),
    length(RegionesSinRepetir,CantidadRegiones).

/* Punto 1 -    B */

esVueltero(Camino):-
    quedaEn(Zona1, Region),
    quedaEn(Zona2, Region),
    Zona1 \= Zona2.

camino1([rivendel,laComarca]).
camino2([rivendel,laComarca,rivendel]).
camino3([isengard,moria,lothlorien,edoras,isengard]).

/* Punto 1 -    C */
todosLosCaminosConducenAMordor(Caminos):-
    forall(member(Camino,Caminos),(last(Camino,Zona),quedaEn(Zona,mordor))).

/* Punto 2 -    A */
viajero(gandalf, maiar(25,250)).

/* Punto 2 -    B */
viajero(legolas, guerrero(elfo,[arma(arco,29),arma(espada,20)])).
viajero(gimli, guerrero(enano,[arma(hacha,26)])).
viajero(aragorn, guerrero(dunedain,[arma(espada,30)])).
viajero(boromir, guerrero(hombre,[arma(espada,26)])).
viajero(gorbag, guerrero(orco,[arma(ballesta,24)])).
viajero(ugluk, guerrero(urukhai,[arma(espada,26),arma(arco,22)])).

/* Punto 2 -    C */
viajero(frodo, pacifico(hobbit,51)).
viajero(sam, pacifico(hobbit,36)).
viajero(barbol, pacifico(ent,5300)).

/* Punto 3 -    A */
raza(Viajero,Raza):-
    viajero(Viajero,guerrero(Raza,_)).
raza(Viajero,maiar):-
    viajero(Viajero,maiar(_,_)).
raza(Viajero,Raza):-
    viajero(Viajero,pacifico(Raza,_)).

/* Punto 3 -    B */

arma(maiar,baston).

arma(Viajero, baston):-
    viajero(Viajero, pacifico(hobbit,Edad)),
    Edad =< 50.

arma(Viajero, espadaCorta):-
    viajero(Viajero, pacifico(hobbit,Edad)),
    Edad > 50.

arma(ents,fuerza).

/* Punto 3 -    C */
nivel(Viajero,Nivel):-
    viajero(Viajero,maiar(Nivel,_)).
nivel(Viajero,Nivel):-
    viajero(Viajero,guerrero(_,Armas)),
    nivelMaximo(Armas,Nivel).
nivel(Viajero,Nivel):-
    viajero(Viajero,pacifico(_,_)),
    proporcionalEdad(Viajero,Nivel).


nivelArma(arma(_,Nivel),Nivel).

nivelMaximo(Armas,Maximo):-
    member(Arma,Armas), nivelArma(Arma,Maximo),
    forall((member(Arma2,Armas),nivelArma(Arma2,Nivel)),Maximo >= Nivel).

proporcionalEdad(Viajero,Nivel):-
    viajero(Viajero,pacifico(hobbit,Edad)),
    Nivel is Edad / 4.
proporcionalEdad(Viajero,Nivel):-
    viajero(Viajero,pacifico(ent,Edad)),
    Nivel is Edad / 100.


/* Punto 4 -    A */
grupo(Grupo):-
    findall(UnViajero,viajero(UnViajero,_),TotalViajeros),
    conjuntosDeViajeros(TotalViajeros,Combinaciones),
    permutation(Combinaciones, Grupo).
    
conjuntosDeViajeros([], []).
conjuntosDeViajeros([Viajero|Viajeros], [Viajero|OtrosViajeros]):- 
    conjuntosDeViajeros(Viajeros, OtrosViajeros).
conjuntosDeViajeros([_|Viajeros], OtrosViajeros):- 
    conjuntosDeViajeros(Viajeros, OtrosViajeros).



/* Punto 4 -    B */
cumpleRequerimiento(Requerimiento,Grupo):-
    grupo(Grupo),
    zonaRequerimiento(_,Requerimiento),
    condicion(Grupo,Requerimiento).

condicion(Grupo,integrante(Raza,NivelMinimo)):-
    member(Viajero,Grupo),
    raza(Viajero,Raza),
    nivel(Viajero,NivelViajero),
    NivelViajero >= NivelMinimo.

condicion(Grupo,elemento(Elemento,CantidadMinima)):-
    findall(Elemento,(member(Viajero,Grupo),tiene(Viajero,Elemento)),ListaElementos),
    length(ListaElementos, Cantidad),
    Cantidad >= CantidadMinima.

condicion(Grupo,magia(PoderMinimo)):-
    findall(Poder,(member(Viajero,Grupo),poder(Viajero,Poder)),Poderes),
    sumlist(Poderes, PoderTotal),
    PoderTotal >= PoderMinimo.

poder(Viajero,Poder):-
    viajero(Viajero,maiar(_,Poder)).
poder(Viajero,Poder):-
    viajero(Viajero,guerrero(elfo,_)),
    nivel(Viajero,Nivel),
    Poder is Nivel * 2.
poder(Viajero,Poder):-
    viajero(Viajero,guerrero(dunedain,_)),
    nivel(Viajero,Poder).
poder(Viajero,Poder):-
    viajero(Viajero,guerrero(enano,_)),
    nivel(Viajero,Poder).

zonaRequerimiento(minasTirith, integrante(maiar, 25)).
zonaRequerimiento(moria, elemento(armaduraMithril, 1)).
zonaRequerimiento(isengard, integrante(maiar, 27)).
zonaRequerimiento(isengard, magia(280)).
zonaRequerimiento(abismoDeHelm, integrante(elfo, 28)).
zonaRequerimiento(abismoDeHelm, integrante(enano, 20)).
zonaRequerimiento(abismoDeHelm, integrante(maiar, 25)).
zonaRequerimiento(abismoDeHelm, magia(200)).
zonaRequerimiento(sagrario, elemento(anduril, 1)).
zonaRequerimiento(minasMorgul, elemento(lembas, 2)).
zonaRequerimiento(minasMorgul, elemento(luzEarendil, 1)).

tiene(sam, lembas).
tiene(sam, lembas).
tiene(sam, lembas).
tiene(gandalf, sombraGris).
tiene(frodo, armaduraMithril).
tiene(frodo, luzEarendil).
tiene(frodo, lembas).
tiene(frodo, capaElfica).
tiene(sam, capaElfica).
tiene(legolas, capaElfica).
tiene(aragorn, capaElfica).
tiene(aragorn, anduril).

/* Punto 5 -    A */
puedeAtravesar(Zona,Grupo):-
    quedaEn(Zona,_),
    grupo(Grupo),
    forall(zonaRequerimiento(Zona,Requerimiento),
    cumpleRequerimiento(Requerimiento,Grupo)).

/* Punto 5 -    B */

seSientenComoEnCasa(Grupo,Region):-
    forall(quedaEn(Zona,Region),
    puedeAtravesar(Zona,Grupo)).
