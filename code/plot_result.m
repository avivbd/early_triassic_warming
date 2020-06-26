function [] = plot_result(T, Y, p)
% This function plot the result of forward_model.m and the input
% perturbation
% Detail: the input Y is the result of forward_model.m, it contains:
% Y = [MC; delC_MC ; MALK; MSr; RSr] --> [carbon mass, carbon isotope, ...
% alkalinity 'mass', strontium mass, strontium isotope] 
%

figure,

subplot(6,1,1)
plot(T,p.F_C_volc_t)
title('Perturbation')
xlabel('time')
ylabel('')

subplot(6,1,2)
plot(T,Y(:,1))
title('Carbon mass')
xlabel('time')
ylabel('')

subplot(6,1,3)
plot(T,Y(:,2))
title('Carbon isotope')
xlabel('time')
ylabel('')

subplot(6,1,4)
plot(T,Y(:,3))
title('Alkalinity')
xlabel('time')
ylabel('')

subplot(6,1,5)
plot(T,Y(:,4))
title('Strontium')
xlabel('time')
ylabel('')

subplot(6,1,6)
plot(T,Y(:,5))
title('Strontium isotope')
xlabel('time')
ylabel('')

end

