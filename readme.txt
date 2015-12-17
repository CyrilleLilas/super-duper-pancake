Ruby v2.1.7
Rails v4.0.1

Pour lancer le serveur: rails s
L'application écoute sur le port 3000.

Exemple d'appel du webservice:
http://localhost:3000/calculator?A=5&B=6&op=add

Les paramètres "A", "B" et "op" sont obligatoires et sensibles à la casse.
Les valeurs permises pour le paramètre "op" sont "add", "sub", "mul" et "div".
Le paramètre optionnel "output" peut prendre la valeur "json" pour obtenir une réponse de type application/json.
Le résultat des calculs sur les nombres décimaux est arrondi à 4 décimales.