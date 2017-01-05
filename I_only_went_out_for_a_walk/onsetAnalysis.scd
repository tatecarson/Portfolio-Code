//Non real time analysis of onsets 

//test of onset detection

//create batch analysis
//figure out how to associate analysis with file when it plays


~scmirPath = PathName(thisProcess.nowExecutingPath).parentPath ++ "SCMIRdata/";

(
~files = [
  ~path ++"/Huckleberry/Huckleberry_1.wav", ~path ++ "/Huckleberry/Huckleberry_2.wav",
  ~path ++ "/Huckleberry/Huckleberry_3.wav", ~path ++ "/Huckleberry/Huckleberry_4.wav",
  ~path ++ "/House/footstepsaroundHouse_1.wav", ~path ++ "/House/walkinginTheYard_1.wav",
  ~path ++ "/Mills/MillsSteps_1LP.wav"];
)

//batch process; within Routine to get progress feedback as it calculates (would be slightly faster without, but calculation beachball locking sclang may seem alarming)
//batch analysis
(
  {
  ~files.do{|filename,i|

  [i, filename].postln;

  e = SCMIRAudioFile(filename, [[MFCC, 13], [Chromagram, 12]]);

  e.extractFeatures();
  e.extractOnsets();

  e.save(~scmirPath ++ (filename.splitext[0].basename++".scmirZ"));

  }
}.fork;
)

(//laod data
~loadAnalysis = {
	~onsets = Dictionary.new;
	PathName(~scmirPath).entries.do{
		arg subfolder;
		~onsets.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					SCMIRAudioFile.newFromZ(subfolder.entries[i].fullPath);
				}
			)
		);
	};
};

~loadAnalysis.()
)

e = SCMIRAudioFile.newFromZ("/Users/tatecarson/Documents/Supercollider/_OrgExamples/MyComps/realtime notation/SCMIRdata/Huckleberry_1.scmirZ");
e.featuredata.differentiate
//get feature data and differentiate from all of these

x = ~onsets[\Huckleberry][2]
x.featuredata.differentiate
