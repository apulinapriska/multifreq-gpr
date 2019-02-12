clear,clc   

%definisi matriks radargram
    Al=load('D:\Dropbox\Le Thesis\Synthetic Model\model200banyak.mat','co_data');
    Bl=load('D:\Dropbox\Le Thesis\Synthetic Model\model400banyak.mat','co_data');
    tl=load('D:\Dropbox\Le Thesis\Synthetic Model\model200banyak.mat','tout');
    %ubah ke cell
    As=struct2cell(Al);
    Bs=struct2cell(Bl);
    ts=struct2cell(tl);
    %ubah ke matriks
    A=cell2mat(As);
    B=cell2mat(Bs);
    t=cell2mat(ts);
        
    An1=(1e7*A)';
    Bn1=(1e7*B)';
    %save to ascii
    save data200f.asc An1 -ascii
    save data400f.asc Bn1 -ascii