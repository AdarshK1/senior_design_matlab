function output=find_closest_height_for_given_area(area, height, width)
    area_best = 0;
    hw_best = 0;
    for hw = 0:0.01:height
        area_test = (height*width/4)*(acos(1-2*hw/height)-(1-2*hw/height)*sqrt(4*hw/height-4*hw^2/height^2));
        if abs(area_test-area) < abs(area_best-area)
            area_best = area_test;
            hw_best = hw;
        end
    end
    
    output = hw_best;
end