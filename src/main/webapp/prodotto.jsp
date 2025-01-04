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
<div class="container">
    <form action="Carrello" method="POST">

        <div class = "image-container">
            <img src="<%=request.getContextPath()%>/<%= prodotto.getImagePath()%>">
        </div>
        <div class = "title-container">
            <span class = "title"><%= prodotto.getNomeProdotto() %></span>
        </div>
        <div class = "price-container">
            <span class = "price">Prezzo: <%= prodotto.getPrezzo() %></span>
        </div>
        <div class = "quantity-container">
            <input type="hidden" name="quantitaDisp" value="<%= prodotto.getQuantitaDisponibile() %>" id="quantitaDisp">
            <span id="quantitaMax">Quantita' disponibili: <%= prodotto.getQuantitaDisponibile() %></span>
        </div>
        <div class = "container-inputQuantity">
            <label for = "quantitaIn">Quantita':</label>
            <div class = "container-quantitaIn">
                <button type="button" class="minus">-</button>
                <input type="number" name="quantitaProdotto" id="quantitaIn" min="1" max="<%= prodotto.getQuantitaDisponibile() %>" value="1" required readonly>
                <button type="button" class="plus">+</button>

            </div>
            <input type="submit" value="Aggiungi al carrello" id="submitForm">
        </div>
        <input type="hidden" name="idProdotto" value="<%= prodotto.getIdProdotto() %>">


    </form>
</div>
</body>
</html>