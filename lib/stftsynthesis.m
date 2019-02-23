function y = stftsynthesis(s, winsize, frame_length, frame_shift)
%
%  STFTSYNTHESIS short time Fourier transform synthesis
%  Sythesize the time domain signal from the time-frequency domain signal
%
%  y1 = STFTSYNTHESIS(s, winsize, frame_length, frame_shift)
%
%  s is the T-F domain signal which should be arranged in a 3-D matrix,
%  whose size is frame_number x subband_number x channel_number. If s
%  is a 2-D matrix, it will be treated as an frame_number x subband_bumber x 1
%  3-D matrix.

% =============================================================================
% Created by Ke WANG at 2019-02-20
% =============================================================================


[frame_num, subband_number, channel_number] = size(s);
if subband_number ~= winsize
    error('The 2rd dimension of input s must agree with the winsize');
end
y = zeros((frame_num - 1) * frame_shift + winsize, channel_number);

for i = 1 : frame_num
    tmp = reshape(ifft(squeeze(s(i, :, :))), winsize, channel_number);
    index = (i - 1) * frame_shift;
    y(index + 1 : index + winsize, :) = y(index + 1 : index + winsize, :) + tmp;
end
len = length(y);
y = y(1 : len - (winsize - frame_length), :);
