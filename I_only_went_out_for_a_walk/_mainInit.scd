
(
	s.waitForBoot{
		//setup inscore;
		~score = INScore.new("169.254.57.172", 7000); //use IP that the Ipad gives
		~numEvents = 5;

		{
			"masterLimiter.scd".loadRelative;
			"SCMIRdata.scd".loadRelative;
			"bufLoad.scd".loadRelative;
			"inscoreSetup.scd".loadRelative;

			s.sync;

			"SynthDefs.scd".loadRelative;

		}.fork;

		"notationSynthFunc.scd".loadRelative;

			{
				//sequence it here
				~cue = CuePlayer.new;

				1.wait;

				"cues.scd".loadRelative;
				"seqCues.scd".loadRelative;

			}.fork;

			"GUI.scd".loadRelative;

			//to check groups
			s.plotTree
	};
)
