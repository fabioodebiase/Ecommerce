<%@page import="com.entities.Utente"%>

<html>
<head>
    <title>Conferma Registrazione</title>
</head>
<body>
<h1>Conferma Registrazione</h1>
<%

if (request.getAttribute("errore") == null) {
Utente utente = (Utente) request.getAttribute("utente");
%>
<p>Benvenuto: <%= utente.getUsername() %>, hai effettuato correttamente la registrazione!</p>
<a href="login.jsp">Clicca qui per il login</a>
<% } %>
</body>
</html>