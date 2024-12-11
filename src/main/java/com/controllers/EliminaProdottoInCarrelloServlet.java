package com.controllers;

import com.entities.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@WebServlet("/EliminaProdottoInCarrello")
public class EliminaProdottoInCarrelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
        HttpSession session = req.getSession();
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        for (int i = 0; i < carrello.size(); i++) {
            if (carrello.get(i).getIdProdotto() == idProdotto){
                carrello.remove(i);
            }
        }

        resp.sendRedirect("carrello.jsp");
    }
}
