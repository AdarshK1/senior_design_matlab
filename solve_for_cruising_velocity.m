function output=solve_for_cruising_velocity(u)
    alpha = u(1);
    beta = u(2);
    f_t = u(3);
    
    syms v;
    
    soln = vpasolve(f_t == beta * v^2 / (log10(alpha * v) - 2)^2, v);
    
    output = double(soln);

end