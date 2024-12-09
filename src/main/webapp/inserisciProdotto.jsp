<html>
<head>
    <title>Inserisci Prodotto</title>
</head>
<body>
<h1>Inserisci Prodotto</h1>

<form action = "InserisciProdotto" method = "POST" enctype="multipart/form-data">

    <label for="nomeProdotto"> Nome Prodotto: </label>
    <input type = "text" name = "nomeProdotto" id = "nomeProdotto">

    <label for="prezzoProdotto"> Prezzo:</label>
    <input type = "text" name = "prezzoProdotto" id = "prezzoProdotto">

    <label for="quantitaProdotto"> Quantita':</label>
    <input type = "text" name = "quantitaProdotto" id = "quantitaProdotto">

    <input type="file" name="file" accept = "image/jpeg, image/png">
    <input type = "submit" value = "Inserisci Prodotto">

</form>
<%
if (request.getAttribute("errore") != null) { %>
<p style = "color:red"> <%= request.getAttribute("errore") %> </p>
<% } %>
</body>
</html>