//Here all the monome code is setup. It's controlling sample playback
//and spatialization. 

a=GRHMonome128.new; // create a monome

//triggers random one shot samples
//x axis controls release time, y axis controls rate
~oneShotTrigger = GRMultiButtonView(a, 0@0, 4, 4);
~oneShotTrigger.behavior = \momentary;
~oneShotTrigger.action = {|view, value|
	4.do{|x|
		4.do{|y|
			if(value[x][y],
			  {
					Synth(\oneShotSampler,
								[\bufnum, b[\cuts][rrand(0, ~ssize)], \rate, y.linlin(0, 3, 1, 0.1),
								\attack, y.linlin(0, 3, 0.01, 1.5), \release, x+1, \curve, rrand(-8, 4),
								\offset, rrand(0, 1.0), \amp, y.linlin(0, 3, 0.7, 0.25), \outBus, ~foaPanBBus] );

					//ambisonics
					~foaPanB.set(\angle, (pi/2).rand2, \theta, pi.rand2, \distance, x.linlin(0, 3, 0.0625, 1.0));
					[x, y].postln;
					value[x][y].postln;
				}
			)
		}
	}
};

~gran0 = GRButton(a, 0@4, 1, 4);
~gran0.action = {|view, value|

  var pressedButton = view.lastPressed;
  var x = 0;
  var y = pressedButton.y;
	y.postln;
  if(value,
    { Pbindef(\gran_0, \sndBuf, b[\cuts][rrand(0, ~ssize)], \bpWet, x.linlin(0, 3, 0.0, 0.8),
        \amp, Pseg(
								Pseq([0.001,  y.linlin(0, 3, 0.25, 0.1)],2),
								Pseq([x.linlin(0, 3, 0.0, 8), 100], 2),
								Prand([\exp, \sine, \welch], 2)
							)
			).play(quant: 0);

			//ambisonics
			~foaDiffuse[0].set(\angle, (pi/2).rand, \theta, -pi)
			},
    {Pbindef(\gran_0,
			\amp,Pseg(
							Pseq([y.linlin(0, 3, 0.25, 0.1), 0.001],2),
							Pseq([1, x.linlin(0, 3, 0.0, 8)], 2),
							Prand([\exp, \sine, \welch], 2)
						)
		)}
  )
};

~gran1 = GRButton(a, 1@4, 1, 4);
~gran1.action = {|view, value|

  var pressedButton = view.lastPressed;
  var x = 1;
  var y = pressedButton.y;

  if(value,
    { Pbindef(\gran_1, \sndBuf, b[\cuts][rrand(0, ~ssize)], \bpWet, x.linlin(0, 3, 0.0, 0.8),
        \amp, Pseg(
								Pseq([0.001,  y.linlin(0, 3, 0.25, 0.1)],2),
								Pseq([x.linlin(0, 3, 0.0, 8), 100], 2),
								Prand([\exp, \sine, \welch], 2)
							)
			).play(quant: 0);

			//ambisonics
			~foaDiffuse[1].set(\angle, (pi/2).rand, \theta, pi.rand2)
			},
    {Pbindef(\gran_1,
			\amp,Pseg(
							Pseq([y.linlin(0, 3, 0.25, 0.1), 0.001],1),
							Pseq([1, x.linlin(0, 3, 0.0, 8)], 1),
							Prand([\exp, \sine, \welch], 2)
						)
		)}
  )
};

~gran2 = GRButton(a, 2@4, 1, 4);
~gran2.action = {|view, value|

  var pressedButton = view.lastPressed;
  var x = 2;
  var y = pressedButton.y;

  if(value,
    { Pbindef(\gran_2, \sndBuf, b[\cuts][rrand(0, ~ssize)], \bpWet, x.linlin(0, 3, 0.0, 0.8),
        \amp, Pseg(
								Pseq([0.001,  y.linlin(0, 3, 0.25, 0.1)],2),
								Pseq([x.linlin(0, 3, 0.0, 8), 100], 2),
								Prand([\exp, \sine, \welch], 2)
							)
			).play(quant: 0);
			//ambisonics
			~foaDiffuse[2].set(\angle, (pi/2).rand, \theta, pi.rand2)
			},
    {Pbindef(\gran_2,
			\amp,Pseg(
							Pseq([y.linlin(0, 3, 0.25, 0.1), 0.001],1),
							Pseq([1, x.linlin(0, 3, 0.0, 8)], 1),
							Prand([\exp, \sine, \welch], 2)
						)
		)}
  )
};

~gran3 = GRButton(a, 3@4, 1, 4);
~gran3.action = {|view, value|

  var pressedButton = view.lastPressed;
  var x = 3;
  var y = pressedButton.y;

  if(value,
    { Pbindef(\gran_3, \sndBuf, b[\cuts][rrand(0, ~ssize)], \bpWet, x.linlin(0, 3, 0.0, 0.8),
        \amp, Pseg(
								Pseq([0.001,  y.linlin(0, 3, 0.25, 0.1)],2),
								Pseq([x.linlin(0, 3, 0.0, 8), 100], 2),
								Prand([\exp, \sine, \welch], 2)
							)
			).play(quant: 0);

			//ambisonics
			~foaDiffuse[3].set(\angle, (pi/2).rand, \theta, pi.rand2)
			},
    {Pbindef(\gran_3,
			\amp,Pseg(
							Pseq([y.linlin(0, 3, 0.25, 0.1), 0.001],1),
							Pseq([1, x.linlin(0, 3, 0.0, 8)], 1),
							Prand([\exp, \sine, \welch], 2)
						)
		)}
  )
};


~klank0 = GRButton(a, 4@0, 1, 8);
~klank0.action = {|view, value|
	if(value, {
			var pressedButton = view.lastPressed;
			var x = 0;
			var y = pressedButton.y;

			~toWekinator.sendMsg("/wek/inputs",
				x.linlin(0, 4, 0.0, 1.0),
				y.linlin(0, 7, 0.0, 1.0)
			);

		~foaSpread[0].set(\gain, rrand(-4.5, 4.5), \theta, y.linlin(0, 7, -pi, pi));

		},
	  {Pbindef(\klank_0).stop}
	);
};

~klank1 = GRButton(a, 5@0, 1, 8);
~klank1.action = {|view, value|
	if(value, {
			var pressedButton = view.lastPressed;
			var x = 1;
			var y = pressedButton.y;

			~toWekinator.sendMsg("/wek/inputs",
				x.linlin(0, 4, 0.0, 1.0),
				y.linlin(0, 7, 0.0, 1.0)
			);

		~foaSpread[1].set(\gain, rrand(-4.5, 4.5), \theta, y.linlin(0, 7, -pi, pi));

		},
	  {Pbindef(\klank_1).stop}
	);
};

~klank2 = GRButton(a, 6@0, 1, 8);
~klank2.action = {|view, value|
	if(value, {
			var pressedButton = view.lastPressed;
			var x = 2;
			var y = pressedButton.y;

			~toWekinator.sendMsg("/wek/inputs",
				x.linlin(0, 4, 0.0, 1.0),
				y.linlin(0, 7, 0.0, 1.0)
			);

		~foaSpread[2].set(\gain, rrand(-4.5, 4.5), \theta, y.linlin(0, 7, -pi, pi));

		},
	  {Pbindef(\klank_2).stop}
	);
};

~klank3 = GRButton(a, 7@0, 1, 8);
~klank3.action = {|view, value|
	if(value, {
			var pressedButton = view.lastPressed;
			var x = 3;
			var y = pressedButton.y;

			~toWekinator.sendMsg("/wek/inputs",
				x.linlin(0, 4, 0.0, 1.0),
				y.linlin(0, 7, 0.0, 1.0)
			);

			~foaSpread[3].set(\gain, rrand(-4.5, 4.5), \theta, y.linlin(0, 7, -pi, pi));
		},
	  {Pbindef(\klank_3).stop}
	);
};

c=GRMultiToggleView.newDecoupled(a, 8@0, 4, 8).valuesAreInverted_(true);
c.nillable = true;
c.numToggles.do { |index| c.setToggleValue(index, nil) };
x = Array.newClear(c.numToggles);

c.toggleValuePressedAction = { |view, index, value|
    x[index].stop;
    if (value == 0) {
        view.setToggleValue(index, nil);
    } {
        x[index] = Routine({
            1.do {
								~foaSpread[0].set(\gain, rrand(-4.5, 4.5), \theta, pi.rand2);

								~dur = (index+1)/2;
                (value..0).do { |val|
										Pbindef(\p, \amp, val.linlin(0, 7, 0.0, 1), \dur, ~dur).play(quant: 0);
										val.postln;
                    view.setToggleValue(index, val);
										~dur.wait;
                };
									Pbindef(\p).stop;
            };
        }).play;
    }
};

~waveloss =GRVToggle(a, 12@0, 2, 8).valuesAreInverted_(true);
~waveloss.action = { |view, value| Pbindef(\p, \drop, value.linlin(0, 7, 0, 39))};

~amp =GRVToggle(a, 14@0, 2, 8).valuesAreInverted_(true).value_(7);
~amp.action = { |view, value|
	v.volume = value.linlin(0.0, 7, -20, 0).postln; value.postln;
	if(value == 0, {v.volume = -60})
};
