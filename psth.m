function y = psth(spike, start, finish, bin_wdth)
% poststimulus time histogram

bins = start:bin_wdth:finish;

y = hist(spike( spike >= start-bin_wdth/2 & spike < bins(end) + bin_wdth/2 ),bins)/bin_wdth;