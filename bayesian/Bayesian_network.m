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

pswu=ps_wu*pw*pu;
pswnu=ps_wnu*pw*pnu;
psnwnu=ps_nwnu*pnw*pnu;
psnwu=ps_nwu*pnw*pu;
ps=pswu+pswnu+psnwnu+psnwu;
pns = notvalue(ps);

pat = pa_t*pt;
pant = pa_nt*pnt;
pa = pat + pant;
pna = notvalue(pa);

pzsa = pz_sa*ps*pa;
pznsa = pz_nsa*pns*pa;
pzsna = pz_sna*ps*pna;
pznsna = pz_nsna*pns*pna;

pz=pzsa+pznsa+pzsna+pznsna;

pns_wu = notvalue(ps_wu);
pns_nwu = notvalue(ps_nwu);

pzsawu = pz_sa*ps_wu*pw*pu*pa;
pzsanwu = pz_sa*ps_nwu*pnw*pu*pa;
pzsnawu = pz_sna*ps_wu*pw*pu*pna;
pzsnanwu = pz_sna*ps_nwu*pnw*pu*pna;
pznsawu = pz_nsa*pns_wu*pw*pu*pa;
pznsanwu = pz_nsa*pns_nwu*pnw*pu*pa;
pznsnawu = pz_nsna*pns_wu*pw*pu*pna;
pznsnanwu = pz_nsna*pns_nwu*pnw*pu*pna;

pzu = pzsawu + pzsanwu + pzsnawu + pzsnanwu + pznsawu + pznsanwu + pznsnawu + pznsnanwu;

pu_z=pzu/pz;

pna_t = notvalue(pa_t);

pzsawut = pz_sa*pa_t*ps_wu*pw*pu*pt;
pzsanwut = pz_sa*pa_t*ps_nwu*pnw*pu*pt;
pzsnawut = pz_sna*pna_t*ps_wu*pw*pu*pt;
pzsnanwut = pz_sna*pna_t*ps_nwu*pnw*pu*pt;
pznsawut = pz_nsa*pa_t*pns_wu*pw*pu*pt;
pznsanwut = pz_nsa*pa_t*pns_nwu*pnw*pu*pt;
pznsnawut = pz_nsna*pna_t*pns_wu*pw*pu*pt;
pznsnanwut = pz_nsna*pna_t*pns_nwu*pnw*pu*pt;

pzut = pzsawut + pzsanwut + pzsnawut + pzsnanwut + pznsawut + pznsanwut + pznsnawut + pznsnanwut;

pzsat = pz_sa*pa_t*pt*ps;
pzsnat = pz_sna*pna_t*pt*ps;
pznsat = pz_nsa*pa_t*pt*pns;
pznsnat = pz_nsna*pna_t*pt*pns;
pzt = pzsat + pzsnat + pznsat + pznsnat;

pu_zt=pzut/(pzt);

disp('P(S) = ');
disp(ps);
disp('P(U|Z) = ');
disp(pu_z);
disp('P(U|Z,T) = ');
disp(pu_zt);
function [notf] = notvalue(f) 
notf=1-f;
end