package ar.edu.listaCorreo

import java.util.List

class Post {

	@Property Miembro emisor
	@Property Lista destino
	@Property String mensaje

	new(Miembro pEmisor, String pMensaje, Lista pDestino) {
		emisor = pEmisor
		mensaje = pMensaje
		destino = pDestino
	}
	
	def tiene(String palabra) {
		palabrasDelMensaje.contains(palabra)
	}

	def List<String> palabrasDelMensaje() {
		mensaje.split(" ")
	}
}