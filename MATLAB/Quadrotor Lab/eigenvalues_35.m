clc;
clear;
close all;

% define values for longitudinal
k1_lon = 0.001584;
k2_lon = 0.00288;
k3_lon = 0:0.1:100;
Iy = 7.2e-5;
g = 9.81;
k3_lon = -k3_lon * Iy;

% find eigenvalues for longitudinal
s = struct;
for i = 1:length(k3_lon)
matrix = [0, -g, 0; 0, 0, 1; (-k3_lon(i)/Iy), (-k2_lon/Iy), (-k1_lon/Iy)];
[s(i).v,s(i).d] = eig(matrix);
    for j = 1:3
    vec(i,j) = s(i).d(j,j);
    end
end

r = real(vec);
i = imag(vec);
figure()
subplot(2,1,1)
plot(r,i,'.')
title('Longitudinal Root Locus Plot')
xlabel('Real')
ylabel('Imaginary')

% define values for lateral
k1_lat = 0.001584;
k2_lat = 0.00288;
k3_lat = 0:0.1:100;
Ix = 5.8e-5;
g = 9.81;
k3_lat = -k3_lat * Ix;

% find eigenvalues for longitudinal
s = struct;
for i = 1:length(k3_lat)
matrix = [0, g, 0; 0, 0, 1; (-k3_lat(i)/Ix), (-k2_lat/Ix), (-k1_lat/Ix)];
[s(i).v,s(i).d] = eig(matrix);
    for j = 1:3
    vec(i,j) = s(i).d(j,j);
    end
end

r = real(vec);
i = imag(vec);
subplot(2,1,2)
plot(r,i,'.')
title('Lateral Root Locus Plot')
xlabel('Real')
ylabel('Imaginary')




