clear;

%% Definition of constants for size calculations

% Material densities
density_of_cf = 1550; % kg/m^3
density_of_foam = 64.07; % kg / m^3
percent_of_hull_with_foam = 0.5;
thickness_of_cf = 0.003;

g = 9.81;
rho= 1030; %density of seawater

% Approximated weight of all static components
weight_of_junction_box = 2; % kg
weight_of_motors = 0.344 * 4; % kg
weight_of_other_electronics = 2; % kg: microcontroller, esc's, radio, imu, antennas

weight_of_electronics_total = weight_of_junction_box + weight_of_motors + weight_of_other_electronics; % kg
weight_of_frame = 3; % kg
weight_of_payload = 3; % kg
weight_of_battery_single = 2;

water_density = 1000; % 1 kg / m^3

% Conversion factors
conversion_mps_to_mph = 2.23694; % simple conversion from m/s to miles per hour
conversion_kgf_to_n = 9.80665;   % simple conversion from kgf to N
conversion_kg_to_lb = 2.2;
conversion_ft_to_m = 0.3048;

% Ranges we loop through
length_range = .6:.05:1.5;
width_range = .15:.05:.30;
height_range = .25:.05:.50;

%% Definition of constants for propulsion calculations

f_t = 2.48; % CHANGE LATER
water_viscosity = 0.001;


%% Definition of constants for impact calculations

% Calculates velocity at moment of impact
dropHeight = 15*conversion_ft_to_m;
V_impact = sqrt(2*g*dropHeight);

% Variables for impulse/momentum type calculation
delta_t = 0.1; %s

% Estimated impact area width/length
width_imp = 0.2;
length_imp = 0.2;

current_voltage = 12;
current_draw_1_motor = 8.9;
current_draw_2_motors = 2 * current_draw_1_motor; % [A] for 2 motor


% battery stuff
capacity_of_1_battery = 344; % [Wh]
max_current = 12; % [A]

electronics_power = 50; % [W]

% material properties for hull materials

% Note: ask Sarah where she got these numbers from
cfiber_compstrength=[1.15, 0.85, 0.69, 0.48, 0.45, 1.26, 0.81,0.74, ...
    0.82, 2.88, 2.76, 1.61, 1.06, 2.69, 2.33, 1.67, 3.22, 1.03];
%units= GPa
cfiber_tensilestrength = [1.38, 1.72, 2.07, 2.24, 2.24, 2.83, 3.10, ...
    3.31, 2.3, 3.24, 5.60, 2.41, 1.86, 3.64, 4.40, 3.80, 5.17, 2.62];
%units = GPa

% converting the carbon fiber tensile & compressive strength into Pascals

cfiber_compstrength = cfiber_compstrength.*1000000000;
cfiber_tensilestrength=cfiber_tensilestrength.*1000000000;

%fiber glass
fiberg_compstrength=[55000 , 65000, 50000, 65000, 63000];
fiberg_tensilestrength=[40500, 61600, 20000, 45000, 43000];
%units for the two above: psi

%converting to pascals
fiberg_compstrength=fiberg_compstrength.*6804.76; %unit=Pa
fiberg_tensilestrength=fiberg_tensilestrength.*6804.76; %unit=Pa



%% Loops through and calls simulink



% number of batteries
% thrust settings, every other number bw 1650 and 1900, only @ 12v
% thickness of material
% density of material
% foam percentages

battery_counts = 1:1:2;
load './Thruster_Data/12v_data.mat';
load './Thruster_Data/pwm_data.mat';

pwm_starts = 1752:16:1900;

% thrust_settings
thickness_of_materials = 0:0.001:0.008;
density_of_materials = 1400:50:1650;
percentages_of_hull_filled_w_foam = 0.30:0.1:1.0;

num_trials = length(length_range) * length(width_range) * length(height_range) * length(battery_counts) * length(pwm_starts) * length(thickness_of_materials) * length(density_of_materials) * length(percentages_of_hull_filled_w_foam);
disp(num_trials);

solution_matrix = []; %zeros(1, num_trials);
index = 1;
for pwm_start=pwm_starts
    for battery_count=battery_counts
        for thickness_of_material=thickness_of_materials
            for density_of_material=density_of_materials
                for percent_of_hull_with_foam=percentages_of_hull_filled_w_foam
                    for height=height_range
                        for width=width_range
                            for length=length_range
                                
                                thickness_of_cf = thickness_of_material;
                                density_of_cf = density_of_material;
                                capacity = battery_count * capacity_of_1_battery;
                                f_t = thrust_12v(pwm == pwm_start);
                                weight_of_battery = battery_count * weight_of_battery_single;
                                
                                out = sim('model_2018b_impact');
                                solution_matrix = [solution_matrix; height width length percent_of_hull_with_foam ...
                                    density_of_material thickness_of_material battery_count pwm_start f_t ...
                                    out.battery_life(5) out.cruising_velocity(5) ...
                                    out.height_best(5) out.max_stress_impulse(5) ...
                                    out.max_stress_paper(5) out.wetted_surface_area(5)];
%                                 solution_matrix(:, index) = [ height width length percent_of_hull_with_foam ...
%                                     density_of_material thickness_of_material battery_count pwm_start f_t ...
%                                     out.battery_life(5) out.cruising_velocity(5) ...
%                                     out.height_best(5) out.max_stress_impulse(5) ...
%                                     out.max_stress_paper(5) out.wetted_surface_area(5)];
                                
                                
                            end
                        end
                    end
                end
                writematrix(solution_matrix, "solutionmatrix.xlsx")
            end
        end
    end
end
writematrix(solutionmatrix, "solutionmatrix.xlsx")

