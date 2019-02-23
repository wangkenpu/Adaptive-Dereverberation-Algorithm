clc; clear; close all;

% *************************************************************************
% Set path
% *************************************************************************
addpath(genpath('lib'));
output_dir = 'wav_out/';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
    disp(['mkdir', output_dir])
end

% *************************************************************************
% Input and output configurations
% *************************************************************************
filepath = 'wav_sample/';
sample_name = 'sample_4ch.wav';
file_name = [filepath, sample_name];
out_name = [output_dir, ['drv_', sample_name]];

% *************************************************************************
% Set parameters
% *************************************************************************
% num_mic = 1;                 % the number of microphones
% frame_length = 400;          % frame length (25 ms)
% frame_shift = 160;           % frame shift (10 ms)
% win_size = 512;              % the number of subbands (512 points STFT)
% alpha = 0.99;                % forgetting factor
cfgs = 'config.m';

% *************************************************************************
% Read audio file and processing
% *************************************************************************
disp('Reading Audio Files:');
disp(file_name);
[x, fs] = audioread(file_name);

y = rls_ada(x, cfgs);

% *************************************************************************
% Output
% *************************************************************************
disp(['Write to file:', out_name]);
audiowrite(out_name, y / max(max(abs(y))) * 0.5, fs);

rmpath(genpath('lib'));
