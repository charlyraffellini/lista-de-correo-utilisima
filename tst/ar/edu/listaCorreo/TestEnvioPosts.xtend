package ar.edu.listaCorreo

import ar.edu.listaCorreo.senders.StubMailSender
import org.junit.Before
import ar.edu.listaCorreo.observers.MailObserver
import ar.edu.listaCorreo.exceptions.BusinessException
import org.junit.Test
import ar.edu.listaCorreo.senders.Mail
import ar.edu.listaCorreo.senders.MessageSender
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.junit.Assert
import MalasPalabrasObserver.MalasPalabrasObserver
import ar.edu.listaCorreo.observers.BloqueoUsuarioVerbosoObserver

class TestEnvioPosts {

	Lista listaProfes
	Lista listaAlumnos
	Miembro dodain
	Miembro nico
	Miembro deby
	Miembro alumno
	Miembro fede
	Post mensajeAlumno
	Post mensajeDodainAlumnos
	Post mensajeDodainProfes
	StubMailSender stubMailSender = new StubMailSender
	MalasPalabrasObserver malasPalabrasObserver = new MalasPalabrasObserver

	@Before
	def void init() {

		/** Listas de correo */
		listaAlumnos = Lista.listaAbierta()
		listaProfes = Lista.listaCerrada()

		/** Profes */
		dodain = new Miembro("fernando.dodino@gmail.com")
		nico = new Miembro("nicolas.passerini@gmail.com")
		deby = new Miembro("debyfortini@gmail.com")

		/** Alumnos **/
		alumno = new Miembro("alumno@uni.edu.ar")
		fede = new Miembro("fede@uni.edu.ar")

		/** en la lista de profes están los profes */
		listaProfes.agregarMiembro(dodain)
		listaProfes.agregarMiembro(nico)
		listaProfes.agregarMiembro(deby)
		listaProfes.agregarPostObserver(new MailObserver(stubMailSender))

		/** en la de alumnos hay alumnos y profes */
		listaAlumnos.agregarMiembro(dodain)
		listaAlumnos.agregarMiembro(deby)
		listaAlumnos.agregarMiembro(fede)
		listaAlumnos.agregarPostObserver(new MailObserver(stubMailSender))
		listaAlumnos.agregarPostObserver(malasPalabrasObserver)

		mensajeAlumno = new Post(alumno, "Hola, queria preguntar que es la recursividad", listaProfes)
		mensajeDodainAlumnos = new Post(dodain,
			"Para explicarte recursividad tendría que explicarte qué es la recursividad", listaAlumnos)
		mensajeDodainProfes = new Post(dodain, "Cuantos TPs hacemos?", listaProfes)
	}

	/*************************************************************/
	/*                     TESTS CON STUBS                       */
	/*                      TEST DE ESTADO                       */
	/*************************************************************/
	@Test(expected=typeof(BusinessException))
	def void alumnoNoPuedeEnviarPostAListaProfes() {
		listaProfes.enviar(mensajeAlumno)
	}

	@Test
	def void alumnoPuedeEnviarMailAListaAbierta() {
		Assert.assertEquals(0, stubMailSender.mailsDe("alumno@uni.edu.ar").size)
		listaAlumnos.enviar(mensajeAlumno)
		Assert.assertEquals(1, stubMailSender.mailsDe("alumno@uni.edu.ar").size)
	}
	
	@Test
	def void alumnoEnviaMailConMalaPalabra() {
		val mensajeFeo = new Post(alumno, "Cuál es loco! Me tienen podrido", listaAlumnos)
		malasPalabrasObserver.agregarMalaPalabra("podrido")
		listaAlumnos.enviar(mensajeFeo)
		Assert.assertEquals(1, malasPalabrasObserver.mensajesConMalasPalabras.size)
	}
	
	@Test
	def void cuandoUnAlumnoMandaMuchosMensajesQuedaBloqueado(){
		listaAlumnos.agregarPostObserver(new BloqueoUsuarioVerbosoObserver)
		val mensaje = new Post(alumno, "Una consulta: como se hace el TP?", listaAlumnos)
		listaAlumnos.enviar(mensaje)
		listaAlumnos.enviar(mensaje)
		listaAlumnos.enviar(mensaje)
		listaAlumnos.enviar(mensaje)
		listaAlumnos.enviar(mensaje)
		listaAlumnos.enviar(mensaje)
		Assert.assertTrue(alumno.bloqueado)
	}

	/*************************************************************/
	/*                     TESTS CON MOCKS                       */
	/*                  TEST DE COMPORTAMIENTO                   */
	/*************************************************************/
	@Test
	def void testEnvioPostAListaAlumnosLlegaATodosLosOtrosSuscriptos() {
		//creacion de mock
		var mockedMailSender = mock(typeof(MessageSender))
		listaAlumnos.agregarPostObserver(new MailObserver(mockedMailSender))

		// un alumno envía un mensaje a la lista
		listaAlumnos.enviar(mensajeDodainAlumnos)

		//verificacion
		//test de comportamiento, verifico que se enviaron 2 mails 
		// a fede y a deby, no así a dodi que fue el que envió el post
		verify(mockedMailSender, times(2)).send(any(typeof(Mail)))
	}
	
}
