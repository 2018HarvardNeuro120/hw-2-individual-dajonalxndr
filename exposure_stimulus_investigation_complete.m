clear all

load exposure_stimulus_experiment.mat

%% Raster plot
ssu = spikes_single_unit;

start_times = 0:1/6:60;
x = length(ssu);
y = (1:360);

figure

for i = 1:length(start_times)
    for j = 1:length(ssu)
        if(start_times(i) <= ssu(j)) && (ssu(j) <= start_times(i+1))
            x(i) = ssu(j) - start_times(i);
            plot(x(i)*1000,y(i),'.')
            hold on 
        end
    end
end
xlabel('Time (ms)')
xticks(0:20:180)
ylabel('Stimulus Number')
yticks(0:60:360)

%% Gaussian distribution

t_step = .0005; 
start_times = 0:1/6:60;
total_spikes = [];
for i = 1:length(start_times)

    start = start_times(i);
    finish = start+1/6;

    spike = spikes_single_unit(spikes_single_unit>start & spikes_single_unit<finish);
    total_spikes = [total_spikes; spike-start];
end

t = 0:t_step:1/6; % time
fr = zeros(size(t)); % firing rate
for s = total_spikes'
    fr = fr + normpdf(t,s,.005); 
end
figure
plot(t*1000,fr/360) % plots average firing rate
hold on
title('standard deviation of 0.5ms')
xlabel('Time (ms)')
ylabel('Activity (Hz)')

%% Grand average psth for control & experimental groups

spike = spikes_exp;

b_wdth = .005; % ms
start_times = 0:1/6:60;
start_times(end)=[];

r_exp = zeros(length(psth(spike,0,1/6,b_wdth)),length(start_times));
for i = 1:length(start_times)
    start = start_times(i);
    finish = start + 1/6;
   
    r_exp(:,i) = psth(spike,start,finish,b_wdth);
    
end

spike = spikes_control;

r_ctrl = zeros(length(psth(spike,0,1/6,b_wdth)),length(start_times));
for i = 1:length(start_times)
    start = start_times(i);
    finish = start + 1/6;
   
    r_ctrl(:,i) = psth(spike,start,finish,b_wdth);
end

t = 0:b_wdth:1/6;
figure
plot(t*1000,mean(r_exp,2)/N_exp,t*1000,mean(r_ctrl,2)/N_control,'linewidth',2)
legend('Experimental group','Control group')
xlabel('Time (ms)')
ylabel('Firing rate (Hz)')