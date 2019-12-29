%% Program init

clc; clear all; close all;

%% Importing the file 

fs = 16000;
recTime = 10;
Mode = 2;
recorder1 = audiorecorder(fs,16,2,1);

switch Mode
    case 1
        disp('Start Playing')
        recordblocking(recorder1, recTime);
        disp('End of Recording.');

        x = getaudiodata(recorder1);
    case 2
        filename = 'C:\Users\Charles\Documents\MATLAB\Wav Files\500miles.wav';
        [x,fs] = audioread(filename);
end
Dec = 10;
P = x(:,1) + x(:,2); % Comment this line if the file is mono
%P = x(:,1);    % Comment this line if the the file is stereo
y = decimate(P,Dec); %Convert from stereo to mono

Fs = fs/Dec; %New sampling frequency
fc = 170; %Chebyshev cutoff frequency
% [b,a] = cheby1(3,5,fc/(Fs/2),'high');
% yfi = filter(b,a,y);
% y=yfi;

figure(1);
t = 1/Fs:1/Fs:size(y,1)/Fs;
plot(t',y);

sigma =128;
Gv = STFT(y,sigma);

tnew = 1/Fs:1/Fs:size(Gv,2)/Fs;
f = linspace(0,Fs/2,size(Gv,1));
figure(2);   %Open a new figure window
colormap(jet(256)) % Define the color scale (follow a standard)
imagesc([tnew(1),tnew(end)],f,Gv);   %Graphical representation of the STFT:
colorbar;   % Displays a color bar in the right side of the figure
title('Short-Time Fourier Transform Representation of the Signal'); %Define the title for the figure
xlabel('Time (s)'); % Define the label for the x-axis of the figure
ylabel('Frequency (Hz)');   %Define the label for the y-axis of the figure