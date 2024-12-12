package com.controllers;

import com.DAO.OrdineDAO;
import com.entities.Ordine;
import com.entities.Prodotto;
import com.entities.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/Ordine")
public class OrdineServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        double totale = Double.parseDouble(req.getParameter("totale"));
        Utente utente = (Utente) session.getAttribute("user");
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        Ordine newOrdine = new Ordine();
        newOrdine.setIdUtente(utente.getIdUtente());
        newOrdine.setTotaleOrdine(totale);
        OrdineDAO.aggiungiOrdine(newOrdine);

        int idOrdine = OrdineDAO.getIdOrdine(utente.getIdUtente());

        for (Prodotto p : carrello){
            //Aggiustare l invio della quantità selezionata
            int quantitaSel = Integer.parseInt(req.getParameter("quantitaProdotto"));
            p.setQuantitaSel(quantitaSel);
            OrdineDAO.aggiungiDettagliOrdine(idOrdine,p.getIdProdotto(),p.getQuantitaSel());
        }
    }
}
