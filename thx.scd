// http://earslap.com/article/recreating-the-thx-deep-note.html
(
{
    var numVoices = 30;
    var fundamentals = ({rrand(200.0, 400.0)}!numVoices).sort.reverse;
    var finalPitches =  (numVoices.collect({|nv| 440*(2**((nv/6).round-3)); }));
    var sweepFactors = ({rrand(0.5,4)}!numVoices);
    Mix
    ({|numTone|
        var initRandomFreq = fundamentals[numTone] + LFNoise2.kr(0.5, 6 * (numVoices - (numTone + 1)));
        var destinationFreq = finalPitches[numTone] + LFNoise2.kr(0.1, (numTone / 3));
        var sweepFactor = sweepFactors[numTone];
        var sweepEnv = 1;
        var freq = ((1 - (sweepEnv**sweepFactor)) * initRandomFreq) + ((sweepEnv**sweepFactor) * destinationFreq);
        Pan2.ar
        (
            BLowPass.ar(Saw.ar(freq), freq * 6, 0.6),
            rrand(-0.5, 0.5),
            (1 - (1/(numTone + 1))) * 1.5
        ) / numVoices
    }!numVoices);
}.play;
)


// http://earslap.com/article/recreating-the-thx-deep-note.html
(
{
    var hz_ = 440;
    var amp_ =1;

    var numVoices = 9;
    var fundamentals = ({rrand(200.0, 400.0)}!numVoices).sort.reverse;
    var finalPitches =  (numVoices.collect({|nv| hz_*(2**((nv/2).round-3)); }));
    var sweepFactors = ({rrand(0.2,2)}!numVoices);
    var voices=(1..numVoices-1).collect({|numTone|
        var initRandomFreq = fundamentals[numTone] + LFNoise2.kr(0.5, 6 * (numVoices - (numTone + 1)));
        var destinationFreq = finalPitches[numTone] + LFNoise2.kr(0.1, (numTone / 3));
        var sweepFactor = sweepFactors[numTone];
        var sweepEnv = amp_;
        var freq = ((1 - (sweepEnv**sweepFactor)) * initRandomFreq) + ((sweepEnv**sweepFactor) * destinationFreq);
        Pan2.ar(
            BLowPass.ar(Saw.ar(freq), freq * 6, 0.6),
            rrand(-0.5, 0.5),
            (1 - (1/(numTone + 1))) * 1.5
        ) / numVoices
    });
    Mix.ar(voices);
}.play;
)

// http://earslap.com/article/recreating-the-thx-deep-note.html
{
    arg out, hz=55.1, amp=0.02, amplag=0.02, hzlag=0.01;
    var amp_, hz_;
    amp_ = Lag.ar(K2A.ar(amp), amplag);
    hz_ = Lag.ar(K2A.ar(hz), hzlag);

    var numVoices = 9;
    var fundamentals = ({rrand(200.0, 400.0)}!numVoices).sort.reverse;
    var finalPitches =  (numVoices.collect({|nv| hz_*(2**((nv/2).round-3)); }));
    var sweepFactors = ({rrand(0.2,2)}!numVoices);
    var voices=(1..numVoices-1).collect({|numTone|
        var initRandomFreq = fundamentals[numTone] + LFNoise2.kr(0.5, 6 * (numVoices - (numTone + 1)));
        var destinationFreq = finalPitches[numTone] + LFNoise2.kr(0.1, (numTone / 3));
        var sweepFactor = sweepFactors[numTone];
        var sweepEnv = amp_;
        var freq = ((1 - (sweepEnv**sweepFactor)) * initRandomFreq) + ((sweepEnv**sweepFactor) * destinationFreq);
        Pan2.ar(
            BLowPass.ar(Saw.ar(freq), freq * 6, 0.6),
            rrand(-0.5, 0.5),
            (1 - (1/(numTone + 1))) * 1.5
        ) / numVoices
    });
    Out.ar(out,Mix.ar(voices));
}