package com.controllers;

import com.DAO.OrdineDAO;
import com.DAO.ProdottoDAO;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Ordine")
public class OrdineServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //richiedo la sessione
        HttpSession session = req.getSession();
        //richiedo la lista dei prodotti (carrello) dalla sessione
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        try{

            //prendo il totale dal jsp
            double totale = Double.parseDouble(req.getParameter("totale"));
            //richiedo l'oggetto utente dalla sessione
            Utente utente = (Utente) session.getAttribute("user");
            Ordine newOrdine = new Ordine();
            newOrdine.setIdUtente(utente.getIdUtente());
            newOrdine.setTotaleOrdine(totale);
            //creo un oggetto ordine e setto gli attributi
            //che mi serviranno nel DAO
            OrdineDAO.aggiungiOrdine(newOrdine);

            int idOrdine = OrdineDAO.getIdOrdine(utente.getIdUtente());
            newOrdine.setIdOrdine(idOrdine);

            //ciclo la lista di prodotti da aggiungere a DB
            for (Prodotto p : carrello){
                //prendo la quantità selezionata aggiungendo l'id del prodotto
                //faccio la stessa cosa nel jsp
                int quantitaSel = Integer.parseInt(req.getParameter("quantitaSel_" + p.getIdProdotto()));
                newOrdine.setQuantita(quantitaSel);
                newOrdine.setIdProdotto(p.getIdProdotto());
                //aggiungo i prodotti nella tabella dettaglio_prodotti
                OrdineDAO.aggiungiDettagliOrdine(newOrdine.getIdOrdine(),newOrdine.getIdProdotto(),newOrdine.getQuantita());
                //aggiorno la quantità disponibile
                int quantitaCalcolata = p.getQuantitaDisponibile() - quantitaSel;
                ProdottoDAO.updateQuantitaProdotto(quantitaCalcolata, p.getIdProdotto());
            }
            session.setAttribute("carrello" , null);
            req.getRequestDispatcher("confirmOrdine.jsp").forward(req,resp);
        }catch(Exception e){
            req.setAttribute("errore", e.getMessage());
            req.getRequestDispatcher("carrello.jsp").forward(req,resp);
        }

    }
}
