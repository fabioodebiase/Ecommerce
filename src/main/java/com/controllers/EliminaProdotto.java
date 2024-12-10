package com.controllers;

import com.DAO.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/eliminaProdotto")
public class EliminaProdotto extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
		ProdottoDAO.deleteProdotto(idProdotto);
		resp.sendRedirect("adminHome.jsp");
	}
}
