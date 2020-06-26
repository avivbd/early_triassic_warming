function [ output_args ] = forward_model( input_args )
% This function sets up the forward model
%   Detailed explanation goes here

p = model_params(); % getting model parameters set up
p.tspan = linspace(-253, -246, 100);

A1 = 0.75;
A2 = 0.25;
omega1 = 0.5;
omega2 = 1.3;
phi1 = pi/2;
phi2 = pi/3;

% Sinusoildal input perturbation:
p.F_C_volc_t = p.F_C_volc_0*( 1 + A1*sin(omega1*p.tspan + phi1) + ...
                                  A2*sin(omega1*p.tspan + phi2)); 

M0 = [p.M_C , p.delC, p.M_ALK, p.M_Sr, p.R_Sr]; % initial conditions

% Solving the system:
[T, Y] = ode45( @(t, x) model_eqs(x, t, p), p.tspan, M0); 

%plot_ode(T,Y, p)

plot_result(T, Y, p)

end

