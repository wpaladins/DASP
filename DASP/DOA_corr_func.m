function [DOA_est, error] = DOA_corr_func(speechfiles, noisefiles)
% To be used with 2 mics, 1 audiosrc, 0 noisesrc.
% s_pos = audiosrc position
% m_pos = mic positions
%
%speechfiles and noisefiles should be arrays
%cf.    speechfiles{1} = "speech1.wav"
%       speechfiles{2} = "speech2.wav"
%       speechfiles{3} = "speech3.wav"
% best non-zero arrays, even if not used
%
% DOA_est and error are returned

load('Computed_RIRs.mat');

c = 340; %speed of sound 340 m/s

%---- GROUNDTRUTH -----%
%s_pos already loaded
m1_pos = m_pos(1,:);
m2_pos = m_pos(2,:);
m_dist = norm(m1_pos - m2_pos); %distance between mics in [m]

mavg_pos = [(m1_pos(1)+m2_pos(1))/2 (m1_pos(2)+m2_pos(2))/2];
dir_vector = s_pos - mavg_pos;
groundtruth_angle = atand((-dir_vector(1))/dir_vector(2)); % Only for the 0-90 degree range

%---- TDOA CORR -------%
[est_delay, ~] = TDOA_corr_func(speechfiles, noisefiles);

%----- DOA CORR -------%
if (est_delay*c/m_dist)>1 
    DOA_est = acosd(1);
elseif (est_delay*c/m_dist)<-1
    DOA_est = acosd(-1);
else
    DOA_est = acosd(est_delay*c/m_dist); %Tested with ground truth should be done with estimate
end
save DOA_est

error = abs(groundtruth_angle - DOA_est); % Only for the 0-90 degree range
