//synthdefs
SynthDef(\simpler, {
  arg outBus, buf=0, freq=220, sampleStart=0, loopStart=0, loopLen=1, fadeTime=0.1, gate=1,
      attack=0.01, sustain=1, release=1, f0=220, drop = 20, outof = 40, mode = 1,
      amp = 1;

  var rate = freq / f0;
  var sr = rate*BufSampleRate.kr(buf);
  var fadeFrames = fadeTime*sr;
  var loopEnd = loopLen*(BufFrames.kr(buf) - loopStart) + loopStart;
  var loopFrames = loopEnd - loopStart + 1;
  var loopTime = (loopFrames - fadeFrames)/sr;
  var startUpTime = (loopStart - sampleStart)/sr;
  var trigLoop = TDuty.ar(Dseq([startUpTime + loopTime, Dseq([loopTime], inf)]), gapFirst:1);
  var phaseA = Phasor.ar(trigLoop, rate, sampleStart, inf, loopStart);
  var phaseB = Phasor.ar(trigLoop, rate, loopEnd - fadeFrames, inf, loopEnd - fadeFrames);
  var srcA = BufRd.ar(2, buf, phaseA);
  var srcB = BufRd.ar(2, buf, phaseB);
  var startLoop = SetResetFF.ar(trigLoop);
  var loopPan = Phasor.ar(trigLoop, 2/fadeFrames * rate, -1, inf, -1).clip(-1,1);
  var out = Select.ar(startLoop, [srcA, LinXFade2.ar(srcB, srcA, pan:loopPan)]);
  var env = EnvGen.ar(Env.asr(attack, sustain, release, 1), gate, doneAction:2);

  out = WaveLoss.ar(out, drop, outof, mode);
  Out.ar(outBus, out * env * amp);
}).add;

//work on these envelopes
SynthDef(\oneShotSampler, {
  |outBus, bufnum, amp= 0.7, attack= 0.01, curve = -4, release= 0.1, gate= 1, offset= 0, rate = 1|
  var src= PlayBuf.ar(2, bufnum, BufRateScale.ir(bufnum)*rate, 1, BufFrames.ir(bufnum)*offset, 0);
  var env= EnvGen.kr( Env.perc(attack, release, curve:curve), gate, 1, 0, 1, 2);
  Out.ar(outBus, src*env*amp);
}).add;

//drone gran
//add envelope to whole sound
SynthDef(\gran_2b, { |outBus, pos = 0, sndBuf = 0, windowBuf = 1, granDur = 0.1,
  rate = 1, loop = 1, panMax = 0, amp = 0, bpFreq = 500, bpRQ = 0.5, bpWet = 1,
  ltime = 1|
  var window, granSrc, src;
  granSrc = PlayBuf.ar(2, sndBuf, BufRateScale.kr(sndBuf) * rate,
    1, round(pos * BufFrames.kr(sndBuf)), loop, 2);
  window = BufRd.ar(1, windowBuf,
    EnvGen.ar(Env([0, BufFrames.kr(windowBuf)], [granDur]),
    doneAction: 2), loop, 4);
  src = (BPF.ar(granSrc, bpFreq, bpRQ, mul: (bpRQ ** -1) * (400 / bpFreq ** 0.5)) *
    bpWet + (granSrc * (1 - bpWet)));
  OffsetOut.ar(outBus, src * amp * window);
}).add;
w = Buffer.sendCollection(s, Signal.hanningWindow(1024));

SynthDef(\klankDrone, {|outBus,
		klankfreqs = #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		klankamps = #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    rings = #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], gate = 1, hpffreq = 18000,
		pan = 0, bufnum, rate = 1, loop = 0, amp = 0.2, lpffreq = 440, q = 0.2, saturation = 1, klankmix = 0, pointer,
	  warpRate = 1, droneMix = 0, pos = 0, tsustain = 1, envCurve = 1, masterDist = 0.5, wdrop = 20, wmode = 1|
    var sig, localBuf, record, droned, klank, env, i, z;
    env = EnvGen.ar(\env.kr(Env([ 0,1,1,0 ],[1,1,1])),gate, timeScale:tsustain, doneAction:2);
    i = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate, startPos: BufFrames.kr(bufnum)*pos, loop:loop);
    z = Klank.ar(`[klankfreqs, klankamps, rings], i);
    klank = SelectX.ar(klankmix, [i, z]); //mix between klanked and dry sample
		klank = BLowPass.ar(klank, hpffreq);
		klank = WaveLoss.ar(klank, wdrop, mode: wmode);
    localBuf = LocalBuf.new(SampleRate.ir * 1, 2).clear; //hold sample in a drone
    record = RecordBuf.ar(klank, localBuf, loop: 0);
    droned = Warp1.ar(1, localBuf, pointer, warpRate, 0.1, -1, 8, 0.1, 2);
    droned = BLowPass4.ar(droned, lpffreq, q);
    sig = SelectX.ar(droneMix, [klank, droned]);
    sig = sig + SineShaper.ar(sig, mul: masterDist); //add a little distortion to everything
		sig = Limiter.ar(sig, 0.4);
    Out.ar(outBus, sig * env * amp);
}).add;

//use routine to load kernal
{
  ~newUHJDecoder =FoaDecoderKernel.newUHJ;
  ~spreadEncoder = FoaEncoderKernel.newSpread;
  ~diffuseEncoder = FoaEncoderKernel.newDiffuse;

  s.sync;

  SynthDef(\foaPanB, {
      arg inBus, theta, phi, distance, angle = 0, rotAngle, tilAngle, tumAngle, gain;
      var src, foa, decoderMatrix, sig;
      var freq = 20.0;

      src = In.ar(inBus, 2);
      foa = FoaPanB.ar(src, theta, phi);

      //transform
      foa = HPF.ar(foa, freq);
      foa = FoaTransform.ar(foa, 'proximity', distance );
      foa = FoaTransform.ar(foa, 'focus', angle, theta, phi);
      sig = FoaDecode.ar(foa, ~newUHJDecoder);
      Out.ar(0, sig);
  }).add;

  SynthDef(\foaSpread, {
    arg inBus, angle = 0, theta = 0, phi = 0, rotAngle, tilAngle, tumAngle, gain, distance;
    var src, foa, decoderMatrix, sig;
    src = In.ar(inBus, 2);
    foa = FoaEncode.ar(src, ~spreadEncoder);
    foa = FoaTransform.ar(foa, 'dominate', gain, theta, phi);
    sig = FoaDecode.ar(foa, ~newUHJDecoder);
    Out.ar(0, sig);
  }).add;

  // try rotation here
  SynthDef(\foaDiffuse, {
      arg inBus, rotRate = 1.0, angle = 0, theta = 0, phi = 0, gain, distance;
      var src, foa, rotAngle, tilAngle, tumAngle, decoderMatrix, sig;

      rotAngle = LFNoise2.kr(rotRate, 2pi);
      tilAngle = LFNoise2.kr(rotRate, 2pi);
      tumAngle = LFNoise2.kr(rotRate, 2pi);

      src = In.ar(inBus, 2);
      foa = FoaEncode.ar(src, ~diffuseEncoder);

      foa = FoaTransform.ar(foa, 'focus', angle, theta, phi);

      sig = FoaDecode.ar(foa, ~newUHJDecoder);
      Out.ar(0, sig);
  }).add;
}.fork;
