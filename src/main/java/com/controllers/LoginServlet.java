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
        String usernameEmail = req.getParameter("usernameEmail");
        String password = req.getParameter("password");

        boolean existingUser = UtenteDAO.findUtente(usernameEmail,usernameEmail);
        if (existingUser){
            if (UtenteDAO.controlloLogin(usernameEmail,usernameEmail,password)){
                //utente loggato con id assegnato tramite metodo DAO
                Utente loggedUser = UtenteDAO.getUtenteByUsername(usernameEmail,usernameEmail);
                //Recupero la checkbox

                //Creazione della sessione
                //Istanziamo l oggetto utente nella sessione
                HttpSession session = req.getSession();
                session.setAttribute("user" , loggedUser);
                req.getRequestDispatcher("home.jsp").forward(req,resp);
            } else {
                req.setAttribute("errore","Credenziali errate!");
                req.getRequestDispatcher("login.jsp").forward(req,resp);
            }
        } else {
            req.setAttribute("errore","Utente inesistente!");
            req.getRequestDispatcher("Home").forward(req,resp);
        }
    }
}
