{
~toWekinator = NetAddr("127.0.0.1", 6448);
~toWekinator.sendMsg("/wekinator/control/startRunning");

//pick things to control with wekinator and monome
OSCFunc.new({ |msg|
	msg.postln;

	if(~klank0.value,
	  {	Pbindef(\klank_0,
				\droneMix, msg[1],
				\warpRate, msg[2].linlin(0.0, 1.0, 0.1, 1.0),
				\lpffreq, msg[3].linlin(0.0, 1.0, 100, 400),
				\wdrop, msg[4].linlin(0.0, 1.0, 1, 35),
				\wmode, msg[5].linlin(0, 1, 1, 2),
				\dur, Pseq([msg[6].linlin(0, 1, 1, 20)], 1),
				\outBus, ~foaSpreadBus[0]
			).play(quant: 0)}
	);

	if(~klank1.value,
	  {	Pbindef(\klank_1,
				\droneMix, msg[1],
				\warpRate, msg[2].linlin(0.0, 1.0, 0.1, 1.0),
				\lpffreq, msg[3].linlin(0.0, 1.0, 100, 400),
				\wdrop, msg[4].linlin(0.0, 1.0, 1, 35),
				\wmode, msg[5].linlin(0, 1, 1, 2),
				\dur, Pseq([msg[6].linlin(0, 1, 1, 20)], 1),
				\outBus, ~foaSpreadBus[1]
			).play(quant: 0)}
	);

	if(~klank2.value,
	  {	Pbindef(\klank_2,
				\droneMix, msg[1],
				\warpRate, msg[2].linlin(0.0, 1.0, 0.1, 1.0),
				\lpffreq, msg[3].linlin(0.0, 1.0, 100, 400),
				\wdrop, msg[4].linlin(0.0, 1.0, 1, 35),
				\wmode, msg[5].linlin(0, 1, 1, 2),
				\dur, Pseq([msg[6].linlin(0, 1, 1, 20)], 1),
				\outBus, ~foaSpreadBus[2]
			).play(quant: 0)}
	);

	if(~klank3.value,
	  {	Pbindef(\klank_3,
				\droneMix, msg[1],
				\warpRate, msg[2].linlin(0.0, 1.0, 0.1, 1.0),
				\lpffreq, msg[3].linlin(0.0, 1.0, 100, 400),
				\wdrop, msg[4].linlin(0.0, 1.0, 1, 35),
				\wmode, msg[5].linlin(0, 1, 1, 2),
				\dur, Pseq([msg[6].linlin(0, 1, 1, 20)], 1),
				\outBus, ~foaSpreadBus[3]
			).play(quant: 0)}
	)

}, "/wek/outputs", recvPort: 50000);

//turn off LED when synth is done
Tdef(\klankCheck, {
  inf.do({|i|
    if(Pbindef(\klank_0).hasEnded,
      {~klank0.value = false}
    );

		if(Pbindef(\klank_1).hasEnded,
			{~klank1.value = false}
		);

		if(Pbindef(\klank_2).hasEnded,
			{~klank2.value = false}
		);

		if(Pbindef(\klank_3).hasEnded,
			{~klank3.value = false}
		);
    0.1.wait;
  });
}).play;
}.fork;
