function [dm] = model_eqs(M, t, p)

% this block sets the initial conditions to the appropriate parameters
M_C = M(1);
del_C = M(2);
M_Alk = M(3);
M_Sr = M(4);
R_Sr = M(5);

% solve the carbonte system for pCO2, CO3, and RCO2:
[pCO2, CO3] = c_sys(M_Alk, M_C, p);
RCO2 = pCO2/p.pCO2_i;

% setting silicate and carbonate weathering inputs:
[RWsil, RWcarb] = weathering(RCO2);

omega = CO3/p.CO3_i; % saturation state
% F_C_bcarb = omega/omega_i add a log?
% F_b_org = Fpb*CP

% define input perturbation (interpolate for the solver):
F_C_volc_t = interp1(p.tspan, p.F_C_volc_t, t);

% ODE for carbon reservoir's mass:
dMC = F_C_volc_t + p.F_C_worg + p.F_C_wcarb*RWcarb ...
      - p.F_C_bcarb*omega - p.F_C_borg;

% ODE for carbon isotope:
d_delC_MC = F_C_volc_t*(p.delC_volc - del_C) + ...
            p.F_C_wcarb*RWcarb*(p.delC_wcarb - del_C) + ...
            p.F_C_worg*(p.delC_worg - del_C) - ...
            p.F_C_borg*(p.epsilon);

% ODE for Alkalinity:
dMALK = 2*p.F_Ca_wsil*RWsil + 2*p.F_C_wcarb*RWcarb - 2*p.F_C_bcarb;
 
% dMP = F_P_w - F_P_b;

% ODE for strontium's mass 
dMSr = p.F_Sr_hydro_in + p.F_Sr_w - p.F_Sr_b - p.F_Sr_hydro_out;

% ODE for strontium isotope:
dRSr = p.F_Sr_hydro_in*p.R_Sr_hydro + p.F_Sr_w*p.R_Sr_riv -...
        p.F_Sr_hydro_out*p.R_Sr_hydro - p.F_Sr_b*p.R_Sr_riv;

% vector of ODE's for the solver:
dm = [dMC; d_delC_MC ; dMALK; dMSr; dRSr];

end

function [RWsil, RWcarb] = weathering(RCO2)
% This function sets up the weathering feedback 

G = 3.3;
Z_s = 0.09;
Z_c = 0.07;

RWsil = (RCO2^(G*Z_s))*(1 + (G*Z_c)*log(RCO2))^0.65;
RWcarb = (RCO2^(G*Z_s))*(1 + (G*Z_s)*log(RCO2));

end

