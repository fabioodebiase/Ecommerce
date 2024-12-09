<html>
<head>Login</head>
<body>
<h1>Login</h1>

<form action = "Login" method = "POST">
    <label for="usernameEmail"> Username/Email</label>
    <input type = "text" name = "usernameEmail" id = "usernameEmail">

    <label for="password"> Password</label>
    <input type = "text" name = "password" id = "password">

    <input type = "submit" value = "Accedi">

</form>
<%
if (request.getAttribute("errore") != null) { %>
<p style = "color:red"> <%= request.getAttribute("errore") %> </p>
<% } %>
<p>Non sei ancora registrato?<a href = "signUp.jsp">Clicca qui per registrarti</a></p>
</body>
</html>
