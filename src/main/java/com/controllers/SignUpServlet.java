package com.controllers;

import com.DAO.UtenteDAO;
import com.entities.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/SignUp")
public class SignUpServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		boolean sameUsername = false;
		boolean sameEmail = false;
		//lista degli utenti
		List<Utente> listaUtenti = UtenteDAO.getAllUtenti();
		//ciclo pe r controllo dell'email e del username
		for (Utente utente : listaUtenti) {
			// Verifica se l'utente con username e email uguali esiste
			if (utente.getUsername().equals(username)) {
				sameUsername = true;
				break;
			}
			for (Utente utente2 : listaUtenti) {
				if (utente2.getEmail().equals(email)) {
					sameEmail = true;
					break;
				}
			}
		}
		// Verifica se email e surname esistono
		if (sameUsername) {
			// Imposta l'attributo di errore e inoltra alla pagina di registrazione
			req.setAttribute("errore", "Username gia' utilizzato!");
			req.getRequestDispatcher("signUp.jsp").forward(req, resp);
		} else if (sameEmail) {
			// Imposta l'attributo di errore e inoltra alla pagina di registrazione
			req.setAttribute("errore", "Email gia' utilizzata!");
			req.getRequestDispatcher("signUp.jsp").forward(req, resp);
		} else {
			// Se non è utilizzata fa la registrazione
			Utente newUtente = new Utente(username, email, password);
			UtenteDAO.registraUtente(newUtente.getUsername(), newUtente.getEmail(), newUtente.getPassword());
			// Passa l'oggetto utente alla JSP
			req.setAttribute("utente", newUtente);
			req.getRequestDispatcher("confirmSignUp.jsp").forward(req, resp);
		}
	}
}

