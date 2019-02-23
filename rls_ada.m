function y = rls_ada(x, cfgs, varargin)
%
% RLS_ADA is an implemention of weighted RLS based adaptive
% dereverberation algorithm.
%
% y = rls_ada(x, cfgs, varargin)
%
% Main parameters:
% x                    input time-domain signal
% num_mic              the munber of microphones
% frame_length         frame lenght for STFT analysis
% frame_shift          frame shift for STFT analysis
% win_size             window size for STFT analysis
% forget               forgetting factor
%
% Reference:
% [1] Yoshioka T, Tachibana H, Nakatani T, et al. Adaptive dereverberation
%     of speech signals with speaker-position change detection[C].
%     2009 IEEE International Conference on Acoustics, Speech and Signal
%     Processing. IEEE, 2009: 3733-3736.
% =========================================================================
% Created by Ke WANG at 2019-02-20
% Current version 2019-02-23
% =========================================================================


% =========================================================================
% Load parameters
% =========================================================================
if ischar(cfgs)
    run(cfgs);
else
    varnames = fieldnames(cfgs);
    for i = 1 : length(varmanes)
        eval([varnames{i}, '= getfield(cfgs, varnames{i};)']);
    end
end

if exist('varargin', 'var')
    for i = 1 : 2 : length(varargin)
        eval([varargin{i}, '=  varargin{i + 1};']);
    end
end

% =========================================================================
% RLS based adaptive dereverberation algorithm
% =========================================================================
sig_channels = size(x, 2);
if sig_channels > num_mic
    x = x(:, 1:num_mic);
    fprintf('Only the first %d channels of input data are used\n\n', num_mic)
elseif sig_channels < num_mic
    error('The channels of input does not match the channel setting');
end

tic
fprintf('Processing...')

% (frame_number x window_size x channel_number)
len = length(x);
xk = stftanalysis(x, win_size, frame_length, frame_shift);
frame = size(xk, 1);
% Init mu and var
mu = zeros(num_mic, win_size / 2 + 1);
var = eye(num_mic, num_mic);
cov = var(:, :, ones(1, win_size / 2 + 1));
xc = zeros(frame, win_size);
for j = 1 : win_size / 2 + 1
    xc(1, j) = xk(1, j, 1);
end
for i = 2 : frame
    for j = 1 : win_size / 2 + 1
        x_prev = squeeze(xk(i - 1, j, :));
        cov_t = squeeze(cov(:, :, j));
        xc(i, j) = xk(i, j, 1) - mu(:, j)' * x_prev;
        csps = abs(xk(i, j, 1)).^2;
        k = (cov_t * x_prev) / (forget * csps + x_prev' * cov_t * x_prev);
        mu(:, j) = mu(:, j) + k * conj(xc(i, j));
        cov(:, :, j) = (cov_t - k * x_prev' * cov_t) / forget;
    end
end

xc(:, win_size / 2 + 2: end) = conj(xc(:, win_size / 2 : -1 : 2));
y = stftsynthesis(xc, win_size, frame_length, frame_shift);
y = y(1 : len, :) / max(max(abs(y)));
disp('Done!');
toc
