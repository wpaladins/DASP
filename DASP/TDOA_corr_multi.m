% To be used with 2 mics, 2 audiosrc, 0 noisesrc.

%---- white noise ----------------%
disp('WHITE NOISE');
speechfiles{1} = 'White_noise1.wav';
speechfiles{2} = 'White_noise1.wav';
noisefiles{1} = 'Babble_noise1.wav'; %just for functionality of function
TDOA_corr_multifunc(speechfiles, noisefiles);

disp(' ');

%---- speech ---------------------%
disp('SPEECH');
speechfile = 'speech1.wav';
[speech_sampled, fs_speech] = audioread(speechfile);
speech_sampled = speech_sampled(1:100000); %truncate 100 000 samplse
audiowrite('speech1_somesamples.wav',speech_sampled,fs_speech);

speechfile = 'speech2.wav';
[speech_sampled, fs_speech] = audioread(speechfile);
speech_sampled = speech_sampled(1:100000); %truncate 100 000 samples
audiowrite('speech2_somesamples.wav',speech_sampled,fs_speech);


speechfiles{1} = 'speech1_somesamples.wav';
speechfiles{2} = 'speech2_somesamples.wav';
noisefiles{1} = 'Babble_noise1.wav'; %just for functionality of function
TDOA_corr_multifunc(speechfiles, noisefiles);