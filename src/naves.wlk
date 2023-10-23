class Nave {
	
	var velocidad   //
	var direccion   //
	var combustible //
	
	//  method velocidad() = velocidad
	
	//  method direcicon() = direccion
	
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto)  //
	}
	
	method desacelerar(cuanto){
		velocidad = 0.max(velocidad - cuanto)  //	
	}
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method EscaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoDelSol() {
		direccion = -10.max(direccion - 1)
	}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method cargarCombustible(cantidad){
		combustible += cantidad
	}
	
	method descargarCombustible(cantidad){
		combustible = 0.max(combustible - cantidad)
	}
	
	method estaTranquila(){
		return combustible >= 4000 or velocidad < 12000
	}
	
	method estaDeRelajo(){
		return self.estaTranquila()
	}
	
	//    method avisar()
	
	//    method escapar()
	
	//    method recibirAmenaza(){
	//	      self.escapar()
	//	      self.avisar()
	
	// 	  method pocaActividad()
	
}

////////////////////////////////////////////////////////////////////

class Baliza inherits Nave {
	
	var colorNave
	var cantCambioColor
	
	// 	   method color() = color
	
	method cambiarColorDeBaliza(colorNuevo) {
		cantCambioColor ++
		colorNave = colorNuevo
	}
	
	override method prepararViaje() {
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	
	override method estaTranquila(){
		return super() and colorNave != "rojo"
	}
	
	method escapar(){
		self.irHaciaElSol()
	}
	method avisar(){
		self.cambiarColorDeBaliza("rojo")
	}
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	override method estaDeRelajo(){
		return super() and cantCambioColor == 0
	}
}

class Pasajeros inherits Nave {
	var pasajeros
	var comida
	var bebida 
	var descargadas = 0
	
	method pasajeros() = pasajeros
	method comida() = comida
	method bebida()	= bebida
	
	method pasajeros(cantidad){
		pasajeros = cantidad
	}
	
	method cargarComida(unaCantidad) {
		comida += unaCantidad
	}
	method cargarBebida(unaCantidad){
		bebida += unaCantidad
	}
	method desCargarComida(unaCantidad) {
		comida = 0.max(comida -unaCantidad)
		descargadas += unaCantidad
	}
	method desCargarBebida(unaCantidad){
		bebida = 0.max(bebida - unaCantidad)
	}
	
	override method prepararViaje() {
		super()
		self.cargarComida(pasajeros * 4)
		self.cargarBebida(pasajeros * 6)
		self.acercarseUnPocoAlSol()
	}
	
	method escapar(){
		velocidad = velocidad * 2
	}
	method avisar(){
		self.desCargarComida(pasajeros)
		self.desCargarBebida(pasajeros * 2)
	}
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
}

class Combate inherits Nave {
	var invisible
	var misiles
	const mensajes = []
	
	method ponerseVisible() { invisible = false}
	method ponerseInvisible(){ invisible  = true}
	method estaInvisible() = invisible
	
	method desplegarMisiles(){misiles = true}
	method replegarMisiles(){misiles = false}
	method misilesDesplegados() = misiles
	
	method emitirMensaje(mensaje){
		 mensajes.add(mensaje)
	}
	method mensajesEmitidos(){	
		return mensajes.size()
	}
	method primerMensajeEmitido(){
		if (mensajes.isEmpty())
			self.error("No hay mensajes") // por si no emitio mensajes
		return mensajes.first()
	}
	method ultimoMensajeEmitido(){
		if (mensajes.isEmpty())
			self.error("No hay mensajes")
		return mensajes.last()
	}
	method esEscueta(){
		return mensajes.all({m=> m.size() <=30})
	}
	method emitioMensaje(unMensaje){
		return mensajes.contains(unMensaje)
	}
	
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("saliendo en mision")
	}
	
	override method estaTranquila(){
		return super() and not self.misilesDesplegados()
	}
	
	method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	method avisar(){
		self.emitirMensaje("amenaza recibida")
	}
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
}

class Hospital inherits Pasajeros{
	
	var property quirofanosPreparados = false
	
	override method estaTranquila(){
		super()
		return not self.quirofanosPreparados()
	}
	
	override method recibirAmenaza(){
		super()
		quirofanosPreparados = true
	}
} 

class Sigilosa inherits Combate{
	override method estaTranquila(){
		super()
		return not self.estaInvisible()
	}
	
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
} 
























