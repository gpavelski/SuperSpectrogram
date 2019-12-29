function Gv = STFT(y,sigma)

%% Defining the signal

L = nextpow2(length(y));
Lold = length(y);
sig = zeros(1, 2^L);
sig(1,1:Lold) = y;

%% Processing the Signal in the Time-Frequency Domain

%sigma = 128; %Define the standard deviation of the Gaussian window -->sqrt(variance)
wd = 16*sigma; %Define the window size based on the value of the sigma
wdd2 = wd/2;    %Fixed, necessary for removing the edge effects
wdd8 = wd/8;    %Fixed, don't change
n = wd/32;      %Length of the window necessary for remove the edge effects (function of Variance)
ns = length(sig)/wd; %Number of windows necessary to process all the signal length

for k = 1:ns %For each window, compute a new STFT
   wSig(1:wd,1) = sig(1,(k-1)*wd+1:(k-1)*wd + wd); %wSig is the windowed signal
   TMP = stft(wSig,sigma);   
   TF2(:,(k-1)*wdd8+1:(k-1)*wdd8+wdd8) = TMP(:,1:(wd/wdd8):wd);
end

TF = TF2;   %Attribute the computed STFT to the vector TF
TF1 = zeros(size(TF2)); %Initialize a new vector TF1
for k = 1:ns-1 % Shift the original window and compute a new STFT in order to remove the edge effects
    wSig(1:wd,1) = sig(1,(k-1)*wd + 1 + wdd2:(k-1)*wd + wd + wdd2);
    TMP = stft(wSig,sigma);   
    TF1(:,(k-1)*wdd8+1:(k-1)*wdd8+wdd8) = TMP(:,1:(wd/wdd8):wd);
end

for k = 1:ns-1  % Merge the TF1 inside TF for removing the edge effects
   TF(:,k*wdd8-n:k*wdd8+n) = TF1(:,(k-1)*wdd8 + wdd8/2 - n: (k-1)*wdd8 + wdd8/2 + n); 
end


%% Representing the STFT graphically

Fv = 20*log10(fftshift(abs(TF),1)); %Convert the amplitude of the TF matrix to dB

Lthr =-70; %Define the lower bound for the threshold (dB)
Uthr = 0;  %Define the upper bound for the threshold (dB)
indices = find(Fv < Lthr | Fv > Uthr); %Compute the indexes that are out of the desired region
Fv(indices) = -Inf; % Set the undesired indexes to -Inf
Gv = Fv(size(Fv,1)/2 + 1:size(Fv,1),1:size(Fv,2));
