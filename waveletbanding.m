clear,clc

%Analisis wavelet Blackman-Harris, Berlage, dan Ricker

f0=100e6;  %masukan frekuensi tengah (f0)
dt=1e-10;  %masukan selang waktu
tmax=3e-8; %masukan waktu maksimum dalam detik
t=0:dt:tmax; %masukan rentang waktu pemodelan wavelet
%Wavelet Blackman-Harris
p1=blackharrispulse(f0,t);
%Wavelet Berlage 
p2 = berlagepulse(f0,t,10,2,0);
%Wavelet Ricker
[p3,tw1]=ricker(dt,f0,tmax);

%plot perbandingan masing-masing wavelet
figure(1)
subplot(1,3,1)
plot(p1,t.*1e9)
axis ij
title('Blackman-Harris')
xlabel('Amplitude','FontSize',10)
ylabel('Time(ns)','FontSize',10)
subplot(1,3,2)
plot(p2,t.*1e9)
axis ij
title('Berlage')
xlabel('Amplitude','FontSize',10)
ylabel('Time(ns)','FontSize',10)
subplot(1,3,3)
plot(p3,t.*1e9)
axis ij
title('Ricker')
xlabel('Amplitude','FontSize',10)
ylabel('Time(ns)','FontSize',10)
