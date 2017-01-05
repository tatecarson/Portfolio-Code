//combine notation and synth func
~noteInit = { |bufname, bufnum, length = 20, nlength = 1, atk, sus, rel, density, bpfmix, group|

	//post so you see what's happening
	bufname.postln;

	~durtoFrac = DurtoFrac(nlength);

	~newA = ~onsets[bufname][bufnum][..nlength];

	nlength.do{|i|
		~makeNotation.(~newA[i])
	};
	
	~score.note(1, ~phrase);

	~melDens = density; //relating sample density to melodic density in notation

	density.do{
	 Synth(
		 \bpfbuf,
		 [
			 \buf, b[bufname][bufnum],
			 \length, length,
			 \atk, atk,
			 \sus, sus,
			 \rel, rel,
			 \bpfmix, bpfmix,
			 \freq, (Scale.lydian.degrees+69).choose.midicps * [1, 2].choose,
			 \rq, exprand(0.001, 0.008),
			 \rate, exprand(0.6, 1.2),
			 \pan, rrand(-0.5, 0.5),
			 \amp, exprand(4, 6),
		 ], group
	 );
	 };

};

//Proto funciton gives ability to return multiple things
~randBuf = Proto{
	~name = {[\Huckleberry, \Mills, \House].choose};
	~num = {rrand(0, (b[~name].size))};
};
