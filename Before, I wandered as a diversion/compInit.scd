//Initialize piece
(
//1. server config
s.options.outDevice_("Saffire");
s.options.numOutputBusChannels_(2);
s.options.inDevice_("Saffire");
s.options.numInputBusChannels_(2);
s.options.sampleRate(44100);
s.options.memSize_(3.pow(20));
s.options.maxNodes_(1024*4);
s.options.maxSynthDefs_(1024*4);
s.latency_(0.2);
s.newBusAllocators;
ServerBoot.removeAll;
ServerQuit.removeAll;

// 2. define path
~bufPath = PathName(thisProcess.nowExecutingPath).parentPath ++ "Buffers/";

//3. define peice-specific functions
~makeBuffers = {
	b = Dictionary.new;
	PathName(~bufPath).entries.do{
		arg subfolder;
		b.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					Buffer.read(s, subfolder.entries[i].fullPath);
				}
			)
		);
	};
};

//spectral synthesis declarations
~makeSpec = {
	~nRhythmPerms = rrand(10, 20).debug('Rhytmic Permutations'); //lower = faster, higher = slower
	~rhythmScale = 2.0; //for less ugens
	~patRhythm = ~nRhythmPerms.collect{|i| [i+1, [1, 2+i, [3+i, [4, 5]], 6+i]].convertRhythm * ~rhythmScale};
	~rSwitch = (); //make dict
	~pstepDur = ();

	//laod spectral analysis
	"SpectralDicts.scd".loadRelative;
};

//start fx synths and busses
~makeFx = {
	~group = ();
	~group.src = Group.new;
	~group.fx = Group.after(~group.src);

	~distLowBus = Bus.audio(s, 2);
	~distHighBus = Bus.audio(s, 2);
	~verbBus = Bus.audio(s, 2);

	~distClarBus = Bus.audio(s, 2);
	~verbClarBus = Bus.audio(s, 2);

	~verbFx = Synth(\reverb, [delayTime: 3, damp: 0.2, size: 7, diff: 0.2, feedback: 0.2, in: ~verbBus], target: ~group.fx);
	~distLowFx = Synth(\satan, [mix: 0.1, envTime: 0.0001, knee: -30.dbamp, in:~distLowBus], target: ~group.fx);
	~distHighFx = Synth(\satan, [mix: 0.3, envTime: 0.0001, knee: -40.dbamp, in:~distHighBus], target: ~group.fx);

	~verbClarFx = Synth(\reverb, [delayTime: 5, damp: 1.0, size: 5.0, diff: 0.4,
																feedback: 1.5, in: ~verbClarBus, out: [0, 1]], target: ~group.fx);
	~distClarFx = Synth(\satan, [mix: 0.0, envTime: 0.0001, knee: -60.dbamp, in:~distClarBus,
															 out: ~verbClarBus], target: ~group.fx);
};

~cleanup = {
	s.newBusAllocators;
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
	s.freeAll;
};

CmdPeriod.doOnce({
	s.quit;
	i.do { |x| Pbindef(x).clear };
	~clarIn.free;
	s.stopRecording;
	Window.closeAll;
	MasterFX.clear;
}); //clear pdefs on stop

//4. register functions with ServerBoot/Quit/Tree
ServerBoot.add(~makeBuffers);
ServerQuit.add(~cleanup);

//5. load synthdefs in seperate file
"SynthDefs.scd".loadRelative;

//6b. register remaining functions
ServerTree.add(~makeSpec);
ServerTree.add(~makeFx);

s.waitForBoot{
	"makePatterns.scd".loadRelative;
	"makeEvents.scd".loadRelative;
	"makeNotation.scd".loadRelative;
	"makeEventSeq.scd".loadRelative;
	"masterLimiter.scd".loadRelative;
}

)
