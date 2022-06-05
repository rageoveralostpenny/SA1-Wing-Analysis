function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)
    % This function calculates the lift and drag forces on the airfoil
    
    % We define the several input variables:
    % circ - dimensionless circulation, GAMMA/U_c
    % cp - an array of pressure coefficients
    % delstarl - lower surface displacement thickness array
    % thetal - lower surface momentum thickness array
    % delstaru - upper surface displacement thickness array
    % thetau - upper surface momentum thickness array
    
    % Evaluate theta_inf
    theta_te = thetal(:) + thetau(:);
    delstar_te = delstarl(:) + delstaru(:);
    ue_te = sqrt(1-cp(:));
    H_te = delstar_te/theta_te;
    theta_inf = theta_te*(ue_te)^((H_te+5)/2);
    
    % Calculate cl and cd (lift and drag coefficients)
    cl = -2*circ;
    cd = 2*theta_inf;
end