//Initialize Piece
(
s.newAllocators; //free previous busses

s.waitForBoot{
	//cleanup

	b.free; 	 //buffers
	/*a.remove;*/

	//loadfiles
	{
		"MasterLimiter.scd".loadRelative;
		"loadBuffers.scd".loadRelative;
		"SynthDefs.scd".loadRelative;

		s.sync;

		"ambisonicsSetup.scd".loadRelative;

		s.sync;

		"patterns.scd".loadRelative;

		s.sync;

		"monomeInit.scd".loadRelative;

		s.sync;

		"wekinator.scd".loadRelative;
	}.fork;
}
);
