%Constants // Static gains
Kcs = 0.5;
Kss = 0.0433;
Jtot = 7.226;
Ra = 1;
Kf = 0.1;
Kb = 2;
R = 0.0615;  %Ratio betwn r/itot
PRE = 0.6154;
Last = 1.8;

D = tf(Kf*1/R);
K_b = tf(Kb*1/R);
K_ss = tf(Kss*1/R);

G1 = tf(R, [Jtot,0]);
G2 = tf(PRE);

GD_2 = parallel(D,G2);

G3 = feedback(G1,GD_2);

G_Last = tf(Last);

G4 = series(G_Last,G3);

K_CS = Kcs/G4;

G5 = feedback(G4,K_b);
Ka_GTC = tf([10 6],[1 0]);
G6 = series(G5,Ka_GTC);

G7 = feedback(G6,K_CS);

Gsc = tf([100 40],[1 0]);
G8 = series(G7,Gsc);

system = feedback(G8,K_ss);

%Total System transfere function
SYSTEM_TF = tf(system)
