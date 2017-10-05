% This function returns an array of structs defined in addBody.m
% use initial conditions (IC) 0 if you want to let the user define the
% initial conditions in the command line
% use IC = 1 or 2 (with case 0 commented out) if you want to use your
% your own condition in the code. Add your own IC as desired

function [bodies] = initialConditions()
    IC = 2;
    % Case 0: Prompting user
    switch IC
        case 0
            N = input('Enter the number of celestial bodies: ');
            for ii=1:N
                fprintf('Celestial body #%i\n', ii);
                name = input('- Name: ', 's');
                mass = input('- Mass: ');
                radius = input('- Radius: ');
                position = input('- Enter initial position in the exact form [x y z] (WITH brackets)": ');
                velocity = input('- Enter initial velocity in the exact form [vx vy vz] (WITH brackets): ');
                bodies(ii) = addBody(name, mass, radius, position, velocity);
            end    
        case 1
            bodies(1) = addBody('A' , 10   , 120   , [200 800 700]    , [10 -25 40]);
            bodies(2) = addBody('B' , 150000   , 120   , [0 0 0]   , [0 -1 0]);
            bodies(3) = addBody('C' , 2.5    , 25   , [0 -2000 2000]     , [25 0 0]);
            bodies(4) = addBody('D' , 2.5    , 25   , [0 -2000 -2000]    , [25 0 0]);
            bodies(5) = addBody('E' , 5    , 50   , [400 0 0]    , [0 65 45]);
            bodies(6) = addBody('F' , 2.5    , 5   , [0 -1600 0]    , [-20 -15 -6]);
            bodies(7) = addBody('G' , 2.5    , 5   , [-2000 0 0]    , [0 0 -15]);
        case 2
            bodies(1) = addBody('A' , 8000   , 120   , [2000 0 0]    , [0 25 0]);
            bodies(2) = addBody('B' , 150000 , 220   , [0 0 0]   , [0 1 0]);
            bodies(3) = addBody('C' , 8000   , 120   , [-2000 0 0]    , [0 -43.75 0]);
    end
end

