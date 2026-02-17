% Author(s): Nolan Harris, Raj Bhattarai
% Assignment title: Project 2, group component
% Purpose: 
% Creation date: 11/17/23
% Revisions:

clc;
clear;
close all;

%Load verification case
load('project2verification.mat');


%Call getConst
[const] = getConst();

%Find unknown initial conditions
    const.volAir0 = const.volB - const.volW; %Initial air volume
    const.mAirInitial = (const.p0*const.volAir0)/(const.R*const.T0); %Initial mass calculation for air
    const.mWater0 = const.rhoWater*const.volW; %Initial mass of water in bottle
    const.mAirSteady = const.rhoAir*const.volB; %Mass of air once all water is expelled and p = patm
    const.mRocket0 = const.mBottle+const.mWater0+const.mAirInitial; %Initial mass of rocket
    const.CrossSection = ((const.dBottle^2)*3.14159)/4; %Cross sectional area of bottle
    const.Tend = const.T0*((const.volAir0/const.volB)^(const.gamma-1)); %Find end temperature for depleted water
    const.Pend = const.p0*((const.volAir0/const.volB)^const.gamma); %Find end pressure for depleted water

%Call ode45 function for eom

    %Initialize State Vector
    X(1) = const.x0;
    X(2) = const.vx0;
    X(3) = const.z0;
    X(4) = const.vz0;
    X(5) = const.mRocket0;
    X(6) = const.volAir0;
    X(7) = const.mAirInitial;

    %Call ode45
    [t,x] = ode45(@(t,x) eom(t,x,const),const.tspan,X);

    %Store ode56 output in new variables 
    distance = x(:,1);
    velocityx = x(:,2);
    height = x(:,3);
    velocityz = x(:,4);
    mR = x(:,5);
    volA = x(:,6);
    mAir = x(:,7);

    %Call eom to find thrust
    Fthrust = size(t);
    p1 = size(t);
    p2 = size(t);
    for i = 1:length(t)
    [ddt,Fthrust(i),p1(i),p2(i)] = eom(t(i),x(i,:),const);
    end
    

%Find state vector
    for i = 1:length(t)
        if volA(i) < const.volB
            state1(i,:) = [t(i) distance(i)];
        elseif p2(i) > const.pAtm && volA(i) >= const.volB
            state2(i,:) = [t(i) distance(i)];
        elseif p2(i) <= const.pAtm && height(i)>= 0
            state3(i,:) = [t(i) distance(i)];
        elseif height(i) <= 0
            state4(i,:) = [t(i) distance(i)];
        end
    end

%Find intersection points

    %Find x coordinate of phase lines
    x1_distance = state1(end,2);
    x2_distance = state2(end,2);
    x3_distance = state3(end,2);
    x1_time = state1(end,1);
    x2_time = state2(end,1);
    x3_time = state3(end,1);

%Plot Trajectory
    figure()
    plot(distance,height,'LineWidth',1.5)
    hold on
    plot(verification.distance,verification.height,'LineStyle','--')
    xline(x1_distance,'Color',"#D95319",'LineWidth',1)
    xline(x2_distance,'color',"#77AC30",'LineWidth',1)
    xline(x3_distance,'Color',"#7E2F8E",'LineWidth',1)
    string1 = ['Phase 1 end = ' num2str(x1_distance), ' m'];
    string2 = ['Phase 2 end = ' num2str(x2_distance), ' m'];
    string3 = ['Phase 3 end = ' num2str(x3_distance), ' m'];
    xlabel('Distance (m)')
    ylabel('Height (m)')
    title('Trajectory')
    legend('Calculated Trajectory','Verification Case',string1,string2,string3)

%Plot Thrust vs Time
    figure()
    plot(t,Fthrust,'LineWidth',1.5)
    hold on
    plot(verification.time,verification.thrust,'LineStyle','--','LineWidth',1.5)
    xline(x1_time,'Color',"#D95319",'LineWidth',1)
    xline(x2_time,'color',"#77AC30",'LineWidth',1)
    xline(x3_time,'Color',"#7E2F8E",'LineWidth',1)
    string1 = ['Phase 1 end = ' num2str(x1_time), ' s'];
    string2 = ['Phase 2 end = ' num2str(x2_time), ' s'];
    string3 = ['Phase 3 end = ' num2str(x3_time), ' s'];
    t1 = text(20,10,string1);
    t2 = text(20,5,string2);
    t3 = text(20,0,string3);
    t1.FontSize = 10;
    t2.FontSize = 10;
    t3.FontSize = 10;
    xlabel('Time (s)')
    ylabel('Thrust (N)')
    title('Thrust vs Time')
    legend('Calculated Thrust','Verification Case',string1,string2,string3)
    xlim([0 0.5])

%Plot Velocities
    
    %Plot velocity in x direction
    figure()
    subplot(2,1,1)
    plot(t,velocityx,'LineWidth',1.5)
    hold on
    plot(verification.time,verification.velocity_x,'LineWidth',1.5,'linestyle','--')
    xline(x1_time,'Color',"#D95319",'LineWidth',1)
    xline(x2_time,'color',"#77AC30",'LineWidth',1)
    xline(x3_time,'Color',"#7E2F8E",'LineWidth',1)
    string1 = ['Phase 1 end = ' num2str(x1_time), ' s'];
    string2 = ['Phase 2 end = ' num2str(x2_time), ' s'];
    string3 = ['Phase 3 end = ' num2str(x3_time), ' s'];
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    title('Horizontal Velocity')
    legend('Horizontal Velocity','Verification Case',string1,string2,string3)
    hold off
    
    %Plot velocity in z direction
    subplot(2,1,2)
    plot(t,velocityz,'LineWidth',1.5,'Color',"#A2142F")
    hold on
    plot(verification.time,verification.velocity_y,'LineWidth',1.5,'LineStyle','--')
    xline(x1_time,'Color',"#D95319",'LineWidth',1)
    xline(x2_time,'color',"#77AC30",'LineWidth',1)
    xline(x3_time,'Color',"#7E2F8E",'LineWidth',1)
    string1 = ['Phase 1 end = ' num2str(x1_time), ' s'];
    string2 = ['Phase 2 end = ' num2str(x2_time), ' s'];
    string3 = ['Phase 3 end = ' num2str(x3_time), ' s'];
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    title('Vertical Velocity')
    legend('Vertical Velocity','Verification Case',string1,string2,string3)

%-------------------------------------------------------------------------%
function [ddt,Fthrust,p1,p2] = eom(t,X,const)

%Extract variables from state vector
    x = X(1);
    vx = X(2);
    z = X(3);
    vz = X(4);
    mR = X(5);
    volA = X(6);
    mAir = X(7);
        
    %find heading of rocket
    vh = sqrt((vx^2)+(vz^2));
    if z < const.lS*sind(const.theta0) + const.z0
        h = [cosd(const.theta0) sind(const.theta0)]; %Use initial angle to find heading
    else
        h = [vx/vh vz/vh]; %Use heading velocity to find components
    end

    %Pressure calculation for phases 1 and 2
    p1 = const.p0 * ((const.volAir0/volA)^const.gamma); %Find pressure
    p2 = const.Pend * ((mAir/const.mAirInitial)^const.gamma); %Find pressure


%Initialize variables
    dxdt = 0;
    dVxdt = 0;
    dzdt = 0;
    dVzdt = 0;
    dmRdt = 0;
    dvdt = 0;
    dmAdt = 0;

if volA<const.volB 
%Phase 1 calculations - Before water is exhausted
    dvdt = const.cDis * const.Athroat * sqrt( (2/const.rhoWater) * (const.p0 * ((const.volAir0/volA)^const.gamma) - const.pAtm)); %Find volume rate of change
    Ve = sqrt((2*(p1-const.pAtm))/const.rhoWater); %Find exit velocity
    mDotW = const.cDis*const.rhoWater*const.Athroat*Ve; %Find mass flow rate of water
    Fthrust = 2*const.cDis*const.Athroat*(p1-const.pAtm); %Find force of thrust 
    Drag = 0.5*const.rhoAir*(vh^2)*const.cD*const.CrossSection; %Find force of Drag
    Fnetx = Fthrust*h(1) - Drag*h(1); %Find net force in x direction
    Fnetz = Fthrust*h(2) - Drag*h(2) + mR*const.g; %Find net force in z direction
    ax = Fnetx/mR; %Find acceleration in x direction
    az = Fnetz/mR; %Find acceleration in z direction
    mDotA = 0; %Mass flow rate of air is zero 
    
%Derivative output
    dxdt = vx;
    dVxdt = ax;
    dzdt = vz;
    dVzdt = az;
    dmRdt = -mDotW;
    dmAdt = mDotA;

elseif p2 > const.pAtm && volA >= const.volB
%Phase 2 calculations - After water is exhausted
    rhoA = mAir/const.volB; %Find density of air in bottle
    T = p2/(rhoA*const.R); %Find temperature of air
    Pcrit = p2*((2/(const.gamma+1))^(const.gamma/(const.gamma-1))); %Define critical pressure

    if Pcrit>const.pAtm
    
        Te = T * (2/(const.gamma+1)); %Find exit temperature
        Ve = sqrt(const.gamma*const.R*Te); %Find exit velocity
        pExit = Pcrit; %exit pressure is equal to critical pressure
        rhoExit = (pExit/(const.R*Te)); %Find density of air on exit

    elseif Pcrit<const.pAtm

        Me = sqrt(( ((p2/const.pAtm)^((const.gamma-1) / const.gamma)) - 1) * (2 / (const.gamma-1)) ); %Find mach for non choked flow
        Te = (T / (1 + ((const.gamma-1) / 2) * Me^2 ) ); %Find exit temperature
        rhoExit = const.pAtm/(const.R*Te); %Find exit density
        pExit = const.pAtm; %Find exit pressure
        Ve = Me*sqrt(const.gamma*const.R*Te); %Find exit velocity

    end

    mDotA = const.cDis*rhoExit*const.Athroat*Ve; %Find mass flow rate for air
    Fthrust = mDotA*Ve + ((pExit-const.pAtm)*const.Athroat); %Find thrust force
    Drag = 0.5*const.rhoAir*(vh^2)*const.cD*const.CrossSection; %Find force of Drag
    Fnetx = Fthrust*h(1) - Drag*h(1); %Find net force in x direction
    Fnetz = Fthrust*h(2) - Drag*h(2) + mR*const.g; %Find net force in z direction
    ax = Fnetx/mR; %Find acceleration in x direction
    az = Fnetz/mR; %Find acceleration in z direction

%Derivative output
    dxdt = vx;
    dVxdt = ax;
    dzdt = vz;
    dVzdt = az;
    dmRdt = -mDotA;
    dvdt = 0;
    dmAdt = -mDotA;

elseif  p2 <= const.pAtm && z>= 0
%Phase 3 calculations - Ballistics
    mR = const.mBottle;
    Drag = 0.5*const.rhoAir*(vh^2)*const.cD*const.CrossSection; %Find force of Drag
    Fthrust = 0; %Thrust is zero in ballistics phase
    Fnetx = Fthrust*h(1) - Drag*h(1); %Find net force in x direction
    Fnetz = Fthrust*h(2) - Drag*h(2) + mR*const.g; %Find net force in z direction
    ax = Fnetx/mR; %Find acceleration in x direction
    az = Fnetz/mR; %Find acceleration in z direction

%Derivative output
    dxdt = vx;
    dVxdt = ax;
    dzdt = vz;
    dVzdt = az;
    dmRdt = 0;
    dvdt = 0;
    dmAdt = 0;

elseif z<=0
%Phase 4 - Hits ground

%Derivative output
    Fthrust = 0;
    dxdt = 0;
    dVxdt = 0;
    dzdt = 0;
    dVzdt = 0;
    dmRdt = 0;
    dvdt = 0;
    dmAdt = 0;

end

ddt = [dxdt;dVxdt;dzdt;dVzdt;dmRdt;dvdt;dmAdt]; %Output vector for ode45 integration
end
%-------------------------------------------------------------------------%
function [const] = getConst()
    %GETCONST returns all constants needed for the main file
    const.g = -9.807; %Acceleration due to gravity (m/s^2)
    const.cDis = 0.8; %Discharge coefficient
    const.rhoAir = 0.961; %Ambient air density (kg/m^3)
    const.volB = 0.002; %Volume of empty bottle (m^3)
    const.pAtm = 12.1*6895; %Atmospheric pressure (pa)
    const.gamma = 1.4; %Ratio of specific heats for air
    const.rhoWater = 1000; %Density of water (kg/m^3)
    const.dThroat = .021; %Diameter of throat (m)
    const.Athroat = const.dThroat^2 * (pi/4); %Area of throat (m^2)
    const.dBottle = .105; %Diameter of bottle (m)
    const.R = 287; %Specific gas constant for air (J/(kg*k))
    const.mBottle = 0.15; %Mass of empty bottle (kg)
    const.cD = 0.44; %Drag coeffient
    const.pg0 = 66*6895; %Initial guage pressure of air in bottle (pa)
    const.p0 = const.pg0 +const.pAtm; %Total pressure of air in bottle (pa)
    const.volW = 0.00085; %In itial volume of water in bottle (m^3)
    const.T0 = 300; %Initial temperature of air (k)
    const.vx0 = 0; %Initial horizontal velocity of water (m/s)
    const.vz0 = 0; %Initial vertical velocity of water (m/s)
    const.theta0 = 42.5; %Initial angle of rocket (degrees)
    const.x0 = 0; %Initial horizontal distance (m)
    const.z0 = 0.25; %Initial vertical distance (m)
    const.lS = 0.5; %Length of test stand (m)
    const.tspan = [0 5]; %Integration time span for ode45
end