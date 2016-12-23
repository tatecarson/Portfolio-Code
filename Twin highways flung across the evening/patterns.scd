4.do{|i|
	Pbindef((\klank_++i).asSymbol,
		\instrument, \klankDrone,
		\bufnum, b[\cuts][(0..b[\cuts].size).choose],
		\loop, Pwhite(0, 1),
		\pos, Pwhite(0, 1.0), // playbuf sample pos
		\klankfreqs, Pfunc{[800.linrand.dup(12), 12000.linrand.dup(12)].choose},
		\klankamps, Pfunc{{0.1.rrand(1)}.dup(12)},
		\rings, Pfunc{{5.rrand(7)}.dup(12)},
		\hpffreq, Pexprand(500, 18000).trace,
		\klankmix, Phprand(0.0, 1.0), // 0 - dry sample, 1 - klanked sample
		\rate, Pmeanrand(0.7, 1.1), //original sample tuning
		\droneMix, Pmeanrand(0.0, 1.0), // 0 - klank, 1 - warp1 drone
		\pointer, Prand([0.2, 0.4, 0.7], inf), //position in drone
		\warpRate, Pwhite(0.1, 1.0), //tuning of drone
		\lpffreq, Pwhite(100,400), //moog cutoff
		\saturation, Pwhite(0.6, 1.0), //moog saturation
		\legato, 0.8,
		\tsustain, Pkey(\sustain) / Pfunc({ thisThread.clock.tempo }), // sustain is in beats, tsustain in seconds
		\env, Pfunc({ arg ev;
			[ Env([0,1,1,0], [ rrand(0.01,1), rrand(0.01,1), rrand(0.01,1) ].normalizeSum) ];
		}),
		\envCurve, Pwhite(-4, 4),
		\amp, 0.10, //master amp
		\masterDist, Pbrown(0.1, 1, 0.4),
		\wdrop, Prand([1, 15, 20, 35], inf),
		\wmode, Prand([1, 2], inf),
		\pan, Pwhite(0.0, 1.0),
		\dur, Pseq([1, 3, 10], inf),
		\outBus, ~foaSpreadBus[i]
	 );
};

//patterns

~sr = 44100;

Pbindef(\p,
  \freq, 220,
  \instrument, \simpler,
  \buf, Pif( Pfunc({ 0.5.coin }), b[\original][0], b[\original][1]),
  \dur, 1,
  \sampleStart, ~sr*Pwhite(1, b[\original][0].duration, inf),
  \loopLen, ~sr*Pwhite(1, 100, inf),
  \fadeTime, 0.01,
  \attack, 0.25,
  \release, 2,
  \amp, 0.0,
  \drop, 1,
  \outof, 40,
  \mode, 1,
	\outBus, ~foaSpreadBus[0]
);

//drone gran
~posLo = 0.19; //where to granulate
~posHi = 0.20; //make very small to keep drone
~posRate = 0.1; // to create drone effect
~posDev = 0.001; //more droney

// each stream shoul have seperate synht and buss for seperation
4.do{|i|
  Pbindef((\gran_++i).asSymbol,
    \instrument, \gran_2b,
    \sndBuf, b[\cuts][rrand(0, 11).debug('current gran buffer')],
    \windowBuf, w,
    \dur, 1 / 200,
    \granDur, 0.15,
    \time, Ptime(),
    \posRate, 0.1,
    \pos, Pfunc { |e|
      var relTime = ~posRate * e.time / 1, relDif;
      relDif = (~posHi - ~posLo) * rrand(1, 1.1);
      relTime + rand2(~posDev) % relDif + ~posLo;
    },
    \rate, 1,
    \bpFreq, 100,
    \bpRQ, 0.07,
    \bpWet, 0,
    \amp, Pseg( Pseq([0.001, 0.25],inf), Pseq([4, 2],inf), Prand([\exp, \sine, \welch], inf)),
    \outBus, ~foaDiffuseBus[i]
)};
