pw = 0.002;
pnw = notvalue(pw);
pu = 0.5;
pnu = notvalue(pu);
pt = 0.06;
pnt = notvalue(pt);
ps_wu = 0.3;
ps_nwu = 0.2;
ps_wnu = 0.07;
ps_nwnu = 0.02;
pa_t = 0.1;
pa_nt = 0.01;
pz_sa = 0.95;
pz_nsa = 0.90;
pz_sna = 0.40;
pz_nsna = 0.11;
x=0;
y=0;
z=0;
a=0;
b=0;
c=0;
d=0;
for i=1:1:10000
W = rand < pw;
U = rand < pu;
if (W == 1 && U == 1)
S = rand < ps_wu;
end
if (W == 0 && U == 1)
S = rand < ps_nwu;
end
if (W == 1 && U == 0)
S = rand < ps_wnu;
end
if (W == 0 && U == 0)
S = rand < ps_nwnu;
end
if (S==1)
    x=x+1;
    ps(x)=x/i;
end
T = rand < pt;
if (T == 1)
A = rand < pa_t;
end
if (T == 0)
A = rand < pa_nt;
end
if(S == 1 && A == 1)
    Z = rand <pz_sa;
end
if(S == 1 && A == 0)
    Z = rand <pz_sna;
end
if(S == 0 && A == 1)
    Z = rand <pz_nsa;
end
if(S == 0 && A == 0)
    Z = rand <pz_nsna;
end
if(Z==1)
    y=y+1;
end
if(Z==1 && U==1)
    z=z+1;
end
a=a+1;
pu_z(a)=z/y;
if(T==1 && Z==1)
    b=b+1;
end
if(U==1 && Z==1 && T ==1)
    c=c+1;
end
d=d+1;
pu_zt(d)=c/b;
end
disp('P(S) = ');
disp(ps(x));
disp('P(U|Z) = ');
disp(pu_z(a));
disp('P(U|Z,T) = ');
disp(pu_zt(d));
plot(ps);
hold on;
plot(pu_z);
hold on;
plot(pu_zt);
hold off;
function [notf] = notvalue(f) 
notf=1-f;
end