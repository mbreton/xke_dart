XKE Dart
========

* Le point d'entré est dans `web/main.dart` lui-même appeler dans la page `spaceinvader.html`
* Pour lancer un script Dart ou une page Cmd+R (ou Ctrl+R ?)

## Introduction

### Commencons par le Pub
Un peu comme en Java on commence par faire ces courses de dépendances. Pour cela on va ce servir de Pub en chargeant deux dépendances depuis le fichier `pubspec.yaml` qui nous seront utiles pendant le TP:

	unittest: { sdk: unittest } # Pour les test unitaires
	js: { hosted: js } # Pour l'intéropérabilité Javascript
	
_* Yaml est sensible à la tabulation_

### Démarrage du jeux
La classe Principale de notre jeux est la classe **Stage**. Celle-ci possède un constructeur nommé **fromCanvas** qui comme son nom l'indique nécessite un element canvas pour être utilisé.
Utilisez donc l'API de sélection d'élément HTML pour récupérer l'élément canvas de la page avec l'id **stage** et passer le en paramètre du constructeur dans le fichier `web/main.dart`.

Aide : <http://c.dart-examples.com/api/dart-html/query>

Une fois terminer vous pouvez admirer la résultat en lancant la page `spaceinvader.html`.

## TDD

* Regarder `web/spaceinvader.dart`
* Et jeter un oeil à `web/spaceinvader.test.dart`
* Enfin l'application est visible en lançant la page `spaceinvader.html`

### Vous reprendrez bien un peu de Javascript ?

On vous avait pas prévenu mais va falloir faire avec un petit bout de code Javascript legacy …
En effet l'affichage du score s'éffectue via l'appel d'une méthode JavaScript appelé **updateScoreLabel** visible dans le fichier `script.js`.
Faite passer les tests de la partie "Publisher".

### Le chargement des resources
Si vous avez lancé la page `spaceinvader.html`, vous avez pu constater que le jeux reste en l'état "Loading …" cela viens de la classe **Resources** qui n'est pas encore implémenter. Suivez les intructions de la partie des tests unitaires "Resources" pour passer au niveau suivant !

### Remerciements spéciaux
Je remercie camille@finandsys.com pour la réalisation des sprites permettant d'afficher de magnifiques images plutôt que des rectangles rose fluos.