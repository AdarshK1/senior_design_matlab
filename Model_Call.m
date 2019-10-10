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
weight_of_battery = 2;

water_density = 1000; % 1 kg / m^3

% Conversion factors
conversion_mps_to_mph = 2.23694; % simple conversion from m/s to miles per hour
conversion_kgf_to_n = 9.80665;   % simple conversion from kgf to N
conversion_kg_to_lb = 2.2;
conversion_ft_to_m = 0.3048;

% Ranges we loop through
length_range = .5:.01:3.0;
width_range = .15:.01:.30;
height_range = .20:.01:.60;

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

height = 0.45;
width = 0.15;
length  = 0.69;

for height=height_range
    for width=width_range
        for length=length_range
        end
    end
end


