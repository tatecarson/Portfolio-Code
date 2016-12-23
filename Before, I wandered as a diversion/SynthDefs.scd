//Define sytnh definitions

//6.a Synthdefs
SynthDef(\bpfbuf, {
	arg buf = 0, spos = 0, stretch = 1, windowsize = 6, mul = 1,
			atk = 1, sus = 0, rel = 1, drop = 20, outof = 40, mode = 1,
			freq = 440, rq = 1, bpfmix = 0, pan = 0, amp = 0.2, out = 0;
	var sig, env, overlaps, harm, wwinsize, wwinoverlap, wwinran;
	overlaps = 10;
	harm = [12, 5, -12].midiratio.asRef;
	wwinsize = `[0.11, 0.11, 0.11, 0.2];
	wwinsize = 0.7;
	wwinoverlap = 8;
	wwinran = 1;
	env = EnvGen.kr(Env([0,1, 1,0],[atk,sus, rel]), doneAction:2);
	sig = WarpOverlap.ar(1, buf, overlaps, spos*BufFrames.ir(buf), stretch, harm, windowsize, wwinsize,
											wwinoverlap, wwinran, mul);
	sig = WaveLoss.ar(sig, drop, outof, mode);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig * env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;

//synthesizing spectral data
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
	freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2,
	lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1, 1,0],[atk,sus, rel]), doneAction:2);
	sig = Saw.ar(freq * {LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\reed, {
    |out = 0, freq = 440, amp = 0.1, gate = 1, atk = 0.3, rel = 0.3|
    var snd, blow;
    snd = Pulse.ar((Rand(-0.03, 0.05) + freq.cpsmidi).midicps, 0.48 + LFNoise1.kr(0.06, 0.1), 0.2);
    snd = Disintegrator.ar(snd, 0.5, 0.7);
    snd = snd * LFNoise2.kr(5, 0.05, 1);
    blow = EnvGen.ar(Env.asr(atk, 1.0, rel), gate, doneAction: 2);
    snd = snd + BPF.ar(snd, blow.linexp(0, 1, 2000, 2442), 0.3, 3);
    snd = BHiShelf.ar(snd, 1200, 1, 3);
    snd = snd * blow;
    Out.ar(out, Pan2.ar(snd, 0, amp));
}).add;

SynthDef(\cautious,{arg out = 0, freq= 440,amp=0.2, ffreq=1000, pan=0.0, percRel = 1;
  var sound;
  sound= BLowPass.ar(LFCub.ar(freq).clip,ffreq, 0.1, 0.6)*amp*EnvGen.ar(Env.perc(releaseTime:percRel), doneAction:2);
  Out.ar(out,Pan2.ar(sound,pan))
}).add;

SynthDef(\kalimba, {
    |out = 0, freq = 440, amp = 0.1, mix = 0.1|
    var snd;
    snd = SinOscFB.ar(freq, LFNoise0.kr(1).range(0, 0.7)) * EnvGen.ar(Env.perc(0.005, Rand(2.5, 3.5), 1, -8), doneAction: 2);
    snd = (snd * (1 - mix)) + (DynKlank.ar(`[
        [240*ExpRand(0.9, 1.1), 2020*ExpRand(0.9, 1.1), 3151*ExpRand(0.9, 1.1)],
        [-7, 0, 3].dbamp,
        [0.8, 0.05, 0.07]
    ], PinkNoise.ar * EnvGen.ar(Env.perc(0.001, 0.01))) * mix);
    Out.ar(out, Pan2.ar(snd, 0, amp));
}).add;

SynthDef(\clarIn,{
  arg pan = 0, amp = 0.5, out = 0, drop = 20, outof = 40, mode = 1, mix = 0.8, gateThresh = 0.13;
  var sig, inSig;
  sig = SoundIn.ar(0);
  inSig = SoundIn.ar(0);
  sig = WaveLoss.ar(sig, drop, outof, mode);
  sig = Pan2.ar(sig, pan, amp);
  sig = XFade2.ar(inSig, sig, mix*2-1);
  sig = Compander.ar(sig, sig, gateThresh, 10, 1, 0.01, 0.01); //to help with feedback
  Out.ar(out, sig)
}).add;

//fx send with dry/wet
SynthDef(\satan, {
  arg envTime = 1.0e-3, knee = -10.dbamp, out, in, mix = 1, amp = 0.1;
  var sig, inSig = In.ar(in, 2);
  sig = DelayC.ar(inSig, 0.01, envTime * 0.5) *
        EnvFollow.ar(inSig, 1 - (envTime * SampleRate.ir).reciprocal).max(knee).reciprocal;
	sig = sig * amp;
	Out.ar(out, (1 - mix) * inSig + (sig * mix));
}).add;

SynthDef(\reverb, { |out, in, damp = 0.5,
	delayTime = 10, size = 2, diff = 0.2, feedback = 0.2|
	var sig, inSig = In.ar(in, 2);
	Out.ar(out, Greyhole.ar(inSig, delayTime, damp, size, diff, feedback));
}).add;
