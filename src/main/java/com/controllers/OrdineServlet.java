package com.controllers;

import com.entities.Ordine;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/Ordine")
public class OrdineServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int idUtente = Integer.parseInt(req.getParameter("idUtente"));
        int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
        int quantita =  Integer.parseInt(req.getParameter("quantita"));

        Ordine ordine = new Ordine();

        ordine.setIdUtente(idUtente);
        ordine.setIdProdotto(idProdotto);
        ordine.setQuantita(quantita);




    }
}
