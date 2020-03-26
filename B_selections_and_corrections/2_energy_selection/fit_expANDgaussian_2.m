function [fitresult_511,fitresult_base] = fit_expANDgaussian_2(energy)
%FIT_EXPANDGAUSSIAN Summary of this function goes here
%   Detailed explanation goes here

FIGURE_ON = 0;

xbin = 0:10:2000;
n = hist(energy,xbin);


%%
idx_511mask = xbin < 800 & xbin > 200;

idx = idx_511mask;

x = xbin(idx);
y = n(idx);
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

try
    fitresult_511 = fit( xData, yData, ft, opts );
catch
    fitresult_511.b1 = nan;
    fitresult_511.c1 = nan;
    return;
end

FWHM = fitresult_511.c1*1.665;
PEAK_511 = fitresult_511.b1;

if(PEAK_511>300 && PEAK_511<800 && FWHM<200)
    idx_511mask_new = xbin < PEAK_511+FWHM  & xbin > PEAK_511-FWHM/2;
else
    idx_511mask_new = xbin < 1000 & xbin > 200;
end

if(FIGURE_ON)
hold on
    bar(xbin,n)
    bar(x,y)
    plot(fitresult_511)
hold off
legend off
end


%%


idx_min_energy = xbin > 50 & xbin<1500;
idx = idx_min_energy & ~idx_511mask_new & n>0;


% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
%opts.StartPoint = [271.392955570026 -0.00354815668758753];

x = [xbin(idx) PEAK_511+FWHM*1.5];
y = [n(idx)     0];
[xData, yData] = prepareCurveData( x, y );
[fitresult_base, gof] = fit( xData, yData, ft, opts );

if(FIGURE_ON)
hold on
    bar(x,y)
     plot(fitresult_base,'b')
hold off
end
%%

idx = idx_511mask_new;
n_nobase = n-fitresult_base(xbin)';
n_nobase(n_nobase<0) = 0; 
%
x = xbin(idx);
y = n_nobase(idx);
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

try
    fitresult_511 = fit( xData, yData, ft, opts );
catch
    fitresult_511.b1 = nan;
    fitresult_511.c1 = nan;
    return;
end


if(FIGURE_ON)
hold on
    %bar(xbin(idx),n_nobase(idx)+fitresult_base(xbin(idx))')
    bar(xbin(idx),n(idx)')
    plot(xbin, fitresult_base(xbin) + fitresult_511(xbin),'r','linewidth',2)
hold off
legend off

xlim([0 800])
ylim([0 max(n)]*1.05)

end
end

