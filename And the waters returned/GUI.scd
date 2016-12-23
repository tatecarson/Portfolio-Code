//GUI to connect to AWS and to start and stop composition
b = NetAddr.new("ec2-52-53-233-5.us-west-1.compute.amazonaws.com", 9000); 

Window.closeAll;
w = Window("nested", Rect(750, 50, 250, 500))
.front
.alwaysOnTop_(true);

w.view.decorator_(FlowLayout(w.bounds, 30@30, 30@30 ));

c = Array.fill(1, {
	arg view;
	view = CompositeView(w, 200@400)
	.background_(Color.new255(154, 205, 50));

	view.decorator_(FlowLayout(view.bounds, 5@10, 5@10))
});

~setup = StaticText(c[0],150 @50)
  .string_("Setup")
  .font_(Font("Monaco", 20));

//local or web
~netAddr = EZListView.new(c[0],150@65, " Target");
~netAddr.addItem(\Web, { b = NetAddr.new("ec2-52-53-233-5.us-west-1.compute.amazonaws.com", 9000)}; );
~netAddr.addItem(\LocalHost, { b = NetAddr.new("localhost", 9000)};);
~netAddr.setColors(Color.grey, Color.white);

//if local host open terminal without aws key

~awsText = StaticText(c[0],150 @30)
  .string_("1. Start AWS -        rhizome config");

~awsStart = Button(c[0], 150@30)
  .states_([
  	["Open Terminal"]
  ])
  .action_({ |v|
    if(v.value == 0){
      "cd ~/documents/AWS; ssh -i \"rhizome-test.pem\" ubuntu@ec2-52-53-233-5.us-west-1.compute.amazonaws.com".runInTerminal;
		}
	}

  );


~ctText = StaticText(c[0], 150@10)
  .string_("2. Test Connection");

~connectTest = Button(c[0], 150@30)
  .states_([
  	["ON"],
  	["OFF"]
  ])
  .action_({ |v|
    if(v.value == 1){
  			Tdef(\working).play;
  		}{
  			Tdef(\working).stop;
        b.sendMsg("/working", 0);
  	}}
  );

~startComp = Button(c[0], 150@30)
  .states_([
  	["Start Comp"],
  	["Stop"]
  ])
  .action_({ |v|
    if(v.value == 1){
				//Notation
  			Tdef(\addNodes).play;
        Tdef(\staggered).play;
				Tdef(\playSound).play;

				~distFx = Synth(\satan, [mix: 0.3, envTime: 0.0001, knee: -40.dbamp, in:~distBus, out: ~verbBus], addAction: \addToTail);
				~verbFx = Synth(\reverb, [delayTime: 3, damp: 0.2, size: 7, diff: 0.2, feedback: 0.2, in: ~verbBus, out: ~defaultOut], addAction: \addToTail);

  		}{
				//Notation
        Tdef(\addnoNodes).stop;
        Tdef(\staggered).stop;
				Tdef(\playSound).stop;

				//synths
				Pdef.all.do(_.stop);
				~distFx.free;
				~verbFx.free;
				~distFxBus.free;
				~verbFxBus.free;

				//zero out arays
				~flute1Trigger =   0!8;
				~flute2Trigger =   0!8;
				~hornTrigger =     0!8;
				~altoTrigger =     0!8;
				~pianoTrigger =    0!8;
				~keyboardTrigger = 0!8;
				~violinTrigger =   0!8;
				~guitarTrigger =   0!8;
  	}}
  );
