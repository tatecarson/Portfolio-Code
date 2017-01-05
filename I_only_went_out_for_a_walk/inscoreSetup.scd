(
//setup inscore

//open inscore
"/Applications/Inscore/INScoreViewer-1.17.app/Contents/MacOS/INScoreViewer".unixCmd;

~score.scale("/myScore", 1, 0.8);
~score.move("/myScore", 1, 0.0, -0.2);
~score.move("/myText", 1, 0.0, 0.4);
~score.scale("/myText", 1, 6.0);

//set history size
~durtoFrac = DurtoFrac(10);
~melDens = 1; //initialize

~makeNotation = {|durations|
	var freqs, noteDur, notes, phrase, lydian, newScale, melDens;

	noteDur = ~durtoFrac.conv(//readable values
		Closestmatch(durations, [0.0625, 0.12, 0.125, 0.25, 0.5, 0.75, 1])
	);

	//range 196 - 2637
	//divide to fix GUIDO problem
	lydian = [ 60, 62, 64, 66, 67, 69, 71, 72, 74, 76, 78, 79, 81, 83 ]; //lydian scale

	melDens = ~melDens.linlin(1, 9, 0, lydian.size);
	if(0.2.coin,
		{lydian = lydian[5..10] - 12}
	);
	newScale = lydian[..melDens.asInt]; //relates melodic density to sample density
	freqs = ~durtoFrac.size.collect{(newScale).choose.midicps};
	notes = (freqs /4).cpsname.collect(_.asString);

	//join notes and durations
	~phrase = [notes, noteDur].flop.collect(_.join("*")).join(" ");

}
)
