(
{
    // play with the room size
    var x;
    x = LFSaw.ar(XLine.kr(100,15000,6),0,0.1);
    GVerb.ar(x, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + x;
}.scope;
)



(
{
	var out, hz=250.1, amp=0.92, hzlag=0.01, attack=3,release=6,mod1=5;
    var perc = EnvGen.ar(Env.perc(attack, release), doneAction:Done.freeSelf);
	var ender = EnvGen.ar(Env.asr(attack, 1, release), gate:1, doneAction:Done.freeSelf);
    var numVoices = 12;
    var voices=(1..numVoices-1).collect({|numTone|
		var freq = hz + LFNoise2.kr(rrand(1,mod1*3),rrand(0,mod1));

        Pan2.ar(
            BLowPass.ar(Saw.ar(freq), freq * 6, 0.6),
            rrand(-0.6, 0.6),
			perc*ender*amp
        )
    });
	Mix.ar(voices)
}.play
)


(
// a SynthDef
SynthDef(\test2, { | out, freq = 440, amp = 0.1, gate = 1,attack=2,release=3,mod1=1 |
	var perc = EnvGen.ar(Env.perc(attack, release), doneAction:Done.freeSelf);
	var ender = EnvGen.ar(Env.asr(attack, 1, release), gate:1, doneAction:Done.freeSelf);
    var numVoices = 20;
    var voices=(1..numVoices-1).collect({|numTone|
		var freq2 = freq + LFNoise2.kr(rrand(1,mod1*3),rrand(0,mod1));

        Pan2.ar(
            BLowPass.ar(Saw.ar(freq2), freq2 * 6, 0.6),
            rrand(-0.9, 0.9),
			perc*ender*amp
		)
    });
	Out.ar(out,Mix.ar(voices))
}).add;
)

(
 Pbind(\instrument,\test2,
	\freq,    [53, 57, 60].midicps,
	\dur, 9,
 ).play
)

[30,40].midicps