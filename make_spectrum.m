function [Y, freq] = make_spectrum(signal, fs)
    N = length(signal);               % Number of samples
    Y = fft(signal);                  % Compute FFT
    Y = Y / N;                        % Normalize the FFT output
    freq = (-N/2:N/2-1)*(fs/N);       % Frequency vector (centered around 0)
    Y = fftshift(Y);                  % Shift zero frequency to center
end