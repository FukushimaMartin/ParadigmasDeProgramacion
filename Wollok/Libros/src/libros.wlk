object andy{
	const property librosLeidos = []
	
	method leerLibro(unLibro){
		librosLeidos.add(unLibro)
	}
	method ultimoLeido() = librosLeidos.last()
	
	method primeroLeido() = librosLeidos.first()
	
	method cantidadLeidos() = librosLeidos.size()
	
	method olvidarPrimerLibroLeido(){
		librosLeidos.remove( self.primeroLeido() )
	}
	
	method olvidarLibro(unLibro){
		librosLeidos.remove(unLibro)
	}
	
	method librosBuenosLeidos() = librosLeidos.filter({ unLibro => unLibro.valoracion() > 12 })
	
	method peorLibro() = librosLeidos.min({ unLibro => unLibro.valoracion()})	
	method mejorLibro() = librosLeidos.max({ unLibro => unLibro.valoracion()})		
}

object harryPotter{
	const nombre = "Harry Potter - El Misterio del Principe Mestizo"
	var property cantidadLectores=10500156
		
	method valoracion(){
		return cantidadLectores/1000000
	}
}

object seniorDeLosAnillos{
	const nombre = "El Señor de los Anillos - Las dos Torres"
	const cantidadPaginas = 450
	
	method nombre() = nombre
	
	method valoracion(){
		return cantidadPaginas/45
	}
}

object elPrincipito {
	const nombre = "El Principito"
	const valoracion = 15
	method nombre() = nombre
	method valoracion() = valoracion 
}

object losJuegosDelHambre {
	const nombre = "Los Juegos del Hambre"
	var votosPositivos = 1600200
	var votosNegativos = 300600
	
	method nombre() = nombre
	
	method valoracion(){
		var coeficiente = votosPositivos-votosNegativos
		return if (coeficiente<0) 0 else (coeficiente/100000)
	}
}

object venasAbiertasDeAmericaLatina{
	const nombre = "Venas Abiertas de America Latina"
	const anioSalida = 1971
	
	method nombre() = nombre
	method valoracion(){
		return self.cantidadDeAnios()*0.3
	}
	
	method cantidadDeAnios(){
		const hoy = new Date()
		return hoy.year() - anioSalida
	}
}

object rayuela{
	const nombre = "Rayuela"
	method nombre() = nombre
	method valoracion(){
		return self.cantidadLetras()*2
	}
	
	method cantidadLetras(){
		return nombre.size()
	}
}

object padreRicoPadrePobre{
	const nombre = "Padre Rico, Padre Pobre"
	const cantidadPaginas = 207
	
	method nombre() = nombre
	method valoracion(){
		return cantidadPaginas/100 
	}
	

}

object laCabania{
	var nombre = "La Cabaña"
	const anioSalida = 2007
	
	method nombre() = nombre
	method valoracion(){
		return self.cantidadDeAnios()/3
	}
	
	method cantidadDeAnios(){
		const hoy = new Date()
		return hoy.year() - anioSalida
	}
}