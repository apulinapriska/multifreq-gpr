clear, clc, close all

%open pipe model

s=imread('modelpipa74.bmp');

%Convert ascii data into parameter value
d=s(:,:,1);
sz=size(d);
nx=sz(2);
nz=sz(1);
ep=zeros(nz,nx);
sig=zeros(nz,nx);
mu=zeros(nz,nx);

%create the ep parameter
for i=1:nx*nz
 if(d(i)==9) %soil
        ep(i)=16;
    else
        if(d(i)==0) %air
            ep(i)=1;
        else  if (d(i)==11) %concrete
            ep(i)=6;
            else
                ep(i)=3;    %casing
       end
    end
        end
end
%create the sigma parameter
for i=1:nx*nz
 if(d(i)==9) %soil
        sig(i)=0.005;
    else
        if(d(i)==0) %air-ground contact
            sig(i)=0;
        else  if (d(i)==11) %concrete
            sig(i)=0.01;
            else
                sig(i)=0.001;    %casing
       end
    end
        end
end
 %create the mu parameter
for i=1:nx*nz
    if(d(i)==9) %background
        mu(i)=1;
    else
        if(d(i)==0) %air-ground contact
            mu(i)=1;
        else 
           if (d(i)==11) %concrete
               mu(i)=1;
            else
                mu(i)=5;    %casing
end
    end
        end
end
%create dimensional matrix
panjang_x=5; 
panjang_z=5; %kedalaman
xStart = 0;
zStart = -0.5;
dx = panjang_x/(nx-1);
dz = panjang_z/(nz-1);
x = xStart + (0:nx-1)*dx;
z = zStart + (0:nz-1)*dz;

%transpose parameter
ep=ep';
sig=sig';
mu=mu';

    %save parameter
    save('parameter_modelbaru','ep','mu','sig','x','z')