
<html>
<head>
    <title>Conferma Inserimento</title>
</head>
<body>
<%

if (request.getAttribute("errore") == null) {
%>
<p>Prodotto inserito con successo</p>
<a href="home.jsp">Clicca qui per visualizzare la lista dei prodotti</a>
<% } %>
</body>
</html>