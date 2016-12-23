//sequence sample playback inside the movements
(
i = [\cloudSrc, \cloudFx1, \cloudFx2, \cloudFx3];

Pbindef(\cloudSrc,
  \instrument, \bpfbuf,
  \buf, b[\longtones][5],
  \amp, Pwhite(0.5, 0.8),
  \dur, Pseq([Pn( Prand([0.1, 1.0, 2.0], 1), { rrand(1, 3) }),
              Rest( [1.0, 2.0, 3.0].wchoose([4, 2, 2].normalizeSum))], inf),
  \spos, Pwhite(0.0, 1.0),
  \atk, Pwhite(0.1, 0.3),
  \sus, 0.5,
  \rel, Pwhite(1.0, 2.0),
  \freq, {rrand(85.0, 200.0).midicps}!3, //bpf freq
  \rq, 0.005,
  \bpfmix, Pwhite(0.1, 0.5),
  \stretch, 5,
  \windowsize, Pwhite(0.1, 2.0),
  \drop, 15,
  \outof, 100,
  \mode, 0,
  \pan, Pwhite(-1.0, 1.0),
  \fxOrder, Pn(Pshuf([[1, 3], [2, 3], [1,2], [1, 2, 3], 1])),
  \cleanupDelay, Pfunc{|e| e.atk + e.sus + e.rel} //adds the total env time
);

Pbindef(\cloudFx1,
  \fx, \satan,
  \mix, 0.4,
  \envTime, 0.001,
  \knee, -30.dbamp,
  \cleanupDelay, Pkey(\envTime)
);

Pbindef(\cloudFx2,
  \fx, \satan,
  \amp, 0.05,
  \mix, 0.6,
  \envTime, 0.0001,
  \knee, -60.dbamp,
  \cleanupDelay, Pkey(\envTime)
);

Pbindef(\cloudFx3,
  \fx, \reverb,
  \delayTime, 5,
  \damp, 0.2,
  \size, 30,
  \diff, 0.2,
  \feedback, 0.2,
  \cleanupDelay, Pkey(\delayTime)
);

p  = PbindFx(*i.collect { |x| Pbindef(x) });

~cloud = p;
);

//buffer player 2
(
~bsize = b[\clicks].size;

i = [\clickSrc, \clickDist1, \clickDist2, \clickVerb3];

Pbindef(\clickSrc,
  \instrument, \bpfbuf,
  \dur, Pseq([Pn( Prand([0.1, 1.0, 2.0], 1), { rrand(1, 3) }),
              Rest([1.0, 3.0, 4.0].wchoose([4, 2, 5].normalizeSum))], inf),
  \atk, Pwhite(0.1, 0.3),
  \sus, 0.1,
  \rel, Pwhite(0.1, 1.0),
  \buf, b[\clicks][~bsize.rand],
  \rate, Pwhite(-7.0, 1.0).midiratio,
  \spos, Pwhite(0, b[\clicks][0].numFrames),
  \amp, Pwhite(0.2, 0.8),
  \freq, {rrand(85.0, 200.0).midicps}!3, //bpf freq
  \rq, 0.005,
  \bpfmix, 0.97,
  \fxOrder, Pn(Pshuf([[1, 3], [2, 3], [1,2], [1, 2, 3], 1])),
  \cleanupDelay, Pfunc{|e| e.atk + e.sus + e.rel} //adds the total env time
);

Pbindef(\clickDist1,
  \fx, \satan,
  \mix, 0.4,
  \envTime, 0.0001,
  \knee, -30.dbamp,
  \cleanupDelay, Pkey(\envTime)
);

Pbindef(\clickDist2,
  \fx, \satan,
  \mix, 0.6,
  \envTime, 0.0001,
  \knee, -60.dbamp,
  \cleanupDelay, Pkey(\envTime)
);

Pbindef(\clickVerb3,
  \fx, \reverb,
  \delayTime, 5,
  \damp, 0.2,
  \size, 30,
  \diff, 0.2,
  \feedback, 0.2,
  \cleanupDelay, Pkey(\delayTime)
);

p = PbindFx(*i.collect { |x| Pbindef(x) });

~click = p;
);

(
~rSwitch[\cicada] = Pswitch(~patRhythm, Pseq([7, 8, 9], inf)).asStream;
~pstepDur[\cicada] = 7;

Pbindef(\cicada,
  \instrument, Prand([\bpfsaw, \reed], inf),
  \amp, 0.2*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~cicada[~cicada.keys.choose], inf), ~pstepDur[\cicada], inf),
  \dur, Pstep(~rSwitch[\cicada].next, ~pstepDur[\cicada], inf),
  \legato, 1,
  \atk, Pwhite(1, 4),
  \rel, Pwhite(1, 4),
  \strum, Pseq([0.1, 0.3, 0.0, 0.5], inf),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus, ~distHighBus]))
);

~cicadaDef = PbindFx(*i.collect { |x| Pbindef(x) });
);

(
~rSwitch[\cricket] = Pswitch(~patRhythm, Pseq([2,3, 4, 6], inf)).asStream;
~pstepDur[\cricket] = 6;

Pbindef(\cricket,
  \instrument, Prand([\reed, \bpfsaw], inf),
  \amp, 0.2*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~cricket[~cricket.keys.choose], inf), ~pstepDur[\cricket], inf),
  \dur, Pstep(~rSwitch[\cricket].next, ~pstepDur[\cricket], inf),
  \legato, 1,
  \atk, Pwhite(0.1, 1.2),
  \rel, Pwhite(0.1, 1.3),
  \strum, Pseq([0.1, 0.3, 0.0, 0.5], inf),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~cricketDef = PbindFx(*i.collect { |x| Pbindef(x) });

);

(
~rSwitch[\ferry] = Pswitch(~patRhythm, Pseq([7, 6, 5, 9, 10], inf)).asStream;
~pstepDur[\ferry] = 4;

Pbindef(\ferry,
  \instrument, Prand([\reed, \bpfsaw], inf),
  \amp, 0.2*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~ferry[~ferry.keys.choose], inf), ~pstepDur[\ferry], inf),
  \dur, Pstep(~rSwitch[\ferry].next, ~pstepDur[\ferry], inf),
  \legato, 1,
  \atk, Pwhite(1, 2),
  \rel, Pwhite(1, 3),
  \strum, Pstep(Prand([0.3, 0.5], inf), ~pstepDur[\ferry]),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~ferryDef = PbindFx(*i.collect { |x| Pbindef(x) });

);

(
~rSwitch[\natchez] = Pswitch(~patRhythm, Pseq([5, 6, 8, 12, 13, 14], inf)).asStream;
~pstepDur[\natchez] = 6;

Pbindef(\natchez,
  \instrument, Pwrand([\bpfsaw, \cautious], [0.75, 0.25], inf),
  \amp, 0.2*(2**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~natchez[~natchez.keys.choose], inf)/2, ~pstepDur[\natchez], inf),
  \ffreq, 100,
  \dur, Pstep(~rSwitch[\natchez].next, ~pstepDur[\natchez], inf),
  \atk, Pwhite(1, 2),
  \rel, Pwhite(1, 4),
  \percRel, Pwhite(1, 4),
  \strum, Pstep(Prand([0.3, 0.5], inf), ~pstepDur[\natchez]),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus]))
);

~natchezDef = PbindFx(*i.collect { |x| Pbindef(x) });
);

(
~rSwitch[\rainGutter] = Pswitch(~patRhythm, Pseq([0, 1, 2], inf)).asStream;
~pstepDur[\rainGutter] = 1;

Pbindef(\rainGutter,
  \instrument, Prand([\kalimba, \cautious], inf),
  \amp, 0.1*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~rainGutter[~rainGutter.keys.choose], inf)*Pwhite(1, 2), ~pstepDur[\rainGutter], inf),
  \ffreq, 1100,
  \mix, Pwhite(0.0, 0.4),
  \dur, Pstep(~rSwitch[\rainGutter].next, ~pstepDur[\rainGutter], inf),  //0.5 to make more rainlike
  \percRel, Pwhite(0.2, 3.0),
  \strum, Pstep(Pwhite(0.3, 1.0), ~pstepDur[\rainGutter]),
  \cleanupDelay, 0.1,
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~rainGutterDef = PbindFx(*i.collect { |x| Pbindef(x) });
);

(
~rSwitch[\rainShower] = Pswitch(~patRhythm, Prand([1, 4, 7, 8], inf)).asStream;
~pstepDur[\rainShower] = 3;

Pbindef(\rainShower,
  \instrument, Prand([\kalimba, \cautious], inf),
  \amp, 0.1*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~rainShower[~rainShower.keys.choose], inf)/Pwrand([0.5, 1, 2], [2, 4, 2].normalizeSum, inf),
          ~pstepDur[\rainShower], inf),
  \ffreq, 1100,
  \mix, Pwhite(0.001, 0.1),
  \dur, Pstep(~rSwitch[\rainShower].next, ~pstepDur[\rainShower], inf),
  \strum, Pstep(Pwhite(0.1, 3.0), ~pstepDur[\rainShower]),
  \cleanupDelay, 0.1,
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~rainShowerDef = PbindFx(*i.collect { |x| Pbindef(x) });
);

(
~rSwitch[\riverDrone] = Pswitch(~patRhythm, Pseq([10, 11, 12, 8], inf)).asStream;
~pstepDur[\riverDrone] = 5;

Pbindef(\riverDrone,
  \instrument, Prand([\bpfsaw], inf),
  \amp, 0.2*(2**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~riverDrone[~riverDrone.keys.choose], inf)/Prand([0.5, 1, 2], inf), ~pstepDur[\riverDrone], inf),
  \dur, Pstep(~rSwitch[\riverDrone].next, ~pstepDur[\riverDrone], inf),
  \legato, 1.2,
  \atk, Pwhite(0.1, 3),
  \rel, Pwhite(1, 2.0),
  \strum, Pstep(Pwhite(0.2, 0.5), ~pstepDur[\riverDrone]),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~riverDroneDef = PbindFx(*i.collect { |x| Pbindef(x) });
);

(
~rSwitch[\thunder] = Pswitch(~patRhythm, Pseq([2, 3, 4], inf)).asStream;
~pstepDur[\thunder] = 4;

Pbindef(\thunder,
  \instrument, Prand([\reed, \cautious, \kalimba], inf),
  \amp, 0.2*(1**Pgauss(0, 0.1)),
  \freq,Pstep(Pseq(~thunder[~thunder.keys.choose], inf)/Pwhite(1, 2), ~pstepDur[\thunder], inf),
  \dur, Pstep(~rSwitch[\thunder].next, ~pstepDur[\thunder], inf),
  \legato, 2,
  \atk, Pwhite(0.1, 3.0),
  \rel, Pwhite(1.0, 2.0),
  \strum, Pstep(Pwhite(0.0, 1.0), ~pstepDur[\thunder]),
  \cleanupDelay, Pfunc{|e| e.atk + e.rel},
  \out, Pn(Pshuf([0, ~distLowBus, ~verbBus]))
);

~thunderDef = PbindFx(*i.collect { |x| Pbindef(x) });
)
