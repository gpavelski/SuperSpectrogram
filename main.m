%% Program init

clc; clear all; close all;

%% Importing the file 

fs = 16e3;
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
        filename = 'C:\Users\Charles\Documents\MATLAB\Wav Files\Test.wav';
        [x,fs] = audioread(filename);
end
Dec = 10;
P = x(:,1) + x(:,2); % Comment this line if the file is mono
%P = x(:,1);    % Comment this line if the the file is stereo
y = decimate(P,Dec); %Convert from stereo to mono

Fs = fs/Dec; %New sampling frequency

%% STFT Computation

t = 1/Fs:1/Fs:size(y,1)/Fs; % Compute the time instants 
l = 7; % Define the level of detail of the STFT
sigma =2^l; % Compute sigma
Gv = STFT(y,sigma); % Compute the STFT
lenSTFT = 2^(nextpow2(length(y))); % Compute the length of the STFT
occSpace = ceil(length(y)*size(Gv,2)/lenSTFT); % Compute the number of rows effectively used by the STFT
f = linspace(0,Fs/2,size(Gv,1)); % Compute the frequency axis values 
fmin = 392; % Define the minimum frequency to display
fmax = 800; % Define the maximum frequency to display
ifmin = find(abs(fmin-f') == min(abs(fmin-f'))); % Compute the index related to the minimum frequency
ifmax = find(abs(fmax-f') == min(abs(fmax-f'))); % Compute the index related to the maximum frequency

%% STFT Display %%
figure(2);   %Open a new figure window
colormap(jet(256)) % Define the color scale (follow a standard)
imagesc([t(1),t(end)],[f(ifmin), f(ifmax)],Gv(ifmin:ifmax, 1:occSpace));   %Graphical representation of the STFT:
%colorbar;   % Displays a color bar in the right side of the figure
title('Short-Time Fourier Transform Representation of the Signal'); %Define the title for the figure
xlabel('Time (s)'); % Define the label for the x-axis of the figure
ylabel('Frequency (Hz)');   %Define the label for the y-axis of the figure

hold on; % Hold the plot
notes = ["sil";...
         "G1"; "Ab1"; "A1"; "Bb1";"B1";"C2";"C#2";"D2";"Eb2";"E2";"F2"; "F#2";...
         "G2"; "Ab2"; "A2"; "Bb2";"B2";"C3";"C#3";"D3";"Eb3";"E3";"F3"; "F#3";...
         "G3"; "Ab3"; "A3"; "Bb3";"B3";"C4";"C#4";"D4";"Eb4";"E4";"F4"; "F#4";...
         "G4"; "Ab4"; "A4"; "Bb4";"B4";"C5";"C#5";"D5";"Eb5";"E5";"F5"; "F#5";...
         "G5"; "Ab5"; "A5"; "Bb5";"B5";"C6";"C#6";"D6";"Eb6";"E6";"F6"; "F#6"; ...
         "G6"; "Ab6"; "A6"; "Bb6"; "B6"; "C7"; "C#7"; "D7"; "Eb7"; "E7"; "F7"; "F#7"]; % Define the names of the musical notes
     %1       1        1           1        1        2        2          2 
fnotes = [0;...
    49     ; 51.91   ; 55     ; 58.27   ; 61.74   ; 65.41  ; 69.3    ; 73.42   ; 77.78  ; 82.41  ; 87.31   ; 92.5    ; ... 
    98     ; 103.83  ; 110    ; 116.54  ; 123.47  ; 130.81 ; 138.59  ; 146.83  ; 155.56 ; 164.81 ; 174.61  ; 185     ; ...
    196.00 ; 207.65  ; 220.00 ; 233.08  ; 246.94  ; 261.63 ; 277.18  ; 293.66  ; 311.13 ; 329.63 ; 349.23  ; 369.99  ; ...
    392.00 ; 415.30  ; 440.00 ; 466.16  ; 493.88  ; 523.25 ; 554.37  ;  587.33 ; 622.25 ; 659.25 ; 698.46  ; 739.99  ; ...
    783.99 ; 830.61  ; 880.00 ; 932.33  ; 987.77  ; 1046.50; 1108.73 ; 1174.66 ; 1244.51; 1318.51; 1396.91 ; 1479.98 ; ...
    1567.98 ; 1661.22; 1760.00; 1864.66 ; 1975.53; 2093.00 ; 2217.46 ; 2349.32; 2489.02 ; 2637.02 ; 2793.83; 2959.96];
%     G        Ab        A        Bb        B        C          C#       D         Eb       E         F         F#
k1 = f(ifmin);
ind1 = find(abs(k1-fnotes') == min(abs(k1-fnotes')));
k2 = f(ifmax);
ind2 = find(abs(k2-fnotes') == min(abs(k2-fnotes')));

for i = ind1:ind2
    plot(linspace(0,t(end),1000), fnotes(i)*ones(1, 1000), '-w');
end
yticks(fnotes(ind1:ind2));
yticklabels(notes(ind1:ind2));