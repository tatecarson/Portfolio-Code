//run this to start
s.newBusAllocators;

s.waitForBoot{
  ~defaultOut = 0; 
  "SynthDefs.scd".loadRelative;
  "loadData.scd".loadRelative;
  "GUI.scd".loadRelative;

  s.sync;

  "startComp.scd".loadRelative;
}
