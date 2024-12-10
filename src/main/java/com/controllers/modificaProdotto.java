package com.controllers;

import com.DAO.ProdottoDAO;
import com.entities.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

@MultipartConfig
@WebServlet("/modificaProdotto")
public class modificaProdotto extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
		Prodotto prodotto = ProdottoDAO.getProdottoById(idProdotto);
		req.setAttribute("prodotto", prodotto);
		req.getRequestDispatcher("modificaProdotto.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Prodotto prodottoAggiornato = new Prodotto();
		prodottoAggiornato.setIdProdotto(Integer.parseInt(req.getParameter("idProdotto")));
		prodottoAggiornato.setNomeProdotto(req.getParameter("nomeProdotto"));
		prodottoAggiornato.setPrezzo(Double.parseDouble(req.getParameter("prezzo")));
		prodottoAggiornato.setQuantitaDisponibile(Integer.parseInt(req.getParameter("quantitaDisponibile")));

		Part imagePart = req.getPart("imagePath");
		if (imagePart != null) {
			String imagePath = "/files/" + imagePart.getSubmittedFileName();
			prodottoAggiornato.setImagePath(imagePath);

			// Salva l'immagine sul server
			String uploadPath = req.getServletContext().getRealPath("/files");
			File uploadFile = new File(uploadPath, imagePart.getSubmittedFileName());
			try (InputStream inputStream = imagePart.getInputStream();
			     FileOutputStream outputStream = new FileOutputStream(uploadFile)) {
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
			}
		}

		ProdottoDAO.updateProdotto(prodottoAggiornato);

		resp.sendRedirect("adminHome.jsp");
	}

}
