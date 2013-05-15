#plik modelu

set DOSTAWCY;
set MAGAZYNY;
set ODBIORCY;
param e1 {DOSTAWCY,MAGAZYNY};
param e2 {DOSTAWCY,MAGAZYNY};
param e3 {DOSTAWCY,MAGAZYNY};
var x {DOSTAWCY,MAGAZYNY} >= 0;
param t1 {MAGAZYNY,ODBIORCY};
param t2 {MAGAZYNY,ODBIORCY};
param t3 {MAGAZYNY,ODBIORCY};
var z {MAGAZYNY,ODBIORCY} >= 0;
param w1 {DOSTAWCY,ODBIORCY};
param w2 {DOSTAWCY,ODBIORCY};
param w3 {DOSTAWCY,ODBIORCY};
var r {DOSTAWCY,ODBIORCY} >= 0;
param a {DOSTAWCY};
s.t. zp {k in DOSTAWCY}: (sum {m in MAGAZYNY} x[k,m]) + (sum {i in ODBIORCY} r[k,i]) <=  a[k];
param b {ODBIORCY};
s.t. zk {i in ODBIORCY}: (sum {k in DOSTAWCY} r[k,i]) + (sum {m in MAGAZYNY} z[m,i]) =  b[i];
param s {m in MAGAZYNY};
s.t. pm {m in MAGAZYNY}: (sum {k in DOSTAWCY} x[k,m]) <= s[m];
s.t. mag {m in MAGAZYNY}: (sum {k in DOSTAWCY} x[k,m]) = (sum {i in ODBIORCY} z[m,i]);
param N;
s.t. xN {k in DOSTAWCY, m in MAGAZYNY}: x[k,m] <= N * e1[k,m];
s.t. zN {m in MAGAZYNY, i in ODBIORCY}: z[m,i] <= N* t1[m,i];
s.t. rN {k in DOSTAWCY, i in ODBIORCY}: r[k,i] <= N * w1[k,i];
set Praw;
param P {y in Praw};
var f1 = (sum{k in DOSTAWCY, m in MAGAZYNY} x[k,m]*e1[k,m]) + (sum {m in MAGAZYNY, i in ODBIORCY} z[m,i] * t1[m,i]) + (sum {k in DOSTAWCY, i in ODBIORCY} r[k,i] * w1[k,i]);
var f2 = (sum{k in DOSTAWCY, m in MAGAZYNY} x[k,m]*e2[k,m]) + (sum {m in MAGAZYNY, i in ODBIORCY} z[m,i] * t2[m,i]) + (sum {k in DOSTAWCY, i in ODBIORCY} r[k,i] * w2[k,i]);
var f3 = (sum{k in DOSTAWCY, m in MAGAZYNY} x[k,m]*e3[k,m]) + (sum {m in MAGAZYNY, i in ODBIORCY} z[m,i] * t3[m,i]) + (sum {k in DOSTAWCY, i in ODBIORCY} r[k,i] * w3[k,i]);
var f = 0.2 * f1 + 0.2 * f2 + 0.6 * f3;
var f12p >= 0;
var f12n >= 0;
s.t. cf12: f1 - f2  = f12p - f12n;
var f23p >= 0;
var f23n >= 0;
s.t. cf23: f2 - f3  = f23p - f23n;
var f13p >= 0;
var f13n >= 0;
s.t. cf13: f1 - f3  = f13p - f13n;
var g = 2 * ((f12p + f12n) * 0.2 * 0.2 + (f23p + f23n) * 0.2 * 0.6 + (f13p + f13n) * 0.2 * 0.6);
minimize q: f  + g;
param wk;
param wr;
minimize h: wk * f + wr * g;
