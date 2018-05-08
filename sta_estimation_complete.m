clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

%% Generate STA
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;

% sta = ???
sta = zeros(length(sta_freq),length(sta_time));
num_samples = floor(length(sta_time)/2);
spks = 0;
for spk = spikes'
    [m,closest_ind] = min(abs(stim_time-spk));
    
    if(closest_ind > 25 && closest_ind < length(stim_time)-25)
        sta = sta + stim_spectrogram(:,closest_ind-num_samples:closest_ind+num_samples);
        spks = spks + 1;
    end
end

sta = sta/spks;

%% Plot results
figure(2)
plot_spectrogram(sta, sta_time, sta_freq);
xlabel('Time relative to spike (ms)')
colorbar

%% stimulus correlation matrix
figure(3)
stim_corr = stim_spectrogram*stim_spectrogram';
plotmatrix(stim_corr)