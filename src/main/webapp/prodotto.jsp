<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Shop</title>
    <link rel="stylesheet" href="css/prodotto.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const plusButton = document.querySelector(".plus");
            const minusButton = document.querySelector(".minus");
            const quantitaInput = document.querySelector("#quantitaIn");
            const maxQuantita = parseInt(document.querySelector("#quantitaMax").textContent.split(":")[1].trim(), 10);

            // Incrementa la quantità
            plusButton.addEventListener("click", function () {
                let currentValue = parseInt(quantitaInput.value, 10) || 1;
                if (currentValue < maxQuantita) {
                    quantitaInput.value = currentValue + 1;
                }
            });

            // Decrementa la quantità
            minusButton.addEventListener("click", function () {
                let currentValue = parseInt(quantitaInput.value, 10) || 1;
                if (currentValue > 1) {
                    quantitaInput.value = currentValue - 1;
                }
            });
        });
    </script>
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
%>
<main class="container">

    <form action="Carrello" method="POST">
        <div class = "image-container">
            <img style = "width: 200px" src="<%=request.getContextPath()%>/<%= prodotto.getImagePath()%>">
        </div>
        <div class = "name-container">
            <p><span class = "title"><%= prodotto.getNomeProdotto() %></span></p>
        </div>
        <div class = "price-container">
            <p>Prezzo: <%= prodotto.getPrezzo() %></p>
        </div>
        <div class = "quantity-container">
            <input type="hidden" name="quantitaDisp" value="<%= prodotto.getQuantitaDisponibile() %>" id="quantitaDisp">
            <p id="quantitaMax">Quantita' disponibili: <%= prodotto.getQuantitaDisponibile() %></p>
        </div>

        <label for="quantitaIn">Quantita':</label>
        <button type="button" class="minus">-</button>
        <input type="number" name="quantitaProdotto" id="quantitaIn" min="1" max="<%= prodotto.getQuantitaDisponibile() %>" value="1" required>
        <button type="button" class="plus">+</button>

        <input type="hidden" name="idProdotto" value="<%= prodotto.getIdProdotto() %>">
        <input type="submit" value="Aggiungi al carrello" id="submitForm">
    </form>
</body>
</html>