clear,clc
%membuka dokumen radargram hasil preprocessing
A=load('DATA400F.asc');
B=load('DATA200F.asc');

%normalisasi radargram 1
[ia,ja]=size(A);
for i=1:ia
    for j=1:ja
    An (i,j)= A(i,j)-(min(abs(A(:,j))));
    if An(i,j)<0
      An (i,j)= A(i,j)+(min(abs(A(:,j))));  
    end
    end
end
for i=1:ia
    for j=1:ja
    An1 (i,j)= An(i,j)./max(abs(An(:,j)));
    end
end

%normalisasi radargram 2
[ib,jb]=size(B);
for i=1:ib
    for j=1:jb
    Bn (i,j)= B(i,j)-(min(abs(B(:,j))));
    if Bn(i,j)<0
      Bn (i,j)= B(i,j)+(min(abs(B(:,j))));  
    end
    end
end
for i=1:ib
    for j=1:jb
    Bn1 (i,j)= Bn(i,j)./max(abs(Bn(:,j)));
    end
end
%definisi travel time
    tmin=0;
    tmax=90*1e-9;
    dt=0.04*1e-9;
    t=(0:dt:tmax);
%create the amplitude spectra
[a11,f1a]=fftrl(An1,t);
a22=abs(a11');
[b11,f1b]=fftrl(Bn1,t);
b22=abs(b11');
frek_amp_a=f1a./1e6;
frek_amp_b=f1b./1e6;


%normalise the amplitude spectra
%normalisasi radargram 1
[ax,ay]=size(a22);
for i=1:ax
    for j=1:ay
    a2 (i,j)= a22(i,j)-(min(abs(a22(:,j))));
    if a2(i,j)<0
      a2 (i,j)= a22(i,j)+(min(abs(a22(:,j))));  
    end
      end
end
for i=1:ax
    for j=1:ay
    a (i,j)= a2(i,j)./max(abs(a2(:,j)));
    end
end

%normalisasi radargram 2
[bx,by]=size(b22);
for i=1:bx
    for j=1:by
    b2 (i,j)= b22(i,j)-(min(abs(b22(:,j))));
    if b2(i,j)<0
      b2 (i,j)= b22(i,j)+(min(abs(b22(:,j))));  
    end
    end
end
for i=1:bx
    for j=1:by
    b (i,j)= b2(i,j)./max(abs(b2(:,j)));
    end
end

%analisis osw
dtn=tmax/(ax-1);
tp=tmin+((0:(ax-1))*dtn);
srcpulse = berlagepulse(200e6,tp,3,2,0);
figure(1)
plot(tp.*1e9,srcpulse)
%xlim([0 20])
title('Reference Model of Berlage Wavelet')
xlabel('Time (ns)')
ylabel('Normalised Amplitude')
xlim([0 90])
tbx=7/1e9;
%BOBOT OSW
[tpx,tpy]=size(tp);
aw=[];
bw=[];
tw=[];
for i=1:tpy
    if mod(tp(i),tbx)==0
     a1=a22(i,:);
     b1=b22(i,:);
     t1=[tp(i)];
     tw=[tw t1];
     aw=[aw ; a1];
     bw=[bw ; b1];
    end
end

[twx,twy]=size(tw);
bobot_all=[];
    for i=2:twy
    zt =[aw(i,:) ; bw(i,:)];
    z = zt';
    s=ones(size(z(:,1)));  
    w=(z'*z)*z'*s;
    m=w./rms(w);
    bobot_all=[bobot_all ; m];
    end
[bobot_all]=[1 ; 1 ; bobot_all];       
[bax,bay]=size(bobot_all);
bobot_200=[];
bobot_400=[];
for i=1:bax
    if mod(i,2)==0
        bobot_200_d=bobot_all(i);
        bobot_200=[bobot_200; bobot_200_d];
    else 
        bobot_400_d=bobot_all(i);
        bobot_400=[bobot_400; bobot_400_d];
    end
end
[box,boy]=size(bobot_400);
dtint=tmax/(box-1);
tint=tmin+((0:(box-1))*dtint);
%linear interpolation
b400=interp1(tint,bobot_400,tp,'linear','extrap');
b200=interp1(tint,bobot_200,tp,'linear','extrap');
wf_400=1./(b400./b200);
wf_200=1./(b200./b400);
hold all
figure(2)
g=plot(wf_200,tp.*1e9,wf_400,tp.*1e9)
g(1).LineWidth=2;
g(1).Marker='x';
g(2).LineWidth=2;
g(2).Marker='o';
axis ij
axis tight
legend('200 MHz', '400 MHz')
title('Variation of OSW Weighting Factor Through Time')
xlabel('Weighting Factor')
ylabel('Time(ns)')
%make the composite radargram
comp_400=[];
comp_200=[];
for i=1:tpy
    comp_400t=wf_400(i)*(Bn1(:,i))';
    comp_400=[comp_400 ; comp_400t];
    comp_200t=wf_200(i)*(An1(:,1))';
    comp_200=[comp_200 ; comp_200t];
end
comp=comp_200+comp_400;
figure(3)
imagesc(comp')

%save untuk dibaca di reflexw
compw=comp*1e3;
save oswm.asc compw -ascii