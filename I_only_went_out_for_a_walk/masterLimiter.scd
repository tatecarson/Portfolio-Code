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
