{
//busses for ambisonics
~foaPanBBus = Bus.audio(s, 2);
~foaSpreadBus = 4.collect{ Bus.audio(s, 2)};
~foaDiffuseBus = 4.collect{ Bus.audio(s, 2)};

s.sync;

//setup panning defualts
~foaPanB = Synth(\foaPanB, [\inBus, ~foaPanBBus,
                      \angle, (pi/2).rand, \theta, pi.rand2, \phi, pi.rand2,
                     \distance, 1.0.exprand(0.0625)], addAction: \addToTail);

                     
~foaSpread = 4.collect{|i| Synth(\foaSpread, [\inBus, ~foaSpreadBus[i], \gain, 4.0, \theta, -30.degrad], addAction: \addToTail)};

s.sync;

~foaDiffuse = 4.collect{|i| Synth(\foaDiffuse, [\inBus, ~foaDiffuseBus[i], \rotRate, 1.0], addAction: \addToTail)};

}.fork;
