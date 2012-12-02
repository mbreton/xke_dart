XKE Dart
========

* Le point d'entré est **main** est dans la page `spaceinvaders.html`
* Pour lancer un script Dart ou une page Cmd+R/Ctrl+R

![Screen](https://raw.github.com/mbreton/xke_dart/master/_/img/screen.jpg)


## Introduction

### Commencons par le Pub
Un peu comme en Java on commence par faire ces courses de dépendances. Pour cela on va ce servir de Pub en chargeant deux dépendances depuis le fichier `pubspec.yaml` qui nous seront utiles pendant le TP:

	unittest: { sdk: unittest } # Pour les test unitaires
	js: { hosted: js } # Pour l'intéropérabilité Javascript
	
_* Yaml est sensible à la tabulation_

### Démarrage du jeux
La classe Principale de notre jeux est la classe **Stage**. Celle-ci possède un constructeur nommé **fromCanvas** qui comme son nom l'indique nécessite un element canvas pour être utilisé.
Utilisez donc l'API de sélection d'élément HTML pour récupérer l'élément canvas de la page avec l'id **stage** et passer le en paramètre du constructeur dans le fichier `spaceinvaders.html` (à la ligne 40) et admirer le résultat.

Aide : <http://c.dart-examples.com/api/dart-html/query>


## TDD

* Regarder `spaceinvaders.dart`
* Et jeter un oeil à `spaceinvaders.test.dart`

### Vous reprendrez bien un peu de Javascript ?

On vous avait pas prévenu mais va falloir faire avec un petit bout de code Javascript legacy …
En effet l'affichage du score s'éffectue via l'appel d'une méthode JavaScript appelé **setScoreLabel** visible dans le fichier `_/js/script.js`. Faite passer chaque étape des tests de la partie "Publisher" dans le fichier de test `spaceinvaders.test.dart`

### Le chargement des resources
Si vous avez lancé la page `spaceinvaders.html`, vous avez pu constater que le jeux reste en l'état "Loading…" cela viens de la classe **Resources** qui n'est pas encore implémentée. Suivez les intructions de la partie des tests unitaires "Resources" pour passer au niveau suivant!

### Rencontre du troisième type ...
Sur la page `spaceinvaders.html`, après avoir appuyer sur espace vous arriver dans l'espace ! Et il ne ce passe rien…
Pimentons le partie en ajoutant des petites bêtes vertes (et rouge). Retournez dans `spaceinvaders.test.dart` et implémenter les tests unitaires **Alien** et **Very Bad Alien**.

### Il est temps de vous faire un vaisseau
Les aliens sont partout ! Retournez vite dans `spaceinvaders.test.dart` pour vous construire un mega-vaisseau-de-la-mort-qui-tue en implémentant la partie **Ship**.


### Remerciements spéciaux
Je remercie camille@finandsys.com pour la réalisation des sprites permettant d'afficher de magnifiques images plutôt que des rectangles rose fluos.