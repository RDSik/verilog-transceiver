clc
clear
x = [0:2*pi/256:2*pi-2*pi/256];
%%y = -sin(x) + 1;
y = sin(x) + 1;
y2 = y./max(y);
y3 = ceil(y2.*(2^12-1));

%%fid = fopen('neg_sin_val.dat', 'wb');
fid = fopen('sin_val.dat', 'wb');
if fid == -1
    error('File is not opened');
end

for i = 1:256
    fprintf(fid, '%s\n', dec2bin(y3(i), 12));
end

fclose(fid);
