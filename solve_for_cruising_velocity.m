function output=solve_for_cruising_velocity(u)
    alpha = u(1);
    beta = u(2);
    f_t = u(3);
    
    f_t_best = 0;
    v_best = 0;
    for v = 0:0.001:10
        f_t_test = beta * v^2 / (log10(alpha * v) - 2)^2;
        if abs(f_t_test-f_t) < abs(f_t_best-f_t)
            f_t_best = f_t_test;
            v_best = v;
        end
    end
    
    output = v_best;
    
end