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
        int quantitaSel = Integer.parseInt(req.getParameter("quantitaProdotto"));
        prodottoCarrello.setQuantitaSel(quantitaSel);
        // Recupera l'utente corrente dalla sessione
        HttpSession session = req.getSession();
        List <Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        if (carrello == null) {
            // Crea un nuovo carrello se non esiste o appartiene a un altro utente
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        // Controlla se il prodotto è già presente nel carrello
        boolean prodottoEsistente = false;
        for (Prodotto prodotto : carrello) {
            if (prodotto.getIdProdotto() == idProdotto) {
                // Aggiorna la quantità del prodotto esistente
                prodotto.setQuantitaSel(prodotto.getQuantitaSel() + quantitaSel);
                prodottoEsistente = true;
                break;
            }
        }

        if (!prodottoEsistente) {
            // Aggiungi il prodotto al carrello
            carrello.add(prodottoCarrello);
        }

        // Reindirizza alla pagina del carrello
        resp.sendRedirect("carrello.jsp");
    }
}