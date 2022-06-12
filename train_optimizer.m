% height_floor = 22.5;
% thickness_wall = 8;
% thickness_roof = 2.5;

% height_floor = 25.103;
% thickness_wall = 14;
% thickness_roof = 3.1118;

height_floor =  29.3;
thickness_wall = 21.9;
thickness_roof = 3.7;

% initial run to get the frequency
f_prev = train_analysis(10, height_floor, thickness_wall, thickness_roof)
f_prev_iter = f_prev;

relative_increment = 0.005;
max_increment = 0.01;

for ii = 1:400
  % optimize floor height
  height_floor_new = height_floor + min(max_increment, height_floor * relative_increment);
  f_new = train_analysis(10, height_floor_new, thickness_wall, thickness_roof)

  if f_new > f_prev * 1
    height_floor = height_floor_new
    f_prev = f_new
  endif
  
  % optimize wall height
  thickness_wall_new =thickness_wall + min(max_increment, thickness_wall * relative_increment);
  f_new = train_analysis(10, height_floor, thickness_wall_new, thickness_roof)

  if f_new > f_prev * 1
    thickness_wall = thickness_wall_new
    f_prev = f_new
  endif
  
  % optimize roof height
  thickness_roof_new = thickness_roof + min(max_increment, thickness_roof * relative_increment);
  f_new = train_analysis(10, height_floor, thickness_wall, thickness_roof_new)

  if f_new > f_prev * 1
    thickness_roof = thickness_roof_new
    f_prev = f_new
  endif
  
  if abs(f_prev - f_prev_iter) < 1e-15
    max_increment = max_increment / 2;
    disp("decreasing max increment"), disp(max_increment);
  endif
  
  f_prev_iter = f_prev;
  
  disp("iter "), disp(ii)
  disp("f "), disp(f_prev)
  disp("floor "), disp(height_floor)
  disp("wall "), disp(thickness_wall)
  disp("roof "), disp(thickness_roof)
endfor