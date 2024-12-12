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
        int quantita =  Integer.parseInt(req.getParameter("quantitaProdotto"));
        double totale = Double.parseDouble(req.getParameter("totale"));

    }
}
