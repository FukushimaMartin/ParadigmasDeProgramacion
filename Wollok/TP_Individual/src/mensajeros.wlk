// paquetes
class Paquete{
	var property destino
	var property pago
	var property precio
	
	constructor(_destino,_pago,_precio){
		destino = _destino
		pago = _pago
		precio = _precio
	}
	constructor(_pago){
		pago = _pago
	}
	
	method puedeSerEntregadoPor(mensajero) {
		return mensajero.llegar(destino) and self.pago()
	}
}

class PaqueteOriginal inherits Paquete{
	
	constructor(_destino) = super(_destino,false,50){
		destino = _destino
	}

}
class Paquetito inherits Paquete{
	
	constructor(_destino) = super(_destino,true,0){
		destino = _destino
	}

	override method puedeSerEntregadoPor(mensajero) = true
}
class PaquetonViajero inherits Paquete{
	const property destinos = []
	var property pagar = 0
	
	constructor(_destinos) = super(false){
		destinos = _destinos
	}
	
	override method precio(){
		return destinos.size() * 100
	}
	method pagar(valor){
		pagar += valor
	}
	override method pago(){
		return pagar >= self.precio()
	}
	override method puedeSerEntregadoPor(mensajero) {
		return destinos.all({destino => mensajero.llegar(destino)}) and self.pago()
	}
	
}
class PaquetuliAzulViteh inherits Paquete{	
	constructor() = super(laMatrix,false,500)
	
	method pagar(valor){
		if (valor >= precio){
			pago = true
		}
	}
	method hastaDondeVa(){
		return "hasta la matri viteh"
	}
}

// mensajeros
class Mensajero{
	var property peso
	var property llamar
	
	constructor(_peso,_llamar){
		peso = _peso
		llamar = _llamar
	}
	
	method llegar(destino) = destino.pasar(self)
}

object roberto{
	var property peso = 0
	var property transporte
	
	method viajaEn(movil){
		transporte = movil
	}
	method peso() = peso + transporte.peso()
	method llegar(destino) = destino.pasar(self)
	method llamar() = false
}

object chuckNorris{
	var property peso = 900
	
	method llamar() = true
	method llegar(destino) = destino.pasar(self)
}

object neo{
	const property peso = 0
	var credito = 0
	
	method llamar() = credito > 0
	method cargarCredito(cantidad) {
		credito = cantidad
	}
	method llegar(destino) = destino.pasar(self)
	
}
object elViejoDeLocoArts{
	const property peso = 110
	var chaleco = false
	
	method teneChalecoViteh(){
		chaleco = true
	}
	method llamar(){
		return chaleco
	}
	method teGustanLosGatos(){
		return "Es false viteh, ese es Alf, a mi me gustan lo chaleco viteh"
	}
	method llegar(destino) = destino.pasar(self)
}

// destinos
object puenteBrooklyn{
	method pasar(alguien) = alguien.peso() < 1000
}

object laMatrix{
	method pasar(alguien) = alguien.llamar()
}

// transportes
object bici{
	const property peso = 1
}
object camion{
	var property acoplados = 0
	
	method peso() = 500 * acoplados

}

object mensajeria{
	const property mensajeros = []
	const property paquetesPendientes = []
	const property paquetes = []

	
	method contratar(alguien){
		mensajeros.add(alguien)
	}
	method despedir(alguien){
		mensajeros.remove(alguien)
	}
	method despedirATodos(){
		mensajeros.removeAll(self.mensajeros())
	}
	method esGrande() = mensajeros.size() > 2
	
	method entregaElPrimero(paquete){
		return paquete.puedeSerEntregadoPor(mensajeros.first()) 
	}
	method elPesoDelUltimo(){
		return mensajeros.last().peso()
	}
	//1
	method algunoEntrega(paquete){
		return mensajeros.any({mensajero=>paquete.puedeSerEntregadoPor(mensajero)})
	}
	//3
	method sobrepeso(){
		return (mensajeros.sum({mensajero=>mensajero.peso()}) / mensajeros.size()) > 500
	}
	//2
	method puedenLlevarPaquete(paquete){		
		return mensajeros.filter({mensajero=>paquete.puedeSerEntregadoPor(mensajero)})
	}
	//4
	method enviarPaquete(paquete){
		
		if (self.puedenLlevarPaquete(paquete) == []){
			paquetesPendientes.add(paquete)
			paquetes.remove(paquete)
		} else {
			(self.puedenLlevarPaquete(paquete)).anyOne()
			paquetes.remove(paquete)
		}
	}
	//5
	method enviarTodosLosPaquetes(){
		paquetes.forEach({paquete => self.enviarPaquete(paquete)})
	}
	//6
	method paquetePendienteMasCaro(){
		var paquete
		paquete = paquetesPendientes.max({paquete=>paquete.precio()})
		if (self.puedenLlevarPaquete(paquete) != []){
			self.agregarPaquete(paquete)
			paquetesPendientes.remove(paquete)
			self.enviarPaquete(paquete)
		}
		return paquete
	}
	method agregarPaquete(paquete){
		paquetes.add(paquete)
	}	
	
}