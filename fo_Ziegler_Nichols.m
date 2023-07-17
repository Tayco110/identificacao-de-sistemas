function [K, theta, tau] = fo_Ziegler_Nichols(time, output)
    y0 = abs(output(1));
    y_final = abs(output(end));

    slope = diff(abs(output))./diff(time);
    max_slope = max(slope);
    max_slope_idx = find(slope >= max_slope , 1);
    yTangent = (time - time(max_slope_idx))*slope(max_slope_idx)+output(max_slope_idx);

    index_t1 = find(yTangent >= y0, 1);
    index_t3 = find(yTangent >= y_final, 1);

    t1 = time(index_t1);
    t3 = time(index_t3);

    K = y_final / 1;
    tau = t3 - t1;
    theta = t1;
    if theta < 0 
        theta = 0;
    end
end


