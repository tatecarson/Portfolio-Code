//setup clients and use same data to drive synthesis 

~flute1Trigger =   0!8;
~flute2Trigger =   0!8;
~hornTrigger =     0!8;
~altoTrigger =     0!8;
~pianoTrigger =    0!8;
~keyboardTrigger = 0!8;
~violinTrigger =   0!8;
~guitarTrigger =   0!8;

//make more dense over time
//I want the position of the node to be relatively random
Tdef(\addNodes, {
  inf.do({|i|
  ("added " ++ i ++ " node").postln;

  ~flute1Trigger.put((i+1*2)%8, 1).postln;
  ~flute2Trigger.put((i+2*3)%8, 1).postln;
  ~hornTrigger.put((i+3*2)%8, 1).postln;
  ~altoTrigger.put((i+4*3)%8, 1).postln;
  ~pianoTrigger.put((i+5*2)%8, 1).postln;
  ~keyboardTrigger.put((i+2*3)%8, 1).postln;
  ~violinTrigger.put((i+7*3)%8, 1).postln;
  ~guitarTrigger.put((i*2)%8, 1).postln;

  (~onset.sum/4).wait;
  });
});

Tdef(\staggered, {
  ~latFreq.size.do({|i|
    b.sendMsg("/flute1", 500, ~latFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~flute1Trigger[i%8]);
    b.sendMsg("/flute2", 500, ~latFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~flute2Trigger[i%8]);
    b.sendMsg("/horn", 500, ~latFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~hornTrigger[i%8]);
    b.sendMsg("/alto", 500, ~latFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~altoTrigger[i%8]);
    b.sendMsg("/piano", 500, ~longFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~pianoTrigger[i%8]);
    b.sendMsg("/keyboard", 500, ~longFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~keyboardTrigger[i%8]);
    b.sendMsg("/violin", 500, ~longFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~violinTrigger[i%8]);
    b.sendMsg("/guitar", 500, ~longFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], ~guitarTrigger[i%8]);

    //everything
    b.sendMsg("/sc", 500, ~latFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], 2);
    b.sendMsg("/sc", 500, ~longFreq[i], ~amp[i], ~dur[i], ~attack[i], ~release[i], 1);

      SystemClock.sched(4.0, {

      //think about matching envelope times with the data
      Pbindef(\padpat,
        \instrument, \pad,
        \dur, ~dur[i].linlin(130, 450, 1, 8),
        \freq, ~longFreq[i].linlin(60, 500, 1500, 50),
        \kbnmul, ~pressure[i].linlin(~pressure.minItem, ~pressure.maxItem, 10.0, 0.065),
        \amp, ~pressure[i].linlin(~pressure.minItem, ~pressure.maxItem, 1.0, 0.1),
        \rest, Pif(0.5.coin, \rest),
        \out, ~defaultOut
      ).play(quant: 0);

      Pbindef(\kordpat1,
        \instrument, \kords2,
        \dur, ~dur[i].linlin(130, 450, 1, 8),
        \freq, Pshuf([1/1, 3/2, 7/4, 9/4, 13/5].mirror * 100 *
              ~longFreq[i].linlin(60, 500, 16, 1)),
        \amp, ~pressure[i].linlin(~pressure.minItem, ~pressure.maxItem, 0.8, 0.1),
        \ratio, Pshuf([13/11, 17/11, 23/11, 29/11]),
        \rest, Pif(0.5.coin, \rest),
        \out, ~defaultOut
      ).play(quant: 0);

      //fx modulate
      ~distFx.set(\mix, ~pressure[i].linlin(~pressure.minItem, ~pressure.maxItem, 1.2, 0.0).debug('dist mix'),
                  \knee, ~longFreq[i].linlin(60, 500, -60.dbamp, -30.dbamp).debug('dist knee'));
      ~verbFx.set(\feedback, ~pressure[i].linlin(~pressure.minItem, ~pressure.maxItem, 1.0, 0.2).debug('Verb Feedback'));

    });

    //stop synths when done reading from array
    if(i > ~latFreq.size,
      {Pdef.all.do(_.stop)}
    );

    ~onset[i].wait;
  });
});
