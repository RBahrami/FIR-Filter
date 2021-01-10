% MIT License
% 
% Copyright (c) 2021 Reza Bahrami
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.


# Noisy Sin Signal Generator 
# AUTHOR : Reza Bahrami
# Email : r.bahrami.work@outlook.com

close all; clear all; clc;

% Create sin wave
t = 0 :0.1 : 4 * pi;
y = sin(t);

% Add noise to sin wave
noiseAmp = 1;
noisyY = y + (-noiseAmp/2) + noiseAmp * rand(1, length(y));

% Create to file objects
file = fopen('Signal.dat', 'w');
fileN = fopen('Noisy Signal.dat', 'w');

% Save wave data in 'Signal.dat' and noisy wave in 'Noisy Signal.dat'
for index = 1 : length(y)
    fprintf(file, '%g\n', int32(y(index)* 100000));
    fprintf(fileN, '%g\n', int32(noisyY(index)* 100000));
end

% Close files
fclose(file);
fclose(fileN);
% End