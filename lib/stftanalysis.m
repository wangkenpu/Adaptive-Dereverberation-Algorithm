function y = stftanalysis(s, winsize, frame_length, frame_shift)
%
%  STFTANALYSIS short time Fourier transform analysis
%  Decompose the time domain signal into the time-frequency domain signal
%
%  y = STFTANALYSIS(s, winsize, frame_length, frame_shift)
%
%  s is the time domain signal. If s is a matrix, the column of the matrix
%  will be treated a vector and the analysis will be performed on the vectors
%  separately.
%  y is the time-frequency signal. If number of channels equals to 1, the
%  the return value y will be a 2-D matrix (frame_number x window_size).
%  If the number of channels is more than 1, y will be a 3-D matrix
%  (frame_number x window_size x channel_number)

% =============================================================================
% Created by Ke WANG at 2019-02-20
% =============================================================================

win = hamming(winsize);
channel_num = size(s, 2);
frame_num = ceil((size(s, 1) - frame_length)/ frame_shift) + 1;
s = [s; zeros(frame_shift - mod(length(s) - frame_length, frame_shift), channel_num)];
y = zeros(frame_num, winsize, channel_num);

for l = 1 : frame_num
    index = (l-1) * frame_shift;
    y(l,:,:) = reshape(...
        fft(bsxfun(@times, [s(index + 1:index + frame_length, :); zeros(winsize - frame_length, channel_num)], win)),...
        1, winsize, channel_num);
end
