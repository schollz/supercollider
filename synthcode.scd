// https://twitter.com/redFrik/status/1210118661022867458
(
play{
var freq = 128;
var d = freq;
var b=(2..7).reciprocal;
var c=SinOsc.ar(0,
	  pi**SinOscFB.ar(
			Duty.ar(
				b,
				0,
				Dseq([d,2/3*d,d,2/3*d,d,d,2/3*d,d,2/3*d,d,d*2-1,d,2/3*d,d,2/3*d,d,2/3*d,d,2/3*d+1],30)
			),
			0 // cool to vary this between 0 and 1
		)
	 );
	LeakDC.ar(Splay.ar(c+PitchShift.ar(c,SinOsc.kr(rrand(0.1,2),rrand(0,1),0.5,1),b.reciprocal,1/d,1/d,b)))
}
)



s.options.memSize = 200000;
s.reboot;

(
// a SynthDef
SynthDef(\test2, { | out, freq = 440, amp = 0.9, gate = 1,attack=0.5,release=2,sustain=2,mod1=0 |
	//var perc = EnvGen.ar(Env.perc(attack, sustain+release), doneAction:Done.freeSelf);
	// var env = Env([0.33, 3], [2], [2.9], 1);
	var ender = EnvGen.ar(Env.asr(attack, sustain, release), gate:gate, doneAction:Done.freeSelf);
	var d = freq;
	var b=(2..7).reciprocal;
	var dd= SinOscFB.ar(
			Duty.ar(
				b,
				0,
				Dseq([d,2/3*d,d,2/3*d,d,d,2/3*d,d,2/3*d,d,d*2-1,d,2/3*d,d,2/3*d,d,2/3*d,d,2/3*d+1,d],inf)
			),
			mod1, // cool to vary this between 0 and 1
		);
	var c=SinOsc.ar(0,
		3**d
	 );
	Out.ar(out,amp*ender*LeakDC.ar(Splay.ar(c+PitchShift.ar(c,0.5,b.reciprocal,1/d,1/d,b))))
}).add;
)

Env([0.33, 3], [2], [2.9], 1).plot;
(
 Pbind(\instrument,\test2,
	\amp, 0.1,
	\attack, 0.5,
	\release, 4,
	\mod1, 0.0,
	\sustain, 8.0,
	\freq,    [53,57,60].midicps,
	// \freq,    [38].midicps,
	\dur, 300,
 ).play
)



$1.ascii.postln
0.cos.cos.postln;
"0!".ascii.postln;
"0 0 00 0 0 000  _0 0 0 00 00 00000+ !".ascii

SinOsc.ar(1/48).max.postln


// https://twitter.com/redFrik/status/1210118661022867458
play{c=ar(e=SinOsc,0,pi**SinOscFB.ar(Duty.ar(b=("00".size.."0000000".size).reciprocal,0,Dseq("0 0 00 0 0 000  _0 0 0 00 00 00000+  !".ascii,inf)),ar(e,d=$0.ascii.reciprocal).max*0.cos.sin));ar(LeakDC,Splay.ar(c+PitchShift.ar(c,e=0.cos.cos,b.reciprocal,d,d,b)))*e}

$0.ascii.reciprocal
(
play{
var e=SinOsc;
var b=("0000".size.."0000000".size).reciprocal;
c=e.ar(0,
	  pi**SinOscFB.ar(
			Duty.kr(
				b,
				0,
				Dseq("0 0 00 0 0 000  _0 0 0 00 00 00000+  !".ascii,inf)
			)
			//,SinOsc.ar(d=$0.ascii.reciprocal).max*0.cos.sin
		)
	 );

LeakDC.ar(Splay.ar(c+PitchShift.ar(c,e=0.cos.cos,b,d,d,b)))*e
}
)


// https://twitter.com/redFrik/status/1210118661022867458
play{c=ar(e=SinOsc,0,pi**SinOscFB.ar(Duty.ar(b=("00".size.."0000000".size).reciprocal,0,Dseq("0 0 00 0 0 000  _0 0 0 00 00 00000+  !".ascii,inf)),ar(e,d=$0.ascii.reciprocal).max*0.cos.sin));ar(LeakDC,Splay.ar(c+PitchShift.ar(c,e=0.cos.cos,b.reciprocal,d,d,b)))*e}


("0000".size.."0000000".size).reciprocal.postln