// paquetes

object paquete{
	var property destino
	var property pago = false
	const property precio = 50


	method puedeSerEntregadoPor(mensajero) {
		return destino.puedePasar(mensajero) and self.pago()
	}
}

object paquetito{
	var property destino
	const property precio = 0
	const property pago = true

	method puedeSerEntregadoPor(mensajero) = true
}

object paquetonViajero{
	const property destinos = []
	var property importePagado = 0

	method precio(){
		return destinos.size() * 100
	}
	method pagar(valor){
		importePagado += valor
	}
	method pago(){
		return importePagado >= self.precio()
	}
	method puedeSerEntregadoPor(mensajero) {
		return destinos.all({destino => destino.puedePasar(mensajero)}) and self.pago()
	}

}
object paquetuliAzulViteh{
	const property destino = laMatrix
	var property pago = false
	var property precio = 500
	
	method pagar(valor){
		if (valor >= precio){
			pago = true
		}
	}
	method hastaDondeVa(){
		return "hasta la matri viteh"
	}
	method puedeSerEntregadoPor(mensajero) {
		return destino.puedePasar(mensajero) and self.pago()
	}
}

// mensajeros

object roberto{
	var property peso = 0
	var property transporte
	
	method viajaEn(movil){
		transporte = movil
	}
	method peso() = peso + transporte.peso()
	method puedeLlamar() = false
}

object chuckNorris{
	const property peso = 900
	
	method puedeLlamar() = true
}

object neo{
	const property peso = 0
	var credito = 0
	
	method puedeLlamar() = credito > 0
	method cargarCredito(cantidad) {
		credito = cantidad
	}
	
}
object elViejoDeLocoArts{
	const property peso = 110
	var chaleco = false
	
	method teneChalecoViteh(){
		chaleco = true
	}
	method puedeLlamar(){
		return chaleco
	}
	method teGustanLosGatos(){
		return "Es false viteh, ese es Alf, a mi me gustan lo chaleco viteh"
	}
}

// destinos
object puenteBrooklyn{
	method puedePasar(mensajero) = mensajero.peso() < 1000
}

object laMatrix{
	method puedePasar(mensajero) = mensajero.puedeLlamar()
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

	
	method contratar(alguien){
		mensajeros.add(alguien)
	}
	method despedir(alguien){
		mensajeros.remove(alguien)
	}
	method despedirATodos(){
		mensajeros.clear()
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
		if (!self.algunoEntrega(paquete)){
			paquetesPendientes.add(paquete)
		}
	}
	//5
	method enviarTodosLosPaquetes(paquetes){
		paquetes.forEach({paquete => self.enviarPaquete(paquete)})
	}
	//6
	method enviarPaquetePendienteMasCaro(){
		var paquete
		paquete = paquetesPendientes.max({paquete=>paquete.precio()})
		if (self.algunoEntrega(paquete)){
			paquetesPendientes.remove(paquete)
			self.enviarPaquete(paquete)
		}
	}	
	
}