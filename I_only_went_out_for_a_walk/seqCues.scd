//sequence cues
(
Tdef(\seq, {
  1.do{
    
    ~cue.trigger(1);
    ~c1Length.wait; //the last trigger in cue

    ~cue.trigger(2);
    ~c2Length.wait;

    ~cue.trigger(3);
    ~c3Length.wait;

    ~cue.trigger(4);
    ~c4Length.wait;

    ~cue.trigger(5);
    ~c5Length.wait;

    ~cue.trigger(3);
    ~c3Length.wait;

    ~cue.trigger(4);
    ~c4Length.wait;

    ~cue.trigger(2);
    ~c2Length.wait;

    ~cue.trigger(1);
    ~score.text(1, "done!");
    ~c1Length.wait;
  };
})
)
