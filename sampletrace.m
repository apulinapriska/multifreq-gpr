clear, clc
%Perbandingan 5 versi radargram berdasarkan tracenya
%example = 
%trace 45 (casing pipa besar)
%trace 16 (zona kabel kiri)

comp1=load('DATA200F.asc')';
comp2=load('DATA400F.asc')';
comp3=load('doughertym.asc');
comp4=load('dfaem.asc');
comp5=load('oswm.asc');

%definisi travel time
    [ia,ja]=size(comp1)
    tmin=0;
    tmax=90;
    dt=tmax/(ja-1);
    dts=0.04;
    tp=tmin+((0:(ja-1))*dt);
    t=1e-9.*(0:dts:90);
    
    hold all
    figure(1)
    subplot(1,5,1)
    plot(comp1(45,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(a)')
    ylabel('Time (ns)')
    subplot(1,5,2)
    plot(comp2(45,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(b)')
    subplot(1,5,3)
    plot(comp3(45,:),t.*1e9)
    axis ij
    axis tight
    title('Trace Comparison on Trace 45')
     xlabel('(c)')
    subplot(1,5,4)
    plot(comp4(45,:),t.*1e9)
     axis ij
    axis tight
     xlabel('(d)')
    subplot(1,5,5)
    plot(comp5(45,:),t.*1e9)
   axis ij
    axis tight
     xlabel('(e)')
    
    hold all
    figure(2)
    subplot(1,5,1)
    plot(comp1(16,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(a)')
    ylabel('Time (ns)')
    subplot(1,5,2)
    plot(comp2(16,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(b)')
    subplot(1,5,3)
    plot(comp3(16,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(c)')
    title('Trace Comparison on Trace 16')
    subplot(1,5,4)
    plot(comp4(16,:),t.*1e9)
     axis ij
    axis tight
     xlabel('(d)')
    subplot(1,5,5)
    plot(comp5(16,:),t.*1e9)
    axis ij
    axis tight
     xlabel('(e)')
    
   