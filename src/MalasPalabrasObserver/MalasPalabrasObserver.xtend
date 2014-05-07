package MalasPalabrasObserver

import java.util.List
import java.util.ArrayList
import ar.edu.listaCorreo.Post
import ar.edu.listaCorreo.observers.PostObserver

class MalasPalabrasObserver implements PostObserver{
	List<String> malasPalabras = new ArrayList<String>
	List<Post> postConMalasPalabras = new ArrayList<Post>

	override send(Post post) {
		if (tieneMalasPalabras(post)) {
			println("Mensaje enviado a admin por mensaje con malas palabras: " + post.mensaje)
			postConMalasPalabras.add(post)
		}
	}

	def boolean tieneMalasPalabras(Post post) {
		malasPalabras.exists [ malaPalabra | post.tiene(malaPalabra) ]
	}

	def void agregarMalaPalabra(String palabra) {
		malasPalabras.add(palabra)
	}

	def mensajesConMalasPalabras() {
		postConMalasPalabras
	}
	
}