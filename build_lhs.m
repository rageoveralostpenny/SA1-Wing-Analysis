function lhsmat = build_lhs(xs,ys)
% xs is a vector of the edge of panel coordinates
    np = length(xs)-1;
    psip = zeros(np,np+1);
    lhsmat = zeros(np+1,np+1);
    
    % Build psi matrix
    % i loops over the panel edges at which psi is evaluated. There are np
    % such points

    % j loops over the end points of the panels which produce the
    % streamfunctions
    for i = 1:np
        for j = 1:np+1
            if j==1
                [fa fb] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xs(i),ys(i));
                psip(i,j)=fa;
            elseif j==np+1
                [faprev fbprev] = panelinf(xs(j-1),ys(j-1),xs(j),ys(j),xs(i),ys(i));
                psip(i,j)=fbprev;
            else
                [fa fb] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xs(i),ys(i));
                [faprev fbprev] = panelinf(xs(j-1),ys(j-1),xs(j),ys(j),xs(i),ys(i));
                psip(i,j)=fa+fbprev;
            end
        end
    end
    
    % Build A
    % A has a dimension of 101x101, i.e. np+1xnp+1
    lhsmat(1,1)=1;
    lhsmat(np+1,np+1)=1;

    for j=2:np+1
        lhsmat(1,j)=0;
    end

    for j=1:np
        lhsmat(np+1,j)=0;
    end

    for i=1:np-1
        lhsmat(i+1,:)=psip(i+1,:)-psip(i,:);
    end
end