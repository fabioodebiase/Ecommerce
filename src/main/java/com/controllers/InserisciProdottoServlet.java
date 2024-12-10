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

import java.io.*;
import java.nio.file.Paths;

@MultipartConfig
@WebServlet("/InserisciProdotto")
public class InserisciProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Recupero parametri dal form
            String nomeProdotto = req.getParameter("nomeProdotto");
            double prezzoProdotto = Double.parseDouble(req.getParameter("prezzoProdotto"));
            int quantitaProdotto = Integer.parseInt(req.getParameter("quantitaDisponibile"));

            // Validazione di base
            if (nomeProdotto == null || nomeProdotto.isEmpty() || prezzoProdotto <= 0 || quantitaProdotto < 0) {
                req.setAttribute("error", "Dati del prodotto non validi.");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            // Recupero del file dal form
            Part part = req.getPart("file");
            if (part == null || part.getSize() == 0) {
                req.setAttribute("error", "File non valido o mancante.");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
            }

            // Nome del file e percorso di salvataggio relativo
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/files");
            File uploadPath = new File(uploadDir);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs(); // Creazione della directory se non esiste
            }
            String filePath = "files/" + fileName; // Percorso relativo

            // Caricamento del file
            try (InputStream is = part.getInputStream();
                 FileOutputStream fos = new FileOutputStream(new File(uploadPath, fileName))) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // Creazione e salvataggio del prodotto
            Prodotto newProdotto = new Prodotto();
            newProdotto.setNomeProdotto(nomeProdotto);
            newProdotto.setPrezzo(prezzoProdotto);
            newProdotto.setQuantitaDisponibile(quantitaProdotto);
            newProdotto.setImagePath(filePath); // Percorso relativo
            ProdottoDAO.aggiungiProdotto(newProdotto);

            req.getRequestDispatcher("adminHome.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Errore durante l'inserimento del prodotto.");
            req.getRequestDispatcher("adminHome.jsp").forward(req, resp);
        }
    }
}