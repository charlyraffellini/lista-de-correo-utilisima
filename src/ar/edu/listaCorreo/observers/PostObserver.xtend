package ar.edu.listaCorreo.observers

import ar.edu.listaCorreo.Post

interface PostObserver {
	
	def void send(Post post)
	
}