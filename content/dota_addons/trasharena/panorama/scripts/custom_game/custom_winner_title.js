var COLOUR_RADIANT = "#FFFFFF";
var COLOUR_DIRE = "#2794EB";
var TIMER_INTERVAL = 0.05;

var startTime = -1;
var timerDuration = 7;
var WinnerTeamName = "Remaining";
var Title = null;
var timerWarning = -1; // Second to start warning at from end (-1 Disabled)
var timerLast = 0;

var Title = $( "#TitleBox" );

function UpdateTimer() {

	var timerTextRemain = $( "#TimerRemaining" );
	var time = Game.GetGameTime() - startTime;
	var remaining = Math.ceil(timerDuration - time);

	if (time < timerDuration)
		$.Schedule(TIMER_INTERVAL, function(){UpdateTimer();});
	else
			$.Schedule(1, function(){FadeOut();});
}

function FadeIn() {
	Title.AddClass("FadeIn");
}

function FadeOut() {
	Title.RemoveClass("FadeIn");
}


function PauseTimer( bool ) {
	timerPaused = bool.pause;
}



function ShowWinner(table)
{   
	WinnerTeamName = table.TeamName || " ";
	var TitleTextMsge = $( "#WinnerTeam");
	if(table.TeamName === "the dark side")
	{
		TitleTextMsge.style['color'] = COLOUR_DIRE;
	}
	else{
		TitleTextMsge.style['color'] = COLOUR_RADIANT;
	}
	TitleTextMsge.text = $.Localize(WinnerTeamName);
	startTime = Game.GetGameTime();
	UpdateTimer();
	FadeIn();
}

(function () {
  GameEvents.Subscribe( "Show_Winner", ShowWinner);

})();