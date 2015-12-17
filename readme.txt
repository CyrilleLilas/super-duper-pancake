Ruby v2.1.7
Rails v4.0.1

Pour lancer le serveur: rails s
L'application écoute sur le port 3000.

Exemple d'appel du webservice:
http://localhost:3000/calculator?A=5&B=6&op=add

Les valeurs permises pour le paramètre "op" sont "add", "sub", "mul" et "div".
Le paramètre optionnel "output" peut prendre la valeur "json" pour une réponse de type application/json.
