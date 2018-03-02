clear all

load exposure_stimulus_experiment.mat

ssu = spikes_single_unit;

stimulus_start_times = 0:1/6:(60-1/6);
x = length(ssu);
y = (1:360);


figure

for i = 1:360
    for j = 1:length(ssu)
        if(stimulus_start_times(i) <= ssu(j)) && (ssu(j) <= stimulus_start_times(i+1))
            x(i) = ssu(j) - stimulus_start_times(i);
            plot(x(i),y(i),'*')
            hold on 
        end
    end
    
    xlabel('Time (s)')
    xticks([0 1/6])
    xticklabels({'0','1/6'})
    ylabel('Stimulus Number')
    yticks(0:60:360)
end