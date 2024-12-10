package com.controllers;

import com.DAO.UtenteDAO;
import com.entities.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		//Controllo delle credenziali
		Utente utenteLoggato = UtenteDAO.getUtenteByCredentials(email, password);
		if (utenteLoggato != null) {
			HttpSession session = req.getSession();
			session.setAttribute("user", utenteLoggato);
			req.getRequestDispatcher("home.jsp").forward(req, resp);
		} else {
			req.setAttribute("errore", "Credenziali errate!");
			req.getRequestDispatcher("signUp.jsp").forward(req, resp);
		}
	}
}
