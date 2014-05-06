package ar.edu.listaCorreo

import ar.edu.listaCorreo.exceptions.BusinessException
import ar.edu.listaCorreo.senders.Mail
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import ar.edu.listaCorreo.senders.StubMailSender
import ar.edu.listaCorreo.senders.MailSenderProvider

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

	@Before
	def void init() {
		/** Seteo MailSender para tests */
		MailSenderProvider.setInstance(stubMailSender)
		
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

		/** en la de alumnos hay alumnos y profes */
		listaAlumnos.agregarMiembro(dodain)
		listaAlumnos.agregarMiembro(deby)
		listaAlumnos.agregarMiembro(fede)

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


	/*************************************************************/
	/*                     TESTS CON MOCKS                       */
	/*                  TEST DE COMPORTAMIENTO                   */
	/*************************************************************/
	
//TODO: 
//	@Test
//	def void testEnvioPostAListaAlumnosLlegaATodosLosOtrosSuscriptos() {
//		//creacion de mock
//		var mockedMailSender = mock(typeof(MessageSender))
//		listaAlumnos.agregarPostObserver(new MailObserver(mockedMailSender))
//
//		// un alumno envía un mensaje a la lista
//		listaAlumnos.enviar(mensajeDodainAlumnos)
//
//		//verificacion
//		//test de comportamiento, verifico que se enviaron 2 mails 
//		// a fede y a deby, no así a dodi que fue el que envió el post
//		verify(mockedMailSender, times(2)).send(any(typeof(Mail)))
//	}
	
}
