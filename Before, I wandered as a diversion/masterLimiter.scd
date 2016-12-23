//sound limter
MasterFX.clear;
//Master Limiter
ProxyChain.add(
    \ampFin, \filter -> { |in, limDrive=1, ampLimit=0.8, postAmp=1 |
        Limiter.ar(in * limDrive, ampLimit) * postAmp;
    }
);

m = MasterFX.new(server: s,
    numChannels: 4,
    slotNames: [\ampFin],
    busIndex: 0
);

m.add(\ampFin, 1);

//free the most recent object?
//Peak CPU limiter
Tdef(\peakCPU, {
  inf.do({
    if((s.peakCPU > 75.0) || (s.avgCPU > 51.0) || (s.numUGens > 3850),
      {
        Pdef.all.do(_.stop);
        "Peak CPU reached".postln;
      }
      );
    0.01.wait;
  });
}).play;
