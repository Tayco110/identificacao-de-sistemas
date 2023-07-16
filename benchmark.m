function benchmark(time, output, G)
    est_output = step(G, time);
    mse(output, est_output);
    iae(output, est_output);
    ise(output, est_output);
    itae(output, est_output, time);
end

function mse(real_output, predicted_output)
    if numel(real_output) ~= numel(predicted_output)
        error('Input vectors must have the same size');
    end
    mse = sum((real_output - predicted_output).^2) / numel(real_output);
    disp(['Mean Squared Error (MAE): ', num2str(mse)]);
end

function iae(real_output, predicted_output)
    if numel(real_output) ~= numel(predicted_output)
        error('Input vectors must have the same size');
    end
    iae = sum(abs(real_output - predicted_output));
    disp(['Integral Absolute Error (IAE): ', num2str(iae)]);
end

function ise(real_output, predicted_output)
    if numel(real_output) ~= numel(predicted_output)
        error('Input vectors must have the same size');
    end
    ise = sum((real_output - predicted_output).^2);
    disp(['Integral Square Error (ISE): ', num2str(ise)]);
end

function itae(real_output, predicted_output, time)
    if numel(real_output) ~= numel(predicted_output)
        error('Input vectors must have the same size');
    end
    itae = sum((time .* abs(real_output - predicted_output)));
    disp(['Integral Time Absolute Error (ITAE): ', num2str(itae)]);
end
