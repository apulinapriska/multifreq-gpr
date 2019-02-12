    clear,clc
    %membuka dokumen radargram hasil preprocessing
    A=load('DATA400F.asc');%frekuensi besar
    B=load('DATA200F.asc');%frekuensi kecil

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
    tmax=90;
    dt=tmax/(ja-1);
    dts=0.04;
    tp=tmin+((0:(ja-1))*dt);
    t=1e-9.*(0:dts:90);
    %create the amplitude spectra
    [a11,f1a]=fftrl(An1,t);
    a22=abs(a11);
    [b11,f1b]=fftrl(Bn1,t);
    b22=abs(b11);
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
      
    %DFAE method
    
    m400=(mean(a22,2));
    m200=(mean(b22,2));
    m1=max(mean(a22,2));
    m2=max(mean(b22,2));
    m=[m1 m2];
    w1=1/(m1/m2); %perbandingan amplitudo maks dgn amplitudo maks pada frekuensi terkecil
    w2=1;
    aw=w1*An1;
    bw=w2*Bn1;

    %gabungan radargram
    comp_1=An1+Bn1;
    comp_2=aw+bw;

    figure(1)
    plot(f1b./1e6,m200,f1a./1e6,m400)
    xlim([0 1000])
    xlabel('Frekuensi (MHz)')
    ylabel('Amplitudo')
    title ('Spektrum Amplitudo Rata-Rata Radargram')
    legend('200 MHz','400 MHz')
    hold all
    figure(2)
    imagesc(comp_1)
    axis ij
    figure(3)
    imagesc(comp_2)
    axis ij
    legend
    
    %save untuk dibaca di reflexw
compw1=(comp_1')*1e3;
compw2=(comp_2')*1e3;
save doughertym.asc compw1 -ascii
save dfaem.asc compw2 -ascii