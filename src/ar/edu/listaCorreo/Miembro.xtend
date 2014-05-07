package ar.edu.listaCorreo

class Miembro {
	
	@Property String mail
	@Property int mailsEnviados = 0
	@Property boolean bloqueado = false
	
	new(String pMail) {
		mail = pMail
	}
	
	def bloquearSiMandoMucho(){
		if(this.envioMuchosMensajes())
			this.bloquear()
	}
	def boolean envioMuchosMensajes() {
		mailsEnviados >= 5
	}
	
	def void bloquear() {
		bloqueado = true
	}

	def void desbloquear() {
		bloqueado = false
	}
	
	def incrementarMailsEnviados() {
		this.mailsEnviados = this.mailsEnviados + 1
	}
}