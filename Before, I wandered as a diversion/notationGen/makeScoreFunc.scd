//these functions were used to output the LY files. This allowed me to combine the algorithmic rhythms from
//SuperCollider with the data from OpenMusic
(
~makeScore = {
  arg pattern = [2, [1, 2, [3, [4, 5]], 6]], spectrum = ~riverDrone[\tbandRejectClar], mult = 16;
  var rotations, staff1, staff2, score, file, nMeasures, tsig, maskN;

  //global measure number
  nMeasures = 10;

  //mask measure number
  maskN = 20;

  tsig = [4, 4];

  staff1 = LP_Measure(tsig, 1!mult, spectrum.flatten.cpsmidi);
  staff1 = LP_Staff(staff1 ! nMeasures);
  staff1.selectBy(LP_Leaf).mask((pattern ! maskN).flat);
  staff1.selectBy(LP_PitchEvent).transpose(1); //transpose for Clarinet
  score = LP_Score([staff1]);
  file = LP_File(score);
  file.write;
}
)

//gets only clar
(
var dict = ~thunder;
var n = dict.keys.asArray.size/2;
var r = Pwrand([1, -1, 2, 3], [5, 3, 2, 2].normalizeSum, inf).asStream;
var o = Prand([1, 3, 5, 7], inf).asStream;

n.do{|i|
  ~makeScore.value(
    pattern: [o.next+1, [1*r.next, 2*r.next*o.next, [3*r.next, [4*r.next*o.next, 5*r.next]], 6/o.next]],
    spectrum: dict[dict.keys.asArray[i*2]],
    mult:(o.next+1)*4
    )
}
)


~makeScore.value(pattern: [32, [1, 2, [3, [4, 5]], 6]], mult: 32)
