// birds

(play{
	var a=LFCub;
	var osc = (Limiter.ar(SinOsc.ar(SinOsc.kr(0.2,mul:0.1).abs,mul:1.5))+1)/2;
	osc.scope;
	Limiter.ar(osc*GVerb.ar(Formlet.ar(a.ar(Convolution.ar(b=LinCongN.ar(5),b)),a.ar(Sweep.ar(a.ar(1/9),3)).range(1999,3999),0.01,0.1),mul:10),0.01)
})

// bells

play{a=SinOsc.ar(LFNoise0.ar(10).range(100,1e4),0,0.05)*Decay.kr(Dust.kr(1));GVerb.ar(a*LFNoise1.ar(32.703),299,400,0.2,0.5,50,0,0.2,0.9,mul:0.1)}



// bass + drums

// "sidechain compressed bass"
// adapted from https://sccode.org/1-55m
({
	var bpm = 120;
	var freq=32.703;
	var bassamp=0.3;
	var pulse = Decay2.ar(Impulse.ar(bpm/60), 0.01, 1)*SinOsc.ar(freq,mul:0.2);
	var bass = Splay.ar(SinOscFB.ar(freq, 1.5, bassamp));
	var thresh = 0.02;
	var compression = 0.05;
	var attack = 0.01;
	var release = 0.2;
	var lfo = SinOsc.kr(0.05,mul:bassamp,add:1);
	var snd = Compander.ar(bass, pulse, thresh, 1, compression, attack, release,bassamp).scope;

	var drums = GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,512),WhiteNoise.ar*Pulse.ar(4*(bpm/60),1e-4*TChoose.kr(SinOsc.kr(0.5),[0.25,0.5,1,2,3,4,5,6,7,8,9,10]))),0.1)),roomsize:1,damping:0.3,revtime:2,mul:0.2,mul:SinOsc.ar(0.05,mul:1,add:0.01).abs).scope+Limiter.ar(SinOsc.ar(9*Pulse.ar(0.5),0,Pulse.kr(Pulse.kr(1))),level:SinOsc.ar(0.1,mul:0.1).abs);
	var mix = Mix.new([snd*lfo,bass*(1-lfo),drums*0.1]);
	mix = Compander.ar(mix);
	Limiter.ar(MoogFF.ar(mix, 1300, 0.5,mul:10))
}.play)


play{SinOsc.ar(40)*Pulse.ar(0.5)}

// "sidechain compressed bass"
// adapted from https://sccode.org/1-55m
({
	var bpm = 120;
	var freq=32.703;
	var pulse = Decay2.ar(Impulse.ar(bpm/60), 0.01, 1)*SinOsc.ar(freq,mul:0.2);
	var bass = Splay.ar(SinOscFB.ar(freq, 1.5, 0.5));
	var thresh = 0.02;
	var compression = 0.05;
	var attack = 0.01;
	var release = 0.2;
	var lfo = SinOsc.kr(0.05,mul:0.5,add:1);
	var snd = Compander.ar(bass, pulse, thresh, 1, compression, attack, release);
	MoogFF.ar(Mix.ar([snd*lfo,bass*(1-lfo)]), 1200, 0.5)
}.play)


// cool drums
play{GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,512),WhiteNoise.ar*Pulse.ar(8,5e-4)),0.1)),roomsize:2,damping:0.6,revtime:2,mul:0.1)+Limiter.ar(SinOsc.ar(9*Pulse.ar(0.5),0,Pulse.kr(Pulse.ar(1))),level:0.5)}//w8


b=SinOsc;
play{b.ar(0.5).scope}
play{b.ar(0.5).scope}



// snare?
({
	var bpm=120;
	var carrier = Pulse.ar(4*(bpm/60),1e-4*TChoose.kr(SinOsc.kr(2),[4,5,6,7,8,9,10]));
	var noiseAmp = EnvGen.ar(Env.perc(0.001, 0.15),gate:carrier);
   var  noise = BPF.ar(WhiteNoise.ar, 810, 1.6) * noiseAmp;
	var  popFreq = EnvGen.ar(Env([3261, 410, 160], [0.005, 0.01], curve: \exp));
    var popAmp = EnvGen.ar(Env.perc(0.001, 0.11)) * 0.7;
    var pop = SinOsc.ar(popFreq) * popAmp;
	Splay.ar(pop+noise)
}.play)



({
	var pan=0;
	var amp=0.3;
  var pop, popAmp, popFreq;
    var noise, noiseAmp;
    var snd;


    // pop makes a click coming from very high frequencies
    // slowing down a little and stopping in mid-to-low
    popFreq = EnvGen.ar(Env([3261, 410, 160], [0.005, 0.01], curve: \exp));
    popAmp = EnvGen.ar(Env.perc(0.001, 0.11)) * 0.7;
    pop = SinOsc.ar(popFreq) * popAmp;
    // bandpass-filtered white noise
    noiseAmp = EnvGen.ar(Env.perc(0.001, 0.15), doneAction: 2);
    noise = BPF.ar(WhiteNoise.ar, 810, 1.6) * noiseAmp;

    snd = (pop + noise) * 1.3
}.play)


play{SinOsc.ar(9*Pulse.ar(0.1),0,Pulse.kr(Pulse.ar(1)))}

play{p=Pulse;GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,128),WhiteNoise.ar*p.ar(8,5e-4)+SinOsc.ar(9*p.ar(0.1),0,n=p.kr(p.ar(5)))),n)))}//w8

play{MoogFF.ar(GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,1024),WhiteNoise.ar*Pulse.ar(8,2e-2)),SinOsc.ar(Duty.kr(3,0,Dseq((10..19),inf)))))),4000)}

(
play{
	var out, tempo, bps,redfrik,rukano1,rukano2,rukano3;
	a=SinOsc;
    p = Pulse;
	m=Impulse;
	d=Dust;
	y=LFNoise0;
	tempo = 105;
	bps = tempo/60;
	out = Silent.ar(2);

	// https://twitter.com/aucotsi/status/913784615797772289
	out = Mix([out,2*(2*Pan2.ar(a.ar(120*p.ar(1,a.kr(bps)).tanh)+GrainIn.ar(2,a.kr([bps*2,bps*3/2]),1/2**9,Hilbert.ar(a.ar(303+9*a.kr(9+7*a.kr(bps*2))))),a.kr(bps*2))/9)]);



	/*
	out = Mix([out, 1/2*tanh(m.kr(bps*4).lag*Crackle.ar(LFSaw.kr(bps*1.5).abs.lag*1.8)+GVerb.ar([m.kr(bps)+m.kr(bps*2,0.5)].lag*Blip.ar(4.9,7,0.4)!2,1,1)*5)]);
*/

	// https://twitter.com/earslap/status/18314287525
    out =  Mix([out, 1/50*AllpassC.ar(Splay.ar(tanh((LFNoise0.ar((bps*4)!2,8).lag(*{LFNoise2.ar(bps*2).exprange(5e-3,500)}!2)*pi).cos*75),0.5),1,8e-3,LFNoise0.ar(bps*4,2))]);


	// https://twitter.com/redFrik/status/405428776005140480
	redfrik=a.ar(0,a.ar(b=[bps,bps*2])*400,a.ar(b/4));
	 redfrik = redfrik+a.ar(b*99*Amplitude.ar(redfrik,0,1/7))+GrayNoise.ar(CombN.ar(redfrik,1,b/3))/2;
	out = Mix([out,0.1*redfrik]);


	// piece of paper
	// https://twitter.com/aucotsi/status/400609338684760064
	out = Mix([out,0.01*WhiteNoise.ar(p.ar(TChoose.kr(a.kr(bps),[bps,bps*2]))*p.ar(bps*8,0.1))]);
	// out = Mix([out,0.1*(GVerb.ar(WhiteNoise.ar*p.ar(TChoose.kr(a.kr(bps),[bps,bps*2]))*p.ar(bps*8,0.1))+a.ar(97*p.ar(bps*2),0,p.kr(bps*2.5)))]);



	// random billiards?
	// https://twitter.com/rukano/status/225580253232373760
 rukano1 = m.ar(bps*2)+d.ar(bps);	rukano2=(TExpRand.ar(_,_,rukano1));
	out =  Mix([out,
	0.1*Limiter.ar(GVerb.ar(GrainFM.ar(2,rukano1,rukano2.(1e-4,0.01),f=rukano2.(20,60),f/4,9),9,0.5))
	]);


	// // https://twitter.com/datfonk/status/386600998283661312
	out =  Mix([out,
	(a.ar(Pulse.ar([bps/2,bps/3])*10)+MoogFF.ar(Saw.ar(y.ar(1,50,1666)),y.ar(4)*XLine.ar(1,50,99,99,0,2)))!3/2]);


	// kicks
// https://twitter.com/awhillas/status/22165574690
	out =  Mix([out,
		Pan2.ar(Mix.new(a.ar([50,80,120,40],0,EnvGen.kr(Env.perc(0.01,0.3),Impulse.kr(bps/2*[2.005,2,3,1.5])))))*0.4]);


	// https://twitter.com/SCi_borg/status/854724943904485376
out = Mix([out,
		//                                change below
		GVerb.ar(LFPulse.ar(bps+SinOsc.kr([bps/2,bps/1]),0,0.5*bps/2,0.1*bps/2),2,8,0.9,0.5,40,0.5,0.7,0.55,100)]);



	out = HPF.ar(out,MouseX.kr(20,800,1));
	out = LPF.ar(out,MouseY.kr(200,12000));
		out
}
)



(play{
	var out, tempo, bps, totalinst,kick1, kick1level,kick2,kick2level, snare1,snare1level, hh1, hh1level, tom1, tom1level;
	tempo = 120;
	bps = tempo/60;
	totalinst = 5;
	kick1level = 0.7;
	kick2level = 0.1;
	snare1level = 0.05;
	hh1level = 0.01;
	tom1level = 0.1;
	totalinst = tom1level+hh1level+snare1level+kick2level+kick1level;
	// start with silence, mix in drums with it
	out = Silent.ar(2);


	// kick drum that keeps the main beat + a beat that
	// goes slightly awry every once and awhile
	// inspired from https://twitter.com/awhillas/status/22165574690
	kick1 = Pan2.ar(Mix.new(
		SinOsc.ar(
			freq:[60,80],
			mul:EnvGen.kr(
				Env.perc(0.05,0.2),
				gate:Impulse.kr([1,1.005]*bps)
			)
		)
	));
	kick1 = HPF.ar(kick1,120);
	kick1 = LPF.ar(kick1,400);
	kick1  = Limiter.ar(kick1,level:kick1level/totalinst);
	out = Mix([out,kick1]);


	// another kick
	// https://twitter.com/datfonk/status/386600998283661312
	kick2 = SinOsc.ar(
		freq: Pulse.ar(bps/2)*[24,32]
	);
	kick2 = Limiter.ar(kick2,level:kick2level/totalinst);
	out = Mix([out,kick2]);

	// alternating snares
	// inspired from https://twitter.com/redFrik/status/405428776005140480
	snare1 = SinOsc.ar(0,SinOsc.ar([bps,bps*1.5])*800,SinOsc.ar([bps,bps*1.5]/4.1));
	snare1 = snare1+SinOsc.ar([bps,bps*1.5]*99*Amplitude.ar(snare1,0,1/7));
	snare1 = Limiter.ar(snare1,level:snare1level/totalinst);
	out = Mix([out,snare1]);


	// high-hat sorta thing
	// inspired from https://twitter.com/aucotsi/status/400609338684760064
	hh1 = [WhiteNoise.ar(
		mul: EnvGen.kr(
				Env.perc(0.01,0.02),
				gate:Impulse.kr(TChoose.kr(SinOsc.kr(bps*2),2*[bps,bps/2,bps*1.5,bps*4]))
			)
	),WhiteNoise.ar(
		mul: EnvGen.kr(
				Env.perc(0.01,0.02),
				gate:Impulse.kr(TChoose.kr(SinOsc.kr(bps*2),2*[bps,bps*2,bps*1.5,bps*3]))
			)
	)];
	hh1 = Limiter.ar(hh1,level:hh1level/totalinst);
	out = Mix([out, hh1]);

	// sort of a tom
	// inspired by https://twitter.com/SCi_borg/status/854724943904485376
	tom1 = GVerb.ar(
		LFPulse.ar(bps/2+SinOsc.kr(0.1),0,bps/4,1.0,0),
		2,8,0.9,0.5,50,0.5,0.7,0.55,100
	);
	tom1 = Limiter.ar(tom1,level:tom1level/totalinst);
	out = Mix([out, tom1]);

	out = HPF.ar(out,MouseX.kr(20,800,1));
	out = LPF.ar(out,MouseY.kr(200,12000));
	out

})

{GVerb.ar(LFPulse.ar(2+SinOsc.kr(0.2),0,0.5,0.2),2,8,0.9,0.5,40,0.5,0.7,0.55,100)}.play;

play{a=SinOsc;Pan2.ar(Mix.new(a.ar([50,80,120,1200],0,EnvGen.kr(Env.perc(0.001,0.3),Impulse.kr([2.005,2,3,1.5])))))*0.2};

play{x=SinOsc;y=LFNoise0;a=y.ar(8);(x.ar(Pulse.ar(1)*24)+MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2)))!2/3}

// https://twitter.com/search?q=SinOsc%20(%23supercollider%20OR%20%23sc%20OR%20%23sctweet)&src=typed_query&f=live

// bells

// https://twitter.com/joshpar/status/100417407021092864
play{a=SinOsc.ar(LFNoise0.ar(10).range(100,1e4),0,0.05)*Decay.kr(Dust.kr(1));GVerb.ar(a*LFNoise1.ar(40),299,400,0.2,0.5,50,0,0.2,0.9)}

// https://twitter.com/joshpar/status/100417407021092864
play{a=SinOsc.ar(LFNoise0.ar(10).range(100,1e4),0,0.05)*Decay.kr(Dust.kr(1));GVerb.ar(a*LFNoise1.ar(40),299,400,0.2,0.5,50,0,0.2,0.9)}

// this one is insane
// https://twitter.com/redFrik/status/1197185125819277312
play{c=ar(e=SinOsc,0,pi**ar(SinOscFB,ar(Duty,b=("00".size.."0000000".size).reciprocal,0,Dseq("0 0 00 0 0 000  _0 0 0 00 00 00000+  !".ascii,inf)),ar(e,d=$0.ascii.reciprocal).max*0.cos.sin));ar(LeakDC,ar(Splay,c+ar(PitchShift,c,e=0.cos.cos,b.reciprocal,d,d,b)))*e}//

// https://twitter.com/awhillas/status/22165574690
play{a=SinOsc;Pan2.ar(Mix.new(a.ar([50,80,120,40],0,EnvGen.kr(Env.perc(0.01,0.3),Impulse.kr([2.005,2,3,1.5])))))*0.4};