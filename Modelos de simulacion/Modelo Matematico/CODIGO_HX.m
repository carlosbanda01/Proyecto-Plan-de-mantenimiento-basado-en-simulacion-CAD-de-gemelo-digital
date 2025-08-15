clc
clear
%Ecuaciones del intercambiador: Metodo efectividad-NTU (number of transfer unit)
%necesito que entren T_c_in, T_h_in, m_dot_c, m_dot_h, Cp_c, Cp_h

T_c_in=30+273.15; %K
T_h_in=80+273.15; %K
m_dot_c=10;        %kg/s
m_dot_h=3;          %kg/s
Cp_c=4178;          %J/kg-K
Cp_h=4197;          %J/kg-K

%Q_dot=C_c*(T_c_sal-T_c_ent);
%Q_dot=C_h*(T_h_ent-T_h_sal);
C_h=Cp_h*m_dot_h; %W/K
C_c=Cp_c*m_dot_c;   %W/K
C_min=min(C_c,C_h);    %W/K
C_max=max(C_h,C_c);     %W/K
C_r=C_min/C_max;    %[-]
DELTA_T_max=T_h_in-T_c_in;     %K o C
Q_dot_max=C_min*(DELTA_T_max);      %W
%________________________________________________________________________________________________
%Necesito
rho_h=971.8;        %kg/m^3 
d_t=0.0072;         %m
d_t_in=0.006;       %m
visc_h=3.653e-7;    %m^2/s
Pr_h=2.22;          %[-]
L_t=0.506;          %m
k_h=0.67;           %W/m-k
%Calculos fluido caliente, TUBOS

D_entrada_hot=0.079;
A_h=(pi/4)*D_entrada_hot^2;        %m^2
vel_h=m_dot_h/(rho_h*A_h);      %m/s


Re_h=(D_entrada_hot*vel_h)/visc_h;    %[-]
if Re_h<2100
    Nu_h=1.86*(Re_h*Pr_h*(d_t/L_t))^0.5*(Pr_h^1/3);
elseif Re_h>=2100 && Re_h<=10000
    Nu_h=0.116*((Re_h^2/3)-125)*(1+(d_t/L_t)^(2/3)*(Pr_h^1/3));
elseif Re_h>10000
    Nu_h=0.023*(Re_h^0.8)*(Pr_h^(0.4));
end
d_eq_tubos=0.077;
h_t=(k_h*Nu_h)/D_entrada_hot;

%Calculos fluido frio, coraza
%Necesito
rho_c=996;
D_c=0.506;
visc_c=8.014e-7;
Pr_c=5.421;
L_c=0.506;
k_c=0.615;
D_entrada_cold=0.044;

D_eq_c=0.113;

A_c=(pi/4)*D_entrada_cold^2;
vel_c=m_dot_c/(rho_c*A_c);

Re_c=(D_entrada_cold*vel_c)/visc_c;
if Re_c<2100
    Nu_c=1.86*(Re_c*Pr_c*D_c/L_c)^0.5*Pr_c^(1/3);
elseif Re_c>=2100 && Re_c<=10000
    Nu_c=0.116*(Re_c^(2/3)-125)*(1+(D_eq_c/L_c)^(2/3)*Pr_c^(1/3));
elseif Re_c>10000
    Nu_c=0.023*(Re_c^0.8)*Pr_c^(1/3);
end

h_c=(k_c*Nu_c)/D_entrada_cold;
%___________________________________________________________________________________________________
%se corrige el h_c
%entran
Jc=1.05;
Jl=1;
Jb=1;
Js=0.7065;
Jr=1;

h_c_corregido=h_c*Jc*Jl*Jb*Js*Jr;

%calculo de U
%entran
N_t=167;
k_tubos=121.42;
R_fi=0.000;
R_fo=0.000;

A_s=pi*d_t*L_t*N_t;
A_o=pi*d_t*L_t*N_t;
A_i=pi*d_t_in*L_t*N_t;

R_total=(1/(h_c_corregido*A_o))+(1/(h_t*A_i))+R_fo/A_o+R_fi/A_i;


U=1/(R_total*A_s);
NTU=(U*A_s)/C_min;

epsilon=2*(1+C_r+sqrt(1+C_r^2)*((1+exp(-NTU*sqrt(1+C_r^2)))/(1-exp(-NTU*sqrt(1+C_r^2)))))^-1;
epsilon2=(1-exp(-NTU*(1+C_r)))/(1+C_r);


Q_dot=epsilon*Q_dot_max;
T_h_out=T_h_in-Q_dot/C_h
T_c_out=T_c_in+Q_dot/C_c