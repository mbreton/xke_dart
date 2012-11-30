var nbSetScoreLabel = 0;

var setScoreLabel = function (scoreLabel){
	++nbSetScoreLabel;
	var scoreSpan = document.getElementById('score');
	scoreSpan.innerHTML = scoreLabel;
};