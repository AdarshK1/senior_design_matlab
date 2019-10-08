function output=find_wetted_surface_area(u)
    hw = u(1);
    width = u(2);
    height = u(3);
    length = u(4);
    y = (height/2 - hw);
    x = ((width^2/4)*(1-(-2*y/height)^2))^(1/2);
    
    n = 2000;
    c = 2*x/n;
    sum = 0;
    for i = 1:n
        function_value_n = height / 2 * sqrt(1 - 4 * (-x + i * c)^2 / width^2);
        function_value_n_minus_one = height / 2 * sqrt(1 - 4 * (-x + (i - 1) * c)^2 / width^2);
       
        bit = sqrt((function_value_n - function_value_n_minus_one)^2 + c^2);
        sum = sum + bit;
    end
    
    output = sum * length;
    
end