<html>
<head>
    <title>Inserisci Prodotto</title>
    <link rel="stylesheet" href="./css/inserisciProdotto.css">
</head>
<body>

<div class="container">
    <span class="title">Inserisci Prodotto</span>

    <form action="InserisciProdotto" method="POST" enctype="multipart/form-data">
        <div class="insert-container">
            <div class="input-container">
                <span class="title-input"><label for="nomeProdotto">Nome Prodotto</label></span>
                <input type="text" id="nomeProdotto" class="input" name="nomeProdotto" required>
            </div>

            <div class="input-container">
                <span class="title-input"><label for="prezzoProdotto">Prezzo</label></span>
                <input type="number" id="prezzoProdotto" name="prezzoProdotto" class="input" required>
            </div>

            <div class="input-container">
                <span class="title-input"><label for="quantitaDisponibile">Quantita'</label></span>
                <input type="number" id="quantitaDisponibile" class="input" name="quantitaDisponibile" min="1" required>
            </div>

            <div class="input-container">
                <span class="title-input"><label for="file">Inserisci immagine</label></span>
                <input type="file" id="file" name="file" accept="image/*" required>
                <img id="preview" src="" alt="Anteprima immagine" style="display:none;">
            </div>

            <div class="submit-container">
                <input type="submit" class="submit" value="Inserisci Prodotto">
            </div>
        </div>
    </form>

    <% if (request.getAttribute("errore") != null) { %>
    <p style="color:red; text-align:center; margin-top:20px;"> <%= request.getAttribute("errore") %> </p>
    <% } %>
</div>

<script>
    document.getElementById('file').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('preview');
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>