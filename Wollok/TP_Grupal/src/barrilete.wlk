// Entrega 1
//	Destinos
class Localidad{
	const property name
	const property equipajeImprescindible = []
	var property precio
	const property kmUbicacion
	
	method descuento(desc) {
		precio -= precio*desc/100
		self.equipajeImprescindible().add("Certificado de descuento")
	}
	
	method destinoDestacado() = self.precio() > 2000
	
	method esPeligroso() = self.equipajeImprescindible().any({equipaje => equipaje.contains("Vacuna")})
	
	method distanciaA(localidad){
		return (kmUbicacion - localidad.kmUbicacion()).abs()
	}
	
}

// Empresa Barrilete Cosmico
object barrilete {
	const property destinos = []
	const property transportes = []


//	Punto 1
	method destinosDestacados(){
		return destinos.filter({destino => destino.destinoDestacado()})
	}

// Punto 2
	method aplicarDescuentos(desc){
		destinos.forEach({dest => dest.descuento(desc)})
	}
// Punto 3
	method esExtrema(){
		return self.destinosDestacados().any({destino => destino.esPeligroso()})
	}

// Punto 4
	method cartaDeDestinos(){
		return destinos.map({destino=> destino.name()})
	}
	
	method agregarDestino(destino){
		destinos.add(destino)
	}
	method agregarTransporte(transporte){
		transportes.add(transporte)
	}
	
	method armarViaje(usuario,destino){
		const transporte = transportes.anyOne()
		return new Viaje(origen = usuario.localidadOrigen(), destino = destino, transporte = transporte)
	}

}
class Usuario{
	const property nombreUsuario
	const property viajes = []
	var property dineroDisponible
	const property listaSeguidos = #{}
	var property localidadOrigen
	const property equipaje = []
	
	method viajarA(destino) {
		const viaje = barrilete.armarViaje(self,destino)
		
		if (dineroDisponible < viaje.precio()){
			throw new DomainException(message="Saldo insuficiente")
		}
		if(!destino.equipajeImprescindible().all({sug => equipaje.contains(sug)})){
			throw new DomainException(message="no posee el equipaje imprescindible para viajar")
		}
		
		viajes.add(viaje)
		dineroDisponible -= viaje.precio()
		localidadOrigen = destino
	}
	
	method kmsUsuario() {
		return viajes.sum({viaje => viaje.kmViaje()})
	}
	
	method seguirUsuario(usuario) {
		listaSeguidos.add(usuario)
		usuario.listaSeguidos().add(self)
	}


}

class MedioDeTransporte{
	var property cuantoTardaPorKm 
	var property cuantoCuestaPorKm 
}

class Viaje{
	const property origen
	const property destino
	const property transporte
	
	method precio(){
		return transporte.cuantoCuestaPorKm() * origen.distanciaA(destino) + destino.precio()
	}
	method kmViaje(){
		return origen.distanciaA(destino)
	}

}