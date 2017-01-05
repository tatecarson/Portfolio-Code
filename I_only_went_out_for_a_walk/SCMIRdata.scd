"SCMIRraw.scd".loadRelative;

~onsets = Dictionary.new;
~onsets.add(\Huckleberry ->[~h1, ~h2, ~h3, ~h4]);
~onsets.add(\House -> [~house1, ~house2]);
~onsets.add(\Mills -> [~mills]);
