% Definition of all constants

% Material densities 
density_of_cf = 1550; % kg/m^3
density_of_foam = 64.07; % kg / m^3
percent_of_hull_with_foam = 0.5;
thickness_of_cf = 0.003;

g = 9.81;

% Approximated weight of all static components
weight_of_junction_box = 2; % kg
weight_of_motors = 0.344 * 4; % kg
weight_of_other_electronics = 2; % kg: microcontroller, esc's, radio, imu, antennas 

weight_of_electronics_total = weight_of_junction_box + weight_of_motors + weight_of_other_electronics; % kg
weight_of_frame = 3; % kg
weight_of_payload = 4.5; % kg
weight_of_battery = 2;

water_density = 1000; % 1 kg / m^3

% Conversion factors
conversion_mps_to_mph = 2.23694; % simple conversion from m/s to miles per hour
conversion_kgf_to_n = 9.80665;   % simple conversion from kgf to N
conversion_kg_to_lb = 2.2;

% Ranges we loop through
length_range = .5:.01:3.0;
width_range = .15:.01:.30;
height_range = .20:.01:.60;

f_t = 2.48; % CHANGE LATER
water_viscosity = 0.001;

% Loops through iterations to calculate weight based on material usage, as
% well as draft
solutionmatrix = [];

height = 0.45;
width = 0.15;
length  = 0.69;

for height=height_range
    for width=width_range
        for length=length_range
        end
    end
end


