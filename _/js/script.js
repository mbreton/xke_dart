var nbUpdateScoreLabelCall = 0;

var updateScoreLabel = function (scoreLabel){
	++nbUpdateScoreLabelCall;
	var scoreSpan = document.getElementById('score');
	scoreSpan.innerHTML = scoreLabel;
};