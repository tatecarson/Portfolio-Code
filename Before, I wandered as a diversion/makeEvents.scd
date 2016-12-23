//Here I define the movment like stuctures that will be randomly
//chosen from. The keys of the dictionary group a certain type of sound
//to the notation that it matches

e = Dictionary.new;

e.add(\cicada -> {
	//start patterns
	Pdef.all.do(_.stop); //stop previous patterns
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][2],
		\amp, Pwhite(0.2, 0.5),
		\atk, Pexprand(1.0, 2.0),
		\rel, Pexprand(0.9, 2.0),
		\dur, Prand([1, 3, 5], inf),
		\windowsize, Pwhite(0.1, 2.0),
		\mode, 1,
		\pan, Pwhite(-1.0, 1.0)
	).play;
	Pbindef(\cicada).play;

	~notationObj = ~notation[\cicada];
  ~notationTempo = Pwhite(5.0, 7.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.5).asStream;  // bigger the ball louder the sound, range 0-1
	~phraseStyle = ["hum with the cicadas", "join the cicadas symphony", "cicada choir", "moon song"].choose;
});

e.add(\cricket -> {
	Pdef.all.do(_.stop);
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][3],
		\amp, Pexprand(0.1, 0.3),
		\atk, Pexprand(1.0, 3.0),
		\rel, Pexprand(1.0, 3.5),
		\dur, Prand([0.1, 0.5, 1.5], inf),
		\stretch, 5,
		\windowsize, Pwhite(0.1, 1.0),
		\drop, 10,
		\outof, 30,
		\mode, 1
	).play;
	Pbindef(\cricket).play;

	~notationObj = ~notation[\cricket];
  ~notationTempo = Pwhite(5.0, 7.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.5).asStream;
	~phraseStyle = ["the cricket sang", "and the sun sets", "chirping", "sunny in the weather's face"].choose;
});

e.add(\ferry -> {
	Pdef.all.do(_.stop);
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][0],
		\dur, Prand([0.1, 0.5, 1.5], inf),
		\amp, Pexprand(0.4, 0.6),
		\atk, Pexprand(2.0, 4.0),
		\rel, Pexprand(1.0, 3.0),
		\stretch, 10,
		\windowsize, Pwhite(2.0, 8.0),
		\drop, Pwhite(5, 25),
		\outof, 40,
		\mode, 0
	).play;
	Pbindef(\ferry).play;

	~notationObj = ~notation[\ferry];
  ~notationTempo = Pwhite(3.0, 5.0).asStream;
  ~notationDyn = Pwhite(0.1, 0.5).asStream;
	~phraseStyle = ["the river widens", "against the current"].choose;

});

e.add(\natchez -> {
	Pdef.all.do(_.stop);
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][1],
		\amp, Pexprand(0.1, 0.3),
		\dur, Prand([1, 3, 5], inf),
		\atk, Pexprand(1.0, 2.0),
		\rel, Pexprand(1.0, 2.0),
		\stretch, 10,
		\windowsize, Pwhite(2.0, 8.0),
		\drop, Pwhite(5, 25),
		\outof, 40,
		\mode, 0
	).play;
	Pbindef(\natchez).play;

	~notationObj = ~notation[\natchez];
  ~notationTempo = Pwhite(3.0, 5.0).asStream;
  ~notationDyn = Pwhite(0.4, 0.6).asStream;
	~phraseStyle = ["the low tone of a steamboats horn"].choose;

});

e.add(\rainGutter -> {
	Pdef.all.do(_.stop);
	Pdef(\click, ~click).play;
	Pbindef(\clickSrc,
		\buf, b[\clicks][0],
		\amp, Pexprand(0.3, 0.6),
		\dur, Prand([1, 3, 5], inf),
		\atk, Pwhite(1.0, 3.0),
	  \sus, 0.1,
	  \rel, Pwhite(1.0, 4.0),
		\stretch, 2,
		\windowsize, Pwhite(2.0, 8.0),
		\drop, Pwhite(5, 25),
		\outof, 43,
		\mode, 1
	).play;
	Pbindef(\rainGutter).play;

  ~notationObj = ~notation[\rainGutter];
  ~notationTempo = Pwhite(7.0, 9.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.4).asStream;
	~phraseStyle = ["drizzling on a gutter", "before a downpour", "soft and then a little heavier"].choose;

});

e.add(\rainShower -> {
	Pdef.all.do(_.stop);
	Pdef(\click, ~click).play;
	Pbindef(\clickSrc,
		\buf, b[\clicks][1],
		\amp, Pexprand(0.3, 0.8),
		\dur, Prand([0.5, 1, 2, 5], inf),
		\atk, Pwhite(0.1, 2.0),
	  \sus, 0.1,
	  \rel, Pwhite(0.1, 3.0),
		\stretch, 8,
		\windowsize, Pwhite(5.0, 8.0),
		\drop, Pwhite(1, 15),
		\outof, 41,
		\mode, 0
	).play;
	Pbindef(\rainShower).play;

  ~notationObj = ~notation[\rainShower];
  ~notationTempo = Pwhite(3.0, 5.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.5).asStream;
	~phraseStyle = ["the drizzle turns into a shower", "soft and then a little heavier", "the rain was singing"].choose;

});

e.add(\riverDrone -> {
	Pdef.all.do(_.stop);
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][4],
		\dur, Prand([1, 3, 5], inf),
		\amp, Pexprand(0.4, 0.6),
		\atk, Pexprand(2.0, 4.0),
		\rel, Pexprand(1.0, 3.0),
		\stretch, 10,
		\windowsize, Pwhite(2.0, 8.0),
		\drop, Pwhite(15, 38),
		\outof, 46,
		\mode, 0
	).play;
	Pbindef(\riverDrone).play;

  ~notationObj = ~notation[\riverDrone];
  ~notationTempo = Pwhite(1.0, 3.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.3).asStream;
	~phraseStyle = ["drone with the riverboat", "low hum"].choose;

});

e.add(\thunder -> {
	Pdef.all.do(_.stop);
	Pdef(\cloud, ~cloud).play;
	Pbindef(\cloudSrc,
		\buf, b[\longtones][5],
		\dur, Prand([0.3, 0.8, 1.5], inf),
		\amp, Pexprand(0.4, 0.6),
		\atk, Pexprand(2.0, 4.0),
		\rel, Pexprand(1.0, 3.0),
		\stretch, 10,
		\windowsize, Pwhite(2.0, 8.0),
		\drop, Pwhite(15, 38),
		\outof, 45,
		\mode, 0
	).play;
	Pbindef(\thunder).play;

	~notationObj = ~notation[\thunder];
  ~notationTempo = Pwhite(1.0, 3.0).asStream;
  ~notationDyn = Pwhite(0.01, 0.5).asStream;
	~phraseStyle = ["a thunder in the distance", "booming"].choose;

});
