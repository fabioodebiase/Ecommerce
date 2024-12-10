package com.controllers;

import com.DAO.ProdottoDAO;
import com.entities.Prodotto;
import com.entities.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Carrello")
public class CarrelloServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Recupera il prodotto selezionato
        int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
        Prodotto prodottoCarrello = ProdottoDAO.getProdottoById(idProdotto);

        // Recupera l'utente corrente dalla sessione
        HttpSession session = req.getSession();

        // Recupera o crea un nuovo carrello
        List <Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        if (carrello == null) {
            // Crea un nuovo carrello se non esiste o appartiene a un altro utente
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        // Aggiungi il prodotto al carrello
        carrello.add(prodottoCarrello);

        // Reindirizza alla pagina del carrello
        req.getRequestDispatcher("carrello.jsp").forward(req, resp);
    }
}