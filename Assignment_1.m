% MATLAB Code for DSP Signal Processing Task

% Parameters
Fs = 8000;            % Sampling frequency (Hz)
T = 1/Fs;             % Sampling period (s)
L = 4096;             % Number of samples (2 Hz resolution)
t = (0:L-1)*T;        % Time vector

% Generate Clean 1000 Hz Signal
f_clean = 1000;       % Frequency of clean signal (Hz)
clean_signal = sin(2*pi*f_clean*t);  % 1000 Hz sine wave

% Simulated Recorded Signal (placeholder for actual voice recording)
% In practice, you would replace this with an actual recording.
recorded_signal = clean_signal + 0.05*randn(size(t));  % Add some noise

% Load the singing wave audio file
[singing, Fs] = audioread('singing.wav');

t = linspace(0, length(pianoWave)/fs, length(pianoWave));


% Perform FFT for both signals
Y_clean = fft(clean_signal);
Y_recorded = fft(recorded_signal(end-(fs/2)+1:end));

% Compute the two-sided spectrum, then the single-sided spectrum
P2_clean = abs(Y_clean/L);  % Two-sided spectrum for clean signal
P1_clean = P2_clean(1:L/2+1); % Single-sided spectrum
P1_clean(2:end-1) = 2*P1_clean(2:end-1); % Convert to single-sided

P2_recorded = abs(Y_recorded/L); % Two-sided spectrum for recorded signal
P1_recorded = P2_recorded(1:L/2+1); % Single-sided spectrum
P1_recorded(2:end-1) = 2*P1_recorded(2:end-1); % Convert to single-sided
S =P2_clean(1,2001:4049);
figure;
subplot(2,1,1);
plot(f, P2_clean(1,2001:4049));
title('Two-sided spectrum for clean signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]); % Limit x-axis to 3000 Hz
grid on;

% Plot the Magnitude Spectrum for the Recorded Signal
subplot(2,1,2);
plot(f, P1_clean);
title('Single-sided spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]); % Limit x-axis to 3000 Hz
grid on;

% Frequency axis
f = Fs*(0:(L/2))/L;

% Convert to dB scale
P1_clean_dB = 20*log10(P1_clean);
P1_recorded_dB = 20*log10(P1_recorded);

% Plot the Magnitude Spectrum for the Clean Signal
figure;
subplot(2,1,1);
plot(f, P1_clean_dB);
title('Magnitude Spectrum of Clean 1000 Hz Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]); % Limit x-axis to 3000 Hz
grid on;

% Plot the Magnitude Spectrum for the Recorded Signal
subplot(2,1,2);
plot(f, P1_recorded_dB);
title('Magnitude Spectrum of Recorded Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 3000]); % Limit x-axis to 3000 Hz
grid on;

% Display some relevant information about the signal
disp('Sampling frequency: 8000 Hz');
disp('Frequency resolution: 2 Hz');
disp('Major peak at 1000 Hz with some minor peaks around it.');


%--------------------------------------------------------------
% Læs din optagelse (wav-fil)
[optaget_signal, Fs_optaget] = audioread('voice_recording.wav'); % Udskift 'optagelse.wav' med navnet på din fil

% Tjek om signalet er stereo, og konvertér til mono, hvis nødvendigt
if size(optaget_signal, 2) == 2
    optaget_signal = mean(optaget_signal, 2); % Konvertér stereo til mono ved at tage gennemsnittet af kanalerne
end

% Beregn FFT for det optagede signal
n_optaget = length(optaget_signal); % Antal samples i optagelsen
optaget_fft = abs(fft(optaget_signal)); % Beregn magnitude af FFT
optaget_fft = optaget_fft(1:floor(n_optaget/2)); % Vi tager kun den positive halvdel af FFT'en

% Definer frekvensaksen
f_optaget = (0:floor(n_optaget/2)-1)*(Fs_optaget/n_optaget);

% Find den frekvens, hvor der er en top i spektret (den dominerende frekvens)
[~, idx_max] = max(optaget_fft); % Find indekset for det største peak
dominerende_frekvens = f_optaget(idx_max); % Den dominerende frekvens i optagelsen

% Udskriv den dominerende frekvens
fprintf('Den dominerende frekvens i optagelsen er: %.2f Hz\n', dominerende_frekvens);

