function [K, theta, tau1, tau2] = so_Mollenkamp(time, output)
    y0 = abs(output(1));
    y_final = abs(output(end));

    y1 = y0 + 0.15 * y_final;
    y2 = y0 + 0.45 * y_final;
    y3 = y0 + 0.75 * y_final;

    index_y1 = find(abs(output) >= y1, 1);
    index_y2 = find(abs(output) >= y2, 1);
    index_y3 = find(abs(output) >= y3, 1);

    t1 = time(index_y1);
    t2 = time(index_y2);
    t3 = time(index_y3);

    K = y_final / 1;
    X = (t2 - t1) / (t3 - t1);
    zeta = (0.0805 - (5.547 * (0.475 - X)^2)) / (X - 0.356);
    zeta = abs(zeta);
    
    if zeta < 1
        f2 = (0.708) * (2.811)^zeta;
    else
        f2 = (2.6 * zeta) - 0.60;
    end
    
    wn = f2 / (t3 - t1);
    f3 = (0.922) * (1.66^zeta);
    theta = t2 - (f3 / wn);
    tau1 = (zeta + sqrt(zeta^2 - 1)) / wn;
    tau2 = (zeta - sqrt(zeta^2 - 1)) / wn;
end
