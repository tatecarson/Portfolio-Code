//Synthdefs 
{
	SynthDef(\pad, {
		|dur = 1, envgendivisor = 8, freq = 512, gate = 1,
		 kbnmul = 0.005, peak = 1, boost = 3, amp = 1, out|

		var env			=	Env.sine(dur, peak);
		var envgen	=	EnvGen.kr(env, gate, doneAction: 2);
		var kbn1		=	LFBrownNoise0.kr(freq, mul: kbnmul, add: 1);
		var saw1		=	LFSaw.ar(freq * kbn1, mul: (envgen / envgendivisor));
		var kbn2		=	LFBrownNoise0.kr(freq, mul: kbnmul, add: 1);
		var saw2		=	LFSaw.ar((freq + 0.1) * kbn2, mul: (envgen / envgendivisor));
		var kbn3		=	LFBrownNoise0.kr(freq, mul: kbnmul, add: 1);
		var saw3		=	LFSaw.ar((freq - 0.1) * kbn3, mul: (envgen / envgendivisor));
		var rlpf		=	RLPF.ar(saw1 + saw2 + saw3, freq * 1.5, 0.5, mul: envgen / 2);
		var deci		=	Decimator.ar(saw1 + saw2 + saw3, rate: 12000, bits: 8, mul: envgen);
		var kbn4		=	LFBrownNoise0.kr(mul: 0.5, add: 1);
		var hpffrq		=	(freq * 1 * kbn4).clip(100, SampleRate.ir / 3);
		var kbn5		=	LFBrownNoise0.kr(mul: 0.75, add: 1).clip(0.01, 1);
		var rhpf		=	RHPF.ar(deci, hpffrq, kbn5, mul: envgen * 0.2);
		Out.ar(out, rlpf + (rhpf * 0.2) * boost * amp);
	}).add;

	SynthDef(\kords2, { | freq = 512, gate = 1, level = 0.1, ratio = 1.125, dur = 1, out, amp = 1|
		/*var env		= 	Env.asr(attackTime: 0.5, sustainLevel: level, releaseTime: 0.5, curve: 0);*/
		var env			=	Env.sine(dur, 1);
		var envgen	=	EnvGen.kr(env, gate, doneAction: 2);
		var sfreqs	=	[freq, freq + 0.2];
		var bn		=	LFBrownNoise0.ar(sfreqs, mul: envgen / 2);
		var kbnf	=	LFBrownNoise0.kr([freq, freq], mul: 0, add: 1);
		var kbna	=	LFBrownNoise0.kr([freq, freq] / 16, mul: [0.75, 0.75], add: 1);
		var layers	=	16;
		var frqs	=	Array.fill(layers, { arg i; (sfreqs * kbnf) + (sfreqs * i * ratio * kbnf) });
		var amps	=	Array.fill(layers, { arg i; (1 / (((i + 1) * ratio) * 32)) * kbna });
		var rt		=	Array.fill(layers, { 0.3 });
		var klank	=	DynKlank.ar(`[frqs, amps, rt], bn);
		Out.ar(out, klank * amp).clip(-0.9, 0.9);
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

	~distBus = Bus.audio(s, 2);
	~verbBus = Bus.audio(s, 2);
}.fork;
