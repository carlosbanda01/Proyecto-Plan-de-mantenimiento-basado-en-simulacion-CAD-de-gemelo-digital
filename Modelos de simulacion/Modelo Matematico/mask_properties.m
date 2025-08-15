temp_vector=273.16:5:373.16;
density_vector=[999.8 999.9 999.7 999.1 998.0 997.0 996.0 994.0 992.1 990.1 988.1 985.2 983.3 980.4 977.5 974.7 971.8 968.1 965.3 961.5 957.9];
cp_vector=[4217 4205 4194 4186 4182 4180 4178 4178 4179 4180 4181 4183 4185 4187 4190 4193 4197 4201 4206 4212 4217];
k_vector = [0.56 0.571 0.580 0.589 0.598 0.607 0.615 0.623 0.631 0.637 ...
            0.644 0.649 0.654 0.659 0.663 0.667 0.670 0.673 0.675 0.677 ...
            0.679];

mu_vector = [1.792e-3 1.519e-3 1.307e-3 1.138e-3 1.002e-3 ...
             0.891e-3 0.798e-3 0.720e-3 0.653e-3 0.596e-3 ...
             0.547e-3 0.467e-3 0.467e-3 0.433e-3 0.404e-3 ...
             0.378e-3 0.355e-3 0.333e-3 0.315e-3 0.297e-3 ...
             0.282e-3];
v_vector=mu_vector./density_vector;
pr_vector = [13.5 11.2 9.45 8.09 7.01 6.14 5.42 4.83 ...
             4.32 3.91 3.55 3.25 2.99 2.75 2.55 2.38 ...
             2.22 2.08 1.96 1.85 1.75];

% Temperatura a interpolar
fluid_temp = 92.5+273.15;

% Interpolación
fluid_density = interp1(temp_vector, density_vector, fluid_temp);
fluid_cp = interp1(temp_vector, cp_vector, fluid_temp);
fluid_k = interp1(temp_vector, k_vector, fluid_temp);
fluid_v = interp1(temp_vector, v_vector, fluid_temp);
fluid_pr = interp1(temp_vector, pr_vector, fluid_temp);

% Mostrar el resultado
%fprintf('La densidad a %.2f K es %.2f kg/m^3\n', temp_query, density_query);