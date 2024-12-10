<%@ page import="com.entities.Prodotto" %>
<%
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
%>
<html>
<head>
    <title>Modifica Prodotto</title>
</head>
<body>

<form action="modificaProdotto" method="post" enctype="multipart/form-data">
    <h1>Modifica Prodotto</h1>
    <input type="hidden" id="idProdotto" name="idProdotto" value="<%=prodotto.getIdProdotto()%>">
    <br>
    <label for="nomeProdotto">Nome Prodotto:</label>
    <input type="text" id="nomeProdotto" name="nomeProdotto" value="<%=prodotto.getNomeProdotto()%>" required>
    <br>
    <label for="prezzo">Prezzo:</label>
    <input type="number" id="prezzo" name="prezzo" required value="<%=prodotto.getPrezzo()%>">
    <br>
    <label for="quantitaDisponibile">Quantita' disponibile:</label>
    <input type="number" id="quantitaDisponibile" name="quantitaDisponibile" value="<%=prodotto.getQuantitaDisponibile()%>" required>
    <br>
    <input type="file" id="imagePath" name="imagePath" accept="image/jpeg, image/png">
    <br>
    <input type="submit" value="Modifica Prodotto">
</form>
</body>
</html>
