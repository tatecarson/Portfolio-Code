var metronomeDur = 1;
var svgPath, makeSvg;
~dur = 20;

a = INScore.new("127.0.0.1", 7000);
a.delete; //clear if something is already there

//load svg path
svgPath = PathName(thisProcess.nowExecutingPath).parentPath ++ "_notation/";

//add svg to dicts
makeSvg= {
	~notation = Dictionary.new;
	PathName(svgPath).entries.do{
		arg subfolder;
		~notation.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					subfolder.entries[i].fullPath.asString;
				}
			)
		);
	};
};

//evaluated notation function
makeSvg.value;

~notationObj = ~notation[\rainGutter]; //starting notation
~metronomeMult = 10;
~notationTempo = Pwhite(4, 6).asStream;
~notationDyn = Pwhite(0.01, 0.5).asStream;
~notationDynOffset = 1;
~notationTempoOffset = 1.0;

//style descriptions, need to come up with more
~phraseStyle = [];


//basical animation function
Tdef(\notationCycle, {

	inf.do({|i|
		a.file(1,~notationObj[i%~notationObj.size]); //display svg
		a.text(1, ~phraseStyle);
		a.move("/myText", 1, -0.0, 0.0);
		a.scale("/myText", 1, 5.0);
		Tdef(\tempoAnimate).play; //trigger metronome
    ~metronomeMult = ~dur.linlin(1, 30, 1, 10);
		//~metronomeMult.debug('metronomeMult');
    (metronomeDur*~metronomeMult).wait; //10 is the average measure length
  });
});

Tdef(\tempoAnimate, {
  var moveDot = Pseries(-1.0, 0.01, inf).asStream;
	var dyn = ~notationDyn.next*~notationDynOffset; //so x and y get same value
	//dyn.debug('notation dynamics');
  a.scale("/myFile", 1, 7.0);
  a.move("/myFile", 1, -0.0, 0.2);
	a.ellipse(xSize:dyn, ySize: dyn, xPos: 0.0, yPos: 0.5);
  Tdef(\counter).play;
	400.do({|i|
		a.move("/myEllipse", 1, (moveDot.next%1.0)-1, 0.5);
    (2/60/~notationTempo.next*~notationTempoOffset).wait;
  });
  Tdef(\counter).stop;
});

Tdef(\counter, {
  inf.do({|i|
    metronomeDur = i+1;
    1.wait;
  });
})
