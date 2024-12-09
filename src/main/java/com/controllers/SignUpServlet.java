package com.controllers;

import com.DAO.UtenteDAO;
import com.entities.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/SignUp")
public class SignUpServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		// Verifica se l'utente esiste
		boolean existingUser = UtenteDAO.findUtente(username, email);

		if (!existingUser) {
			// Utente non esiste, registra
			Utente newUtente = new Utente(username, email, password);
			UtenteDAO.registraUtente(newUtente.getUsername(), newUtente.getEmail(), newUtente.getPassword());

			// Passa l'oggetto utente alla JSP
			req.setAttribute("utente", newUtente);
			req.getRequestDispatcher("confirmSignUp.jsp").forward(req, resp);
		} else {
			// Imposta l'attributo di errore e inoltra alla pagina di registrazione
			req.setAttribute("errore", "Username o Email già registrati");
			req.getRequestDispatcher("signUp.jsp").forward(req, resp);
		}
	}
}

