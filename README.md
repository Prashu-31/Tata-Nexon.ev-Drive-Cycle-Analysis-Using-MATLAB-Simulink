# ⚡ Tata Nexon.ev Drive Cycle Analysis Using MATLAB/Simulink

A MATLAB/Simulink-based electric vehicle simulation project that analyzes urban driving speed–time characteristics and estimates the road-load forces, traction motor power, and inverter power requirements of a Tata Nexon.ev reference vehicle.

## 📌 Project Overview

Electric vehicle motor and inverter sizing depends on driving conditions, vehicle speed, acceleration, road resistance, and drivetrain efficiency.

This project uses speed measurements collected during an urban drive cycle to calculate vehicle forces and estimate the mechanical and electrical power requirements throughout the trip.

The model is implemented using MATLAB and Simulink and generates speed, force, and power plots for analysis.

## 🎯 Objectives

- Analyze vehicle speed versus time using drive-cycle data.
- Calculate vehicle acceleration from speed measurements.
- Estimate rolling resistance and aerodynamic drag.
- Calculate acceleration force and total tractive force.
- Estimate wheel power and motor mechanical power.
- Estimate the inverter's DC input power.
- Visualize the simulation results using MATLAB and Simulink.

## 🚗 Reference Vehicle

**Vehicle:** Tata Nexon.ev

The vehicle is used as a reference for the road-load and power estimation model. Some parameters are assumed for simulation purposes and should not be interpreted as verified manufacturer specifications.

| Parameter | Value |
|---|---:|
| Vehicle mass | 1400 kg (provisional model value) |
| Gravitational acceleration | 9.81 m/s² |
| Rolling resistance coefficient | 0.011 |
| Aerodynamic drag coefficient | 0.29 |
| Frontal area | 2.35 m² |
| Air density | 1.225 kg/m³ |
| Drivetrain efficiency | 90% |
| Motor efficiency | 92% |
| Inverter efficiency | 97% |
| Road gradient | 0% (flat road assumed) |

**Note:** The mass, aerodynamic parameters, rolling resistance coefficient, and efficiencies are model assumptions. Replace them with verified values for the exact vehicle variant when available.

## 📊 Drive Cycle Data

The model uses six speed measurements taken at 60-second intervals.

| Time (s) | Speed (km/h) |
|---:|---:|
| 60 | 6 |
| 120 | 20 |
| 180 | 29 |
| 240 | 50 |
| 300 | 31 |
| 360 | 8 |

A starting point of 0 seconds and 0 km/h is assumed in the simulation.

The input data is interpolated between measurements to create the speed profile used by Simulink. Because the sampling interval is relatively large, short acceleration and braking events may not be captured accurately.

## ⚙️ Mathematical Model

### 1. Speed Conversion

Convert speed from km/h to m/s:

\[
v=\frac{v_{\mathrm{km/h}}}{3.6}
\]

### 2. Acceleration

\[
a=\frac{\Delta v}{\Delta t}
\]

### 3. Rolling Resistance Force

\[
F_{\mathrm{roll}}=C_{rr}mg
\]

### 4. Aerodynamic Drag Force

\[
F_{\mathrm{drag}}=\frac12\rho C_dAv^2
\]

### 5. Acceleration Force

\[
F_{\mathrm{acc}}=ma
\]

### 6. Total Tractive Force

For a flat road:

\[
F_{\mathrm{total}}=
F_{\mathrm{roll}}+
F_{\mathrm{drag}}+
F_{\mathrm{acc}}
\]

### 7. Wheel Power

\[
P_{\mathrm{wheel}}=F_{\mathrm{total}}v
\]

### 8. Motor Mechanical Power

For motoring operation:

\[
P_{\mathrm{motor}}=
\frac{\max(P_{\mathrm{wheel}},0)}{\eta_d}
\]

### 9. Inverter DC Input Power

\[
P_{\mathrm{inverter}}=
\frac{P_{\mathrm{motor}}}{\eta_m\eta_{\mathrm{inv}}}
\]

Where:

- \(m\): vehicle mass
- \(g\): gravitational acceleration
- \(C_{rr}\): rolling resistance coefficient
- \(C_d\): aerodynamic drag coefficient
- \(A\): frontal area
- \(\rho\): air density
- \(v\): vehicle speed
- \(a\): vehicle acceleration
- \(\eta_d\): drivetrain efficiency
- \(\eta_m\): motor efficiency
- \(\eta_{\mathrm{inv}}\): inverter efficiency

Power is calculated in watts and can be converted to kilowatts by dividing by 1000.

## 🧱 Simulink Model Architecture

The model follows this signal flow:

```text
Drive Cycle Data
      |
      v
From Workspace
      |
      +----------------------+
      |                      |
      v                      v
  Derivative          Speed Input
      |                      |
      v                      |
 Acceleration                |
      |                      |
      +----------+-----------+
                 |
                 v
         MATLAB Function
         (Vehicle Dynamics)
                 |
                 v
         Force and Power
            Outputs
                 |
                 v
                Mux
                 |
                 v
               Scope
```

### Model Outputs

1. Rolling resistance force (N)
2. Aerodynamic drag force (N)
3. Acceleration force (N)
4. Total tractive force (N)
5. Motor mechanical power (W)
6. Inverter DC input power (W)

## 📈 Simulation Results

The simulation produces two main categories of results:

### Speed–Time Characteristics

The speed–time plot represents the urban driving cycle, with speed increasing to 50 km/h before decreasing toward the end of the trip.

### Force and Power Characteristics

The Simulink output plot shows how the forces and power requirements change during the drive cycle.

From the displayed simulation graph, the approximate peak values are:

| Output | Approximate value |
|---|---:|
| Peak motor mechanical power | 5.5 kW |
| Peak inverter DC input power | 6.2 kW |

These values are approximate readings from the submitted plots, not independently verified exact maxima.

## 🧮 Steady-Speed Calculation at 50 km/h

For a reference calculation at constant speed:

\[
v=\frac{50}{3.6}=13.889\text{ m/s}
\]

Rolling resistance:

\[
F_{\mathrm{roll}}=0.011(1400)(9.81)
\]

\[
F_{\mathrm{roll}}\approx151.07\text{ N}
\]

Aerodynamic drag:

\[
F_{\mathrm{drag}}=
\frac12(1.225)(0.29)(2.35)(13.889)^2
\]

\[
F_{\mathrm{drag}}\approx80.52\text{ N}
\]

Total tractive force at constant speed:

\[
F_{\mathrm{total}}=151.07+80.52
\]

\[
F_{\mathrm{total}}\approx231.59\text{ N}
\]

Wheel power:

\[
P_{\mathrm{wheel}}=231.59(13.889)
\]

\[
P_{\mathrm{wheel}}\approx3.22\text{ kW}
\]

Motor mechanical power:

\[
P_{\mathrm{motor}}=\frac{3.22}{0.90}
\]

\[
P_{\mathrm{motor}}\approx3.58\text{ kW}
\]

Inverter DC input power:

\[
P_{\mathrm{inverter}}=
\frac{3.58}{0.92(0.97)}
\]

\[
P_{\mathrm{inverter}}\approx4.01\text{ kW}
\]

These are steady-speed estimates on a flat road, not the instantaneous power at the 240-second measurement.

## 🛠️ Tools and Technologies

- MATLAB
- Simulink
- Excel drive-cycle data
- Vehicle dynamics and road-load equations
- Electric vehicle powertrain analysis

## 🚀 How to Run the Project

1. Install MATLAB with Simulink.
2. Clone or download this repository.
3. Place `Drive_Cycle.xlsx` in the MATLAB working directory.
4. Run the MATLAB data preparation script, if included.
5. Open the Simulink model (`.slx` file).
6. Confirm the input variable name and simulation stop time.
7. Run the simulation.
8. Open the Scope blocks to inspect the force and power outputs.
9. Save the resulting graphs for analysis.

**Important:** The Excel file, MATLAB scripts, and `.slx` model must be included in the repository for these instructions to work as written.

## ⚠️ Limitations

- The drive cycle contains only six measurements at 60-second intervals.
- The initial stationary point is assumed.
- Some vehicle parameters are provisional assumptions.
- The model assumes constant efficiencies and a flat road.
- Regenerative braking is not modelled; negative wheel power is clipped to zero.
- Battery voltage variation, auxiliary loads, motor torque-speed limits, inverter switching losses, and thermal limits are not included.
- Estimated power values should not be treated as final motor or inverter ratings.

## 🔮 Future Improvements

- Collect higher-resolution GPS speed data.
- Use verified variant-specific vehicle specifications.
- Include road-gradient and wind effects.
- Model regenerative braking.
- Add motor torque-speed limits and battery voltage/current calculations.
- Include inverter conduction and switching losses.
- Compare the simulation against a standard EV drive cycle.
- Develop a more detailed Simscape Electrical powertrain model.

## 🎓 Applications

- Electric vehicle road-load analysis
- Traction motor power estimation
- Inverter power requirement estimation
- MATLAB/Simulink vehicle modelling
- Electrical and Electronics Engineering academic projects

## 👨‍💻 Author

**Prashanth H**  
Electrical and Electronics Engineering  
PES College of Engineering, Mandya

## 📄 License

This project is intended for educational and academic purposes. Add an appropriate open-source license if you want others to reuse or modify the project.

---

*This project demonstrates how urban driving speed data can be used to estimate electric vehicle road-load forces and power demand using MATLAB and Simulink.*
