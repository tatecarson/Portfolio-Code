SynthDef(\bpfbuf, {
  arg atk=0, sus=1, rel=3, c1=1, c2=(-1), gate = 1, length,
  buf=0, rate=1, spos=0, freq=440, rq=1, bpfmix=0,
  pan=0, amp=1, out=0;
  var sig, env;
  env = EnvGen.kr(Env([0, 1, 1, 0], [atk, sus, rel].normalizeSum, [c1, 0, c2]), gate, timeScale: length, doneAction:2);
  sig = PlayBuf.ar(2, buf, rate*BufRateScale.ir(buf), startPos:spos);
  sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
  sig = sig * env;
  sig = Pan2.ar(sig, pan, amp);
  Out.ar(out, sig);
}).add;
