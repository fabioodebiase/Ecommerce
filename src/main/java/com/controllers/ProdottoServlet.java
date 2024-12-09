package com.controllers;

import com.DAO.ProdottoDAO;
import com.entities.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Prodotto")
public class ProdottoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int prodottoId = Integer.parseInt(req.getParameter("id"));
        Prodotto prodotto = ProdottoDAO.getProdottoById(prodottoId);
        req.setAttribute("prodotto",prodotto);
        req.getRequestDispatcher("prodotto.jsp").forward(req,resp);
    }
}
