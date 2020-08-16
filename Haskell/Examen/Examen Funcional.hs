import   Text.Show.Functions

type Atraccion = Persona -> Persona

data Persona = Persona {
    nombre :: String,
    nivelSatisfaccion :: Float,
    nivelEmocion :: Float,
    nivelCultura :: Float
} deriving Show

-- Punto 1
--modelos de personas
ana = Persona {
    nombre = "Ana",
    nivelSatisfaccion = 10,
    nivelEmocion = 20,
    nivelCultura = 60
}
juan = Persona {
    nombre = "Juan",
    nivelSatisfaccion = 20,
    nivelEmocion = 30,
    nivelCultura = 40
}

--Punto 2

modificaSatisfaccion :: (Float -> Float -> Float) -> Float -> Persona -> Persona
modificaSatisfaccion f num pers = pers{nivelSatisfaccion = f num (nivelSatisfaccion pers)}
modificaEmocion :: (Float -> Float -> Float) -> Float -> Persona -> Persona
modificaEmocion f num pers = pers{nivelEmocion = f num (nivelEmocion pers)}
modificaCultura :: (Float -> Float -> Float) -> Float -> Persona -> Persona
modificaCultura f num pers = pers{nivelCultura = f num (nivelCultura pers)}

montaniaRusa :: Float -> Float -> Atraccion
montaniaRusa vel alt pers    | vel > 50 = modificaEmocion (+) (vel*0.15+alt) pers
                            |otherwise = modificaEmocion (*) 0.95 (modificaSatisfaccion (*) 0.9 pers)

-- *Main> montaniaRusa 10 10 ana
-- Persona {nombre = "Ana", nivelSatisfaccion = 9.0, nivelEmocion = 19.0, nivelCultura = 60.0}
-- *Main> montaniaRusa 51 10 ana
-- Persona {nombre = "Ana", nivelSatisfaccion = 10.0, nivelEmocion = 37.65, nivelCultura = 60.0}

caidaLibre :: Float -> Atraccion
caidaLibre caida = modificaEmocion (+) (caida*0.2)

mundoMaya :: Atraccion
mundoMaya pers = modificaEmocion (*) 1.1 (modificaCultura (*) 1.2 pers)

showDeMagia :: Atraccion
showDeMagia pers    | nivelCultura pers > 50 = modificaSatisfaccion (+) 20 pers
                    | otherwise = modificaEmocion (+) 30 pers

--Punto 3
visitar :: [Atraccion] -> Persona -> Persona
visitar atracciones pers = foldl (\pers atraccion -> atraccion pers) pers atracciones

-- *Main> visitar [montaniaRusa 10 10,caidaLibre 20, mundoMaya, showDeMagia] ana
-- Persona {nombre = "Ana", nivelSatisfaccion = 29.0, nivelEmocion = 25.300001, nivelCultura = 72.0}

--Punto 4
--aplicamos una atraccion inventada al listado de atracciones anteriores
-- *Main> visitar [montaniaRusa 10 10,caidaLibre 20, mundoMaya, showDeMagia,modificaSatisfaccion (+) 190] ana
-- Persona {nombre = "Ana", nivelSatisfaccion = 219.0, nivelEmocion = 25.300001, nivelCultura = 72.0}



--Punto 5
estanFelices :: [Persona] -> Bool
estanFelices personas = all estaSatisfecha.filter (estaEmocionada.auxiliar) $ personas
auxiliar :: Persona -> Persona
auxiliar = (mundoMaya).(montaniaRusa 80 10)
estaEmocionada :: Persona -> Bool
estaEmocionada = ((60<).nivelEmocion)
estaSatisfecha :: Persona -> Bool
estaSatisfecha = ((50<).nivelSatisfaccion)

--Sí directamente podes hacer algo así:
--estanFelices personas = all satisfecha.filter (emocionada.montanaRusa 80 10.mundoMaya) $ personas

-- *Main> estanFelices [ana,juan]
-- True

--Punto 6
contenta :: Persona -> [Atraccion] -> Bool
contenta pers atracciones = estaContenta.(visitar atracciones) $ pers
estaContenta :: Persona -> Bool
estaContenta pers = (200<) (nivelEmocion pers + nivelSatisfaccion pers)
--contenta ana [showDeMagia,mundoMaya,modificaSatisfaccion (+) 190]
--True


--Punto 7
-- seccion A
-- Se le puede pasar un conjunto infinito de atracciones, sin embargo esto provocara
-- que el programa se ejecute indefinidamente. Sin llegar a un resultado final

-- seccion B
-- a diferencia del punto A, en esta ocasion y debido al concepto de lazy evaluation
-- podemos aplicar una lista infinita de personas y mostrar la primera que cumpla con la condicion f
-- esto se debe a que el programa finaliza, una vez encontrada la persona que cumple con esta condicion

h :: (Persona -> Bool) -> [Persona] -> Persona
h f xs = (head.filter f) xs

-- *Main> h (contenta [showDeMagia,mundoMaya,modificaSatisfaccion (+) 190]) [ana,juan]
-- Persona {nombre = "Ana", nivelSatisfaccion = 10.0, nivelEmocion = 20.0, nivelCultura = 60.0}