%chk = CO.chk
%mem = 2GB
%nproc = 28
%CPU=0-27
%GPUCPU=0,1=0,1
# opt mp2/aug-cc-pvtz

CO_opt

0 1
C                 -1.96390968    0.77227951    0.06065306
O                 -1.58914316    1.28878476    0.97546973

