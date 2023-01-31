clear
clc
close all
%asking the user to enter the inputs
sigma_c=input('Enter the conductivity of the waveguide metal: ');
epsilon_r=input('Enter the dielectric relative permittivity: ');
a=input('Enter a in meter: ');
b=input('Enter b in meter: ');
d=input('Enter d in meter: ');
loss_tangent=input('Enter the loss tangent: ');
v=(3*10^8)/sqrt(epsilon_r);
if a>d
disp('Not valid dimentions please re-enter another dimentions and make sure d>a>b:')
return
else
if(b>a||b>d)
disp('Not valid dimentions please re-enter another dimentions and make sure d>a>b:')
return
end
end
%calculating Fres,Q and BW for the dominant mode(TE101)
disp('The dominant mode is TE101')
f_res1=(v/2)*sqrt(((1/a)^2)+((1/d)^2));
k1=(2*pi*f_res1)/v;
mu=4*pi*10^-7;
eata=(120*pi)/sqrt(epsilon_r);
Rs1=sqrt((pi*f_res1*mu)/sigma_c);
Q_c1=(((k1*a*d)^3)*b*eata)/(2*(pi^2)*Rs1*(2*(a^3)*b+2*b*(d^3)+(a^3)*d+a*(d^3)));
Q_d=1/loss_tangent;
Q_tot1=(Q_c1*Q_d)/(Q_c1+Q_d);
BW_res1_abs=f_res1/Q_tot1;
BW_res1_frac=1/Q_tot1;
%checking which mode of TE011 and TE102 is the next mode by comparing
%kc^2 of both
kc_TE011=(pi/b)^2+(pi/d)^2;
kc_TE102=(pi/a)^2+(2*pi/d)^2;
if kc_TE011>kc_TE102
disp('The next mode is TE102')
%calculating Fres,Q and BW for the next mode(TE102)
f_res2=(v/2)*sqrt(((1/a)^2)+((2/d)^2));
k2=(2*pi*f_res2)/v;
Rs2=sqrt((pi*f_res2*mu)/sigma_c);
Q_c2=(((k2*a*d)^3)*b*eata)/(2*(pi^2)*Rs2*(8*(a^3)*b+2*b*(d^3)+4*(a^3)*d+a*(d^3)));
Q_tot2=(Q_c2*Q_d)/(Q_c2+Q_d);
BW_res2_abs=f_res2/Q_tot2;
BW_res2_frac=1/Q_tot2;
else
disp('The next mode is TE011')
%calculating Fres,Q and BW for the next mode(TE011)
f_res2=(v/2)*sqrt(((1/b)^2)+((1/d)^2));
epsilon_o=8.85*10^-12;
epsilon=epsilon_r*epsilon_o;
w=2*pi*f_res2;
beta=pi/d;
Rs2=sqrt((pi*f_res2*mu)/sigma_c);
denom=(((2*(beta^2)*(b^3)*a)/pi^2)+2*a*d+((beta^2)*(b^3)*d)/pi^2+b*d);
Q_c2=(epsilon*(w^3)*(mu^2)*(b^3)*d*a)/(2*(pi^2)*Rs2*denom);
Q_tot2=(Q_c2*Q_d)/(Q_c2+Q_d);
BW_res2_abs=f_res2/Q_tot2;
BW_res2_frac=1/Q_tot2;
end
fprintf('The value of the first resonance frequency is %.2f Ghz\n',f_res1/10^9)
fprintf('The value of the first quality factor is %.2f\n',Q_tot1)
fprintf('The value of the first absolute bandwidth is %d Ghz\n',BW_res1_abs/10^9)
fprintf('The value of the first fractional bandwidth is %d\n',BW_res1_frac)
fprintf('--------------------------------------------------------\n')
fprintf('The value of the next resonance frequency is %.2f Ghz\n',f_res2/10^9)
fprintf('The value of the next quality factor is %.2f\n',Q_tot2)
fprintf('The value of the next absolute bandwidth is %d Ghz\n',BW_res2_abs/10^9)
fprintf('The value of the next fractional bandwidth is %d\n',BW_res2_frac)











        
    

