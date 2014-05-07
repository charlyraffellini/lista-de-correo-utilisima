package ar.edu.listaCorreo

class Miembro {
	
	@Property String mail
	@Property int mailsEnviados = 0

	new(String pMail) {
		mail = pMail
	}
}