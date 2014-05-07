package ar.edu.listaCorreo.observers

import ar.edu.listaCorreo.observers.PostObserver
import ar.edu.listaCorreo.Post

class BloqueoUsuarioVerbosoObserver implements PostObserver {
	
	override send(Post post) {
		val emisor = post.emisor
		emisor.bloquearSiMandoMucho()		
	}
}