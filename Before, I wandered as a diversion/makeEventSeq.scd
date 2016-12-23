~compL = 23;
~patWait = Pseries(~compL, -0.5, inf).asStream;
~stopSeq = false;

//sequence for entire piece, controls the clarinet effects and
//playback of samples
Tdef(\randSeq, {
  inf.do({
		var patWait = ~patWait.next;
		~dur = patWait+rrand(-2, 2);

		//choose random scene
		e[e.keys.choose.debug('object')].value;

    //notation dynamics
    ~notationDynOffset = ~dur.linlin(1, ~compL, 2.0, 1.0);

    //notation tempo
    ~notationTempoOffset = ~dur.linlin(1, ~compL, 0.5, 2.0);

    rrand(0.2, 1.0).wait; //trying to get rid of sliding sound

    //synth fx
    ~distLowFx.set(\mix, ~dur.linlin(1, ~compL, 0.9, 0.0),  \envTime, 0.0001, \knee, -30.dbamp);
    ~distHighFx.set(\mix, ~dur.linlin(1, ~compL, 0.9, 0.0), \envTime, 0.0001, \knee, -60.dbamp);
    ~verbFx.set(\delayTime, ~dur.linlin(1, ~compL, 20.0, 0.0), \damp, ~dur.linlin(1, ~compL, 0.2, 1.0),
                \size, 10, \diff, 0.4, \feedback, ~dur.linlin(1, ~compL, 2.0, 0.0));


    //clar fx
    ~distClarFx.set(\mix, [~dur.linlin(1, ~compL, 1.0, 0.0), 0.0].choose, \envTime, 0.0001, \knee, -60.dbamp);
    ~verbClarFx.set(\delayTime, [~dur.linlin(1, ~compL, 0.0, 5.0), 0.0].choose, \damp, ~dur.linlin(1, ~compL, 0.4, 1.0),
                    \size, 8.0, \diff, 0.4,
                    \feedback, ([~dur.linlin(1, ~compL, 0.0, 1.5), 0.0].choose).debug('Clarinet Feedback'));

    //mabye have to adjust gate thresh
    ~clarIn.set(\amp, 1.0, \drop, rrand(0, 39), \outof, 40, \mode, 1,
                \mix, ~dur.linlin(1, ~compL, 0.0, 0.8), \gateThresh, 0.1);

    //master limiter limit 0.7
    m.pxChain.proxy.set(\limDrive, ~dur.linlin(1, ~compL, 1.2, 0.25).round(0.1).debug('Master Limiter'));

		//test for end of comp
		if(~dur < 4,
		  {~stopSeq = true},
		  {~stopSeq = false}
		);

    ~dur.abs.debug('phrase dur').wait;
  });
});

//every 4 seconds turn feedback off
Tdef(\clarfeedbackOff, {
  inf.do({|i|
    ~verbClarFx.set(\feedback, 0);
    10.wait;
  });
}).play;

//periodic pause
Tdef(\randPause, {
  inf.do({
		if(0.1.coin, {
			{
				1.do{
					Tdef(\randSeq).stop;
					Tdef(\notationCycle).stop;
					Pdef.all.do(_.stop);
					(~dur/rrand(1, 3)).abs.debug('pause time').wait; //longer pauses at begining
					Tdef(\randSeq).play;
					Tdef(\notationCycle).play;
				}
			}.fork;
		});
    4.wait; //don't check too often
  });
});

//check if comp is over, stop seq, and stop pdefs
{//this seems to actually be working
	{
	if(~stopSeq, {
		Tdef(\randSeq).stop;
		Tdef(\notationCycle).stop;
		Tdef(\randPause).stop;
		Pdef.all.do(_.stop);
    ~verbFx.set(\feedback, 0.0);
		"composition over".postln;
		~stopSeq = false; //breaks the if statement
    ~patWait = Pseries(~compL, -0.5, inf).asStream; //reset length to paly again
    1.do{
      a.delete;
      a.text(1, "Composition Over");
      a.scale("/myText", 1, 5);
    };

    a.delete;
  });

	1.wait;
	}.loop;
}.fork;

//start comp GUI
Window.closeAll;
w = Window.new("Start Peice", Rect(0, 0, 200, 30)).front;
w.view.decorator = FlowLayout(w.view.bounds);
w.alwaysOnTop = true;
Button.new(w, Rect(0, 0, 100, 20)).states_([["Play", Color.black,
	Color.clear]])
    .action_({ Tdef(\notationCycle).play; Tdef(\randSeq).play; Tdef(\randPause).play;
              ~clarIn = Synth(\clarIn, [\out, ~distClarBus, \mix, 0.8]);
              
              s.record;
              });
Button.new(w, Rect(0, 0, 40, 20)).states_([["Stop", Color.red,
	Color.clear]])
    .action_({ ~stopSeq = true; ~clarIn.free; s.stopRecording;});
