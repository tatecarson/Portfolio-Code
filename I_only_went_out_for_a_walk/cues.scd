//bufname, bufnum, length, nlength = 20, noteHead, atk, sus, rel, density, bpfmix, group
//length is length of sample playback and notation on screen
//nlenght is number of notes shown at once

//arrays of timeline postions
//make more options
~def = [1, 20, 35, 60]; //default rhythm

//get a larger probability of random values closer to cue 5
~cT = ~numEvents.collect{~def.collect{|item, i| item + rrand(i, i+10)}};

//overlaps
~ol = [1, 2, 3, 4, 7, 9];

//cue 1 total length
~c1Length = ~cT[0][3] + 11;

//bufname, bufnum, length, nlength = 20, atk, sus, rel, density, bpfmix, group
 ~cue.put(1,
	{"cue 1".postln; ~synthGroup.do(_.release(rrand(2, 5)))}, //release previous group
	timeline:[
		0:         {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[0][0] - ~cT[0][1]).abs+~ol.choose, rrand(4, 10),
                  exprand(0.01, 1), exprand(0.01, 1),
                  exprand(0.01, 1), 1, 0.0, ~synthGroup[0]);
                  ~score.text(1, "1. non pitched, percussive")
                  },
	  ~cT[0][1]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[0][1] - ~cT[0][2]).abs+~ol.choose, rrand(4, 10),
                  exprand(0.01, 5), exprand(0.01, 2),
									exprand(0.01, 1), 1, 0.0, ~synthGroup[0])},
	  ~cT[0][2]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[0][2] - ~cT[0][3]).abs+~ol.choose, rrand(4, 10),
                  exprand(0.01, 4), exprand(0.01, 3),
									exprand(0.01, 1), 1, 0.0, ~synthGroup[0])},
		~cT[0][3]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, 11, rrand(4, 10),
                  exprand(0.01, 7), exprand(0.01, 6),
									exprand(0.01, 1), 1, 0.0, ~synthGroup[0])},
	],
	timelineOptions: (mode: \time, quant: 0) // this works in seconds
);


//cue 2 total length
~c2Length = ~cT[1][3] + 16;

~cue.put(2,{ "cue 2".postln; ~synthGroup.do(_.release(rrand(2, 5)))},
	timeline:[
		0:         {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[1][0] - ~cT[1][1]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 1),
                   exprand(0.01, 1), exprand(0.01, 1), 1, 0.1, ~synthGroup[1]);
                   ~score.text(1, "2. non pitched, airy")
                   },
		~cT[1][1]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[1][1] - ~cT[1][2]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 7),
                   exprand(0.01, 9), exprand(0.01, 1), 2, 0.1, ~synthGroup[1]);
                  },
		~cT[1][2]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[1][2] - ~cT[1][3]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 8),
                   exprand(0.01, 8), exprand(0.01, 1), 3, 0.2, ~synthGroup[1]);
                  },
		~cT[1][3]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, 16,
                  rrand(4, 10), exprand(0.01, 9), exprand(0.01, 7),
									 exprand(0.01, 1), 2, 0.3, ~synthGroup[1]);
                  },
	],
	timelineOptions: (mode: \time, quant: 0) // this works in seconds
);


//cue 3 total length
~c3Length = ~cT[2][3] + 14;

~cue.put(3,{"cue 3".postln; ~synthGroup.do(_.release(rrand(2, 5)));},
	timeline:[
		0:         {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[2][0] - ~cT[2][1]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 1), exprand(0.01, 1),
									 exprand(0.01, 1), 5, 0.4, ~synthGroup[2]);
                   ~score.text(1, "3. moving towards pitch, percussive")
                   },
		~cT[2][1]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[2][1] - ~cT[2][2]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 10), exprand(0.01, 5),
									 exprand(0.01, 1), 4, 0.4, ~synthGroup[2])},
		~cT[2][2]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[2][2] - ~cT[2][3]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 10), exprand(0.01, 7),
									 exprand(0.01, 1), 5, 0.5, ~synthGroup[2])},
		~cT[2][3]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, 14+~ol.choose, rrand(4, 10),
                   exprand(0.01, 10), exprand(0.01, 8),
									 exprand(0.01, 1), 6, 0.6, ~synthGroup[2])},
	],
	timelineOptions: (mode: \time, quant: 0) // this works in seconds
);

//cue 4 total length
~c4Length = ~cT[3][3] + 10;

~cue.put(4,
	{"cue 4".postln; ~synthGroup.do(_.release(rrand(3, 7)))},
	timeline:[
		0:         {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[3][0] - ~cT[3][1]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 1), exprand(0.01, 1),
									exprand(0.01, 1), 5, 0.4, ~synthGroup[3]);
                  ~score.text(1, "4. pitched, lively/ faster tempo")
                  },
		~cT[3][1]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[3][1] - ~cT[3][2]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 10), exprand(0.01, 6),
									exprand(0.01, 1), 4, 0.8, ~synthGroup[3])},
		~cT[3][2]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, (~cT[3][2] - ~cT[3][3]).abs+~ol.choose,rrand(4, 10),
                  exprand(0.01, 11), exprand(0.01, 7),
									exprand(0.01, 1), 5, 0.6, ~synthGroup[3])},
		~cT[3][3]: {~noteInit.(
                  ~randBuf.name, ~randBuf.num, 10*~ol.choose, rrand(4, 10),
                  exprand(0.01, 5), exprand(0.01, 5),
									exprand(0.01, 1), 6, 0.7, ~synthGroup[3])},
	],
	timelineOptions: (mode: \time, quant: 0) // this works in seconds
);

//cue 5 total length
~c5Length = ~cT[4][3] + 10;

~cue.put(5,
	{"cue 5".postln; ~synthGroup.do(_.release(rrand(5, 8)))},
	timeline:[
		0:         {~noteInit.(
                   ~randBuf.name, ~randBuf.num, (~cT[4][0] - ~cT[4][1]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 1), exprand(0.01, 1),
									 exprand(0.01, 1), 7, 0.4, ~synthGroup[4]);
                   ~score.text(1, "5. pitched, quick and jittery/ chaotic")
                   },
		~cT[4][1]: {~noteInit.(
                   ~randBuf.name, ~randBuf.num, (~cT[4][1] - ~cT[4][2]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 1), exprand(0.01, 1),
									 exprand(0.01, 1), 8, 0.8, ~synthGroup[4])},
		~cT[4][2]: {~noteInit.(
                   ~randBuf.name, ~randBuf.num, (~cT[4][2] - ~cT[4][3]).abs+~ol.choose, rrand(4, 10),
                   exprand(0.01, 1), exprand(0.01, 1),
									 exprand(0.01, 1), 7, 0.6, ~synthGroup[4])},
		~cT[4][3]: {~noteInit.(
                   ~randBuf.name, ~randBuf.num, 10, rrand(4, 10),
                   exprand(0.01, 1), exprand(0.01, 1),
									 exprand(0.01, 1), 9, 0.7, ~synthGroup[4])},
	],
	timelineOptions: (mode: \time, quant: 0) // this works in seconds
);
