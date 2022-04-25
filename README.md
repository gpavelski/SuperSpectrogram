# Super Spectrogram
Apply a Gaussian-Window STFT in an audio file in order to analyse its Time-Frequency response. Useful for identifying musical notes being played.

Using the powerful Matlab visualization tools, it allows the user to get a detailed analysis of the input waveform.

Now it accepts .wav, .mp3, .m4a, and .mp4 files as input!
It does not matter the input frequency sampling rate, but it should be constant.

You can both record your voice and view the results in (almost) real-time, or analyse an audio file recorded in advance.

Currently it can process up to 10s at once. I set up this constraint because this program is not very space-efficient. That means, processing 30s of data at 8800 Hz represents 264.500 samples, multiplying by the the window size (2048) and considering each sample as double (8 bytes), we have something like 4 GB of data to display. If the user does not take care, it can easily consume the whole RAM memory of the computer and make it stuck for a while.

Requirements for using the compiled version:
- MATLAB Runtime (it does not require a MATLAB license, and can be installed just running the .exe in the Releases) [around 1 GB]
- Windows OS
- A good RAM memory computer

Procedure to install:
Just download the .exe file in the Releases tab, install it, and run.

For compiling:
Use the .mlapp version to open the GUI, but it requires a MATLAB license (preferrably r2020a or later), including DSP toolbox. 
Then compile it using the application compiler.

Sample output:

![Image](https://github.com/gpavelski/Wav_Files_STFT_Analysis/blob/master/Display.png)
