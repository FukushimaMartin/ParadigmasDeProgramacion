
%viveEn Ratas
viveEn(remy,gusteaus).
viveEn(emile,chezMilleBar).
viveEn(django,pizzeriaJeSuis).

%sabeCocinar (Persona, Plato, Exp) Humanos
sabeCocinar(linguini,rataouille,3).
sabeCocinar(linguini,sopa,5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

%trabajaEn(Persona, restaurante)
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie , cafeDes2Moulins).



% Punto 1
estaEnMenu(Plato, Restaurante):- sabeCocinar(Persona, Plato, _), 
    trabajaEn(Persona, Restaurante).

% Punto 2
% relaciona Persona con Plato
cocinaBien(Persona, Plato):-
    sabeCocinar(Persona,Plato,Exp),
    Exp > 7.
cocinaBien(Persona,Plato):-
    tieneTutor(Persona,Tutor),
    cocinaBien(Tutor,Plato).
cocinaBien(remy,Plato):-
    sabeCocinar(_,Plato,_).

% relaciona Persona con Tutor
tieneTutor(skinner,amelie).
tieneTutor(linguini,Tutor):-
    viveEn(Tutor,Lugar), trabajaEn(linguini,Lugar).


% Punto 3
chef(Persona,Resto):-
    trabajaEn(Persona,Resto), cumpleCondiciones(Persona,Resto).

cumpleCondiciones(Persona,Resto):-
    forall(estaEnMenu(Plato,Resto),cocinaBien(Persona,Plato)).
%para todo plato del resto, la persona lo cocina bien

cumpleCondiciones(Persona,_):-
    experienciaTotal(Persona, Total), 
    Total > 20.

experienciaTotal(Persona, Total):-
    findall(Exp,sabeCocinar(Persona,_,Exp),ExpTotal),
    sumlist(ExpTotal, Total).
%de cada persona, saca la exp de cada plato q cocina, arma la lista y suma.


% Punto 4
encargada(Persona,Plato,Resto):-
    experienciaCocinando(Persona,Plato,Resto,Exp),
    forall(experienciaCocinando(_,Plato,Resto,OtraExp),Exp >= OtraExp).

experienciaCocinando(Persona,Plato,Resto,Exp):-
    sabeCocinar(Persona,Plato,Exp), trabajaEn(Persona,Resto).



plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

% Punto 5
esSaludable(Plato):-
    plato(Plato,TipoPlato),
    totalCalorias(TipoPlato, Calorias),
    Calorias < 75.

%calorias entrada
totalCalorias(entrada(Ingredientes),Calorias):-
    length(Ingredientes, SumaIngredientes), 
    Calorias is SumaIngredientes * 15.

%calorias principal
totalCalorias(principal(Guarnicions,Minutos),Calorias):-
    Calorias is Minutos * 5 + CalXGuarnicion,
    caloriaGuarnicion(Guarnicion,CalXGuarnicion).

caloriaGuarnicion(papasfritas,50).
caloriaGuarnicion(pure,20).
caloriaGuarnicion(ensalada,0).

%caloria postre
totalCalorias(postre(Calorias),Calorias).


% Punto 6
%uso trabaja en para listar los Resto, pero de humanos
%luego en ellos no tienen q vivir ninguna rata
%luego el criterio de cada critico
criticaPositiva(Critico,Resto):-
    trabajaEn(_,Resto), not(viveEn(_,Resto)),
    critica(Critico,Resto).

critica(antonEgo,Resto):-%especialista en ratatuil
    forall(chef(Persona,Resto),cocinaBien(Persona,rataouille)).
critica(cormillot,Resto):-%para todo plato del resto, el plato es saludable
    forall(experienciaCocinando(_,Plato,Resto,_),esSaludable(Plato)).
critica(martiniano,Resto):-%hay un chef y no hay otro chef en el mismo resto
    chef(Persona,Resto),
    not((chef(OtraPersona,Resto), Persona \= OtraPersona)).