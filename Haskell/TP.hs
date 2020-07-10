import   Text.Show.Functions

type Desgaste = Float
type Patente = String
type Fecha = (Int, Int, Int)
type Mecanico = Auto -> Auto

-- Definiciones base
anio :: Fecha -> Int
anio (_, _, year) = year

data Auto = Auto {
    patente :: Patente,
    desgasteLlantas :: [Desgaste],
    rpm :: Int,
    temperaturaAgua :: Int,
    ultimoArreglo :: Fecha
} deriving Show

data OrdenDeReparacion = OrdenDeReparacion {
    fechaReparacion :: Fecha,
    mecanicos :: [Mecanico]
} deriving Show

--PUNTO 1
costoDeReparacion :: Auto -> Int
costoDeReparacion auto  |patenteLarga auto = 12500
                        |entreDJyNB (patente auto) = calculoPatental (patente auto)
                        |otherwise = 15000

--funcion auxiliar
patenteLarga :: Auto -> Bool
patenteLarga = (==7).length.patente
entreDJyNB :: Patente -> Bool
entreDJyNB patente = mayorDJ patente && menorNB patente
mayorDJ :: Patente -> Bool
mayorDJ = ("DJ"<=).(take 2)
menorNB :: Patente -> Bool
menorNB = ("NB">=).(take 2)
calculoPatental :: Patente -> Int
calculoPatental patente |ultimoDigitoIgualA '4' patente = 3000 * length patente
                        |otherwise = 20000
ultimoDigitoIgualA :: Char -> Patente -> Bool
ultimoDigitoIgualA digito = (==digito).last


--inicio autos de ejemplo
autoA = Auto {
    patente = "DJV214",
    desgasteLlantas = [0.1, 0.4, 0.2, 0] ,
    rpm = 1999,
    temperaturaAgua = 5,
    ultimoArreglo = (6,12,2016) 
}
autoB = Auto {
    patente = "AT001LN",
    desgasteLlantas = [0.6, 0.5, 0.6, 0.1] ,
    rpm = 2000,
    temperaturaAgua = 5,
    ultimoArreglo = (6,12,2015) 
}
autoC = Auto {
    patente = "DFH029",
    desgasteLlantas = [0.1, 0.1, 0.1, 0] ,
    rpm = 3000,
    temperaturaAgua = 5,
    ultimoArreglo = (6,12,2014) 
}
autoD = Auto {
    patente = "DJV215",
    desgasteLlantas = [0.3, 0.5, 0.6, 0.1] ,
    rpm = 2005,
    temperaturaAgua = 5,
    ultimoArreglo = (6,12,2019) 
}
autoE = Auto {
    patente = "DJV215",
    desgasteLlantas = [0.5, 0.4, 0.2, 0.1] ,
    rpm = 2005,
    temperaturaAgua = 5,
    ultimoArreglo = (6,12,2019) 
}
--fin autos de ejemplo
--inicio Orden de Reparacion de ejemplo
orden1 = OrdenDeReparacion {
    fechaReparacion = (5,6,20),
    mecanicos = [bravo,lima,tango]
}
orden2 = OrdenDeReparacion {
    fechaReparacion = (12,3,87),
    mecanicos = [alfa,zulu]
}
--fin Orden de Reparacion de ejemplo

--PUNTO 2
--(integrante A)
autoPeligroso :: Auto -> Bool
autoPeligroso = (0.5 <).head.desgasteLlantas

--(integrante B)
necesitaRevision :: Auto -> Bool
necesitaRevision = (2015 >=).anio.ultimoArreglo



--PUNTO 3
--(integrante A)
--Alfa
alfa :: Mecanico
alfa auto = auto{rpm = min 2000 (rpm auto)}

--Bravo
bravo :: Mecanico
bravo auto = auto{desgasteLlantas = cambiarTodas (desgasteLlantas auto)}
--funcion auxiliar
cambiarTodas :: [Desgaste] -> [Desgaste]
cambiarTodas = cambiarCubiertas.reverse.cambiarCubiertas

--Charly
charly :: Mecanico
charly = alfa.bravo

--(integrante B)
--Tango
tango :: Mecanico
tango auto = auto

--Zulu
zulu :: Mecanico
zulu = lima.revisaTempAgua
--funcion auxiliar
revisaTempAgua :: Auto -> Auto
revisaTempAgua auto = auto{temperaturaAgua = 90}

--Lima
lima :: Mecanico
lima auto = auto{desgasteLlantas = cambiarCubiertas (desgasteLlantas auto)}
--funcion auxiliar
cambiarCubiertas :: [Desgaste] -> [Desgaste]
cambiarCubiertas = ([0,0] ++).(drop 2)


{-      Segunda Entrega     -}
--Punto 4

estanOrdenados :: [Auto] -> Bool
estanOrdenados autos =  all ordenamientoToc (convertirEnTupla autos)
convertirEnTupla :: [Auto] -> [(Int,Auto)]
convertirEnTupla autos = zip [1..length autos] autos
ordenamientoToc :: (Int,Auto) -> Bool
ordenamientoToc tupla = (even.fst) tupla == (even.desgasteTotal.snd) tupla
desgasteTotal :: Auto -> Int
desgasteTotal = round.(10*).sum.desgasteLlantas


--Punto 5

ordenReparacion :: Auto -> OrdenDeReparacion -> Auto
ordenReparacion auto orden = actualizarFecha (fechaReparacion orden) (reparaciones auto (mecanicos orden))
reparaciones :: Auto -> [Mecanico] -> Auto
reparaciones auto mecanicos = foldl (\auto mecanico -> mecanico auto) auto mecanicos
actualizarFecha :: Fecha -> Auto -> Auto
actualizarFecha fecha auto = auto{ultimoArreglo = fecha}


--Punto 6
--Integrante A

mecanicosAcondicionadores :: Auto -> [Mecanico] -> [Mecanico]
mecanicosAcondicionadores auto mecanicos = filter (noPeligroso auto) mecanicos

noPeligroso :: Auto -> Mecanico -> Bool
noPeligroso auto mecanico = not.autoPeligroso.mecanico $ auto



--Integrante B

sumaDeCostos :: Int -> Auto -> Int
sumaDeCostos sem auto = sem + costoDeReparacion auto

costoTotalReparacion :: [Auto] -> Int
costoTotalReparacion autos = foldl sumaDeCostos 0 (filter necesitaRevision autos)

--Punto 7
--Integrante A

{- Gracias a lazy evaluation (evaluación perezosa), se puede aplicar una lista de técnicos infinitos y obtener el primero que cumpla la condición, dado que resuelve sólo lo que necesita. -}
tecnicosInfinitos = zulu:charly:tecnicosInfinitos
primerTecnicoOptimo :: Auto -> [Mecanico] -> Mecanico
primerTecnicoOptimo auto tecnicos = head . (mecanicosAcondicionadores auto) $ tecnicos
{- Con esta funcion podemos obtener el primer Mecanico que deja el auto en condiciones
según las especificaciones del punto 6.
Sin embargo, dado que cada Mecanico es en realidad una funcion, lo que va a devolver 
es justamente una función. 
                *Main> primerTecnicoOptimo autoC tecnicosInfinitos
                <function>
Existe un inconveniente, si dentro de nuestra lista infinita de tecnicos no hay alguno
que deje el auto en condiciones, entonces la funcion no tendrá fin, y entrará en un 
bucle infinito  -}



--Integrante B

{- Utilizar una lista infinita en la funcion "costoTotalReparacion" ocasionará que el programa entre en un bucle infinito y no finalice nunca.
El concepto utilizado para calcular el costo de reparación fue tanto foldl como lazy evaluation, dado que se utilizó la función foldl para combinar los elementos de izquierda a derecha, como también take para tomar los primeros 3 autos de la lista que necesiten revisión.-}

costoTotalReparacionDeTres autos = foldl (\sem car -> sem + costoDeReparacion car) 0 ((take 3).(filter necesitaRevision) $ autos)
{- Con esta version de la funcion costoTotalReparacion podemos aplicar una lista infinita de autos y obtener los primeros 3 que necesisten revision y calcular su costo de reparacion.
Sin embargo, si en la lista no hubiera ningun auto que necesite revision, entonces nos encontramos con la misma situacion anterior. -}

autosInfinitos :: [Auto]
autosInfinitos = autosInfinitos' 0 0

autosInfinitos' :: Int -> Float -> [Auto]
autosInfinitos' n m = Auto {
        patente = "AAA000",
        desgasteLlantas = [m, 0, 0, 0.3],
        rpm = 1500 + n,
        temperaturaAgua = 90,
        ultimoArreglo = (20, 1, 2013)
        } : autosInfinitos' (n + 1) (m + 1)
