function ShaftModelData=CrtShaftModel(ShaftData)
%% Script Information 
%--------------------------------------------------------------------------
% 20181011 Rotor Dynamic Torsional Vibration
%  writen by atz8
%  ref. [1].Zhang Wen.Basic of Rotar Dynamic M.Science Press.1995
%        [2].Tang Xikuan. Dynamic of Machinery M.Higher Eudcation Press.1984
%--------------------------------------------------------------------------
% Output Parameter Description
% ShaftModelData 
% Input Parameter Description
% ShaftData
%--------------------------------------------------------------------------
% Calculate Moment of Inertia J < Format of LaTeX >
%    J=\smallint r^{2}dm
%    where dm=2{\pi} \rho r^{2}dr
%    dJ=2{\pi}\rho r^{3}dr
%    J=\int _{R_{i}}^{R_{e}} 2{\pi} \rho r^{3}dr
%    J=\frac12 m(R_{e}^{2}-R_{i}^{2})
%
% Calculate Section Modulus in Torsion W_{p} < Format of LaTeX >
%    W_{p}=\frac{{\pi}D^{4}}{32}(1-{\alpha^{4}})
%    where {\alpha}=(1-\frac{d}{D})
% 
% Calculate Torsional Stiffness K_{t} <Format of LaTeX>
%    K_{t}=GI_{p}
%    where G=\frac{E}{2*(1+{\mu})}
%--------------------------------------------------------------------------
% Basic Parameters 
ExRadius=ShaftData(:,1);    % Shaft InRadius 
InRadius=ShaftData(:,2);  % Shaft ExRadius
ShaftSectionLen=ShaftData(:,3);  %Shaft Section Length
ShaftSectionRho=ShaftData(:,4);   %Shaft Section Density
ShaftSectionE=ShaftData(:,5);     %Modulus of elasticity
ShaftSectionMu=ShaftData(:,6);    %Poisson Ratio
% Calculate Parameters
ShaftNum=length(ShaftSectionLen); % Number of Shaft Segments
G_i=zeros(ShaftNum,1);    % Shear Modulus
Wp_i=zeros(ShaftNum,1);   % Section Modulus in Torsion
Ip_i=zeros(ShaftNum,1);   % Polar Moment of Inertia
J_i=zeros(ShaftNum,1);    % Moment of Inertia
K_i=zeros(ShaftNum,1);    % Stiffness Vector

% M_i=zeros(ShaftNum,1);

for c=1:ShaftNum
    G_i(c)=ShaftSectionE/(2*(1+ShaftSectionMu(c)));
%     J_i(c)=(pi*(ExRadius(c)^4-InRadius(c)^4))*ShaftSectionLen(c)*ShaftSectionRho(c)/32;
    J_i(c)=(pi/32)*ShaftSectionRho(c)*ShaftSectionLen(c)*(ExRadius(c)^4-InRadius(c)^4);

    Wp_i(c)=(pi*(ExRadius(c)^4)/16)*(1-InRadius(c)^4/ExRadius(c)^4);
    Ip_i(c)=(pi*ExRadius(c)^4/32)*(1-InRadius(c)^4/ExRadius(c)^4);    
    K_i(c)=(pi/180)*G_i(c)*Ip_i(c)/ShaftSectionLen(c);  % Unit N*m/Deg
end

ShaftModelData=[J_i,K_i];

% figure
% for c=1:ShaftNum
%     hr=plot([0.5*ShaftSectionLen(c),-0.5*ShaftSectionLen(c)],[InRadius(c),InRadius(c)]);
%    
% end
% for c=1:ShaftNum
%     hl1=plot(0.5*[0,ShaftSectionLen(c)],0.5*[0.5*InRadius(c),0.5*InRadius(c)]);
%     hl2=plot([ShaftSectionLen(c),ShaftSectionLen(c+1)],[-0.5*InRadius(c),-0.5*InRadius(c)]);
%     
% end



