
clc;
clear;
close all;

% Read the Excel file
T = readtable('Drive_Cycle.xlsx');

% Use the six measurement rows, excluding the Avg row
time_s = T{1:6, 2};
speed_kmh = T{1:6, 3};

% Convert km/h to m/s
speed_ms = speed_kmh / 3.6;

% Add starting point, assuming the vehicle starts from rest
time_s = [0; time_s];
speed_ms = [0; speed_ms];

% Create the signal for Simulink
speed_ts = timeseries(speed_ms, time_s);

% Vehicle parameters
m = 1400;       % Mass in kg (provisional)
g = 9.81;       % Gravity in m/s^2
Crr = 0.011;    % Rolling resistance coefficient
Cd = 0.29;      % Assumed drag coefficient
A = 2.35;       % Assumed frontal area in m^2
rho = 1.225;    % Air density in kg/m^3

% Efficiency assumptions
eta_drive = 0.90;
eta_motor = 0.92;
eta_inv = 0.97;

% Display the speed-time graph
figure;
plot(time_s, speed_ms*3.6, 'o-', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Speed (km/h)');
title('Tata Nexon.ev Drive Cycle');

disp('Drive cycle loaded successfully.');
