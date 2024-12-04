clc
clear

x = [0:2*pi/256:2*pi-2*pi/256];
y1 = sin(x) + 1;
y2 = y1./max(y1);
y3 = ceil(y2.*(2^12-1));

fid1 = fopen('sin_val.dat', 'wb');
if fid1 == -1
    error('File is not opened');
end

for i = 1:256
    fprintf(fid1, '%s\n', dec2bin(y3(i), 12));
end

fclose(fid1);

y4 = -sin(x) + 1;
y5 = y4./max(y4);
y6 = ceil(y5.*(2^12-1));

fid2 = fopen('neg_sin_val.dat', 'wb');
if fid2 == -1
    error('File is not opened');
end

for i = 1:256
    fprintf(fid2, '%s\n', dec2bin(y6(i), 12));
end

fclose(fid2);
