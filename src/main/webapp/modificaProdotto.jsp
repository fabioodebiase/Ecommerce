<%@ page import="com.entities.Prodotto" %>
<%
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
%>
<html>
<head>
    <title>Modifica Prodotto</title>
    <link rel="stylesheet" href="./css/modificaProdotto.css">
    <style>
        #preview {
            max-width: 200px;
            max-height: 200px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <span class="title">Modifica Prodotto</span>
    <form action="modificaProdotto" method="post" enctype="multipart/form-data">
        <div class="modify-container">
            <input type="hidden" id="idProdotto" name="idProdotto" value="<%=prodotto.getIdProdotto()%>">
            <div class="input-container">
                <span class="title-input"><label for="nomeProdotto">Nome Prodotto</label></span>
                <input type="text" id="nomeProdotto" class="input" name="nomeProdotto" value="<%=prodotto.getNomeProdotto()%>" required>
            </div>

            <div class="input-container">
                <span class="title-input"><label for="prezzo">Prezzo</label></span>
                <input type="number" id="prezzo" name="prezzo" class="input" required value="<%=prodotto.getPrezzo()%>">
            </div>

            <div class="input-container">
                <span class="title-input"><label for="quantitaDisponibile">Quantita' disponibile</label></span>
                <input type="number" id="quantitaDisponibile" class="input" name="quantitaDisponibile" value="<%=prodotto.getQuantitaDisponibile()%>" min = "1" required>
            </div>

            <div class="input-container">
                <span class="title-input"><label for="imagePath">Inserisci immagine</label></span>
                <input type="file" id="imagePath" name="imagePath"  accept="image/jpeg, image/png" required>
                <img id="preview" src="" alt="Anteprima immagine" style="display:none;">
            </div>

            <div class="submit-container">
                <input type="submit" class="submit" value="Modifica Prodotto">
            </div>

        </div>
    </form>
</div>

<script>
    document.getElementById('imagePath').addEventListener('change', function(event) {
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