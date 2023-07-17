function [K, theta, tau] = fo_Hagglund(time, output)
    y0 = abs(output(1));
    y_final = abs(output(end));
    y_632 = y0 + 0.632 * y_final;

    slope = diff(abs(output))./diff(time);
    max_slope = max(slope);
    max_slope_idx = find(slope >= max_slope , 1);
    yTangent = (time - time(max_slope_idx))*slope(max_slope_idx)+output(max_slope_idx);

    index_t1 = find(yTangent >= y0, 1);
    index_t2 = find(yTangent >= y_632, 1);

    t1 = time(index_t1);
    t2 = time(index_t2);

    K = y_final / 1;
    tau = t2 - t1;
    theta = t1;
    
    if theta < 0 
        theta = 0;
    end
end


