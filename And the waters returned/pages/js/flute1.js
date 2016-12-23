var movers = [];

//set these with sc and map values
var onset = 500;
var freq = 200;
var amp = 40;
var dur = 50;
var attack = 10;
var release = 25;
var show;
var working = false;

client.on('message', function(address, args) {
  if (address === '/flute1') {
    console.log(args);
    freq = args[1];
    amp = args[2];
    dur = args[3];
    attack = args[4];
    release = args[5];
    show = args[6];

    //onset, attack, decay, dur
    movers.push(new Mover(onset, freq, onset+attack, freq-amp, onset+dur-release,
      freq-amp, onset+dur, freq, show));
  }
})

client.on('message', function(address, args) {
  if (address === '/working') {
    if (args[0] == 1) {
      console.log("i'm working")
      working = true;
    } else {
      working = false;
    }
  }
});

function setup() {
  createCanvas(displayWidth, displayHeight);
}

function draw() {
  background(51);
  strokeWeight(2);
  line(100, 20, 100, 700);

  for (var i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].display();
    movers[i].changeColor();
  }

  //post text if working
  if (working) {
    fill(255);
    text("I'm working!!", 50, 50);
  } else {}

  //title
  fill(255);
  text("Flute 1", 25, 25);
}
