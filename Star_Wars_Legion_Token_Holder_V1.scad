// Box dimensions
box_x = 80;
box_y = 46;
box_z = 20;

// Pocket dimensions
pocket_radius = 21;
pocket_depth  = 17;

// Position
shield_x_wall = 15;
shield_y_wall = 10;

wound_x_wall = 40;
wound_y_wall = 10;

ion_x_wall = 65;
ion_y_wall = 0;

// Opposite side of holder
vehicle_x_wall = 30;
vehicle_y_wall = box_y-12;

commander_x_wall = 14;
commander_y_wall = box_y-10;

aim_x_wall = 64;
aim_y_wall = box_y-8;

ion_tri_length = 5;
niblet_length = 3.8;
module ion_tri_piece_1 () {
    translate([2, niblet_length, 0]){
       polygon(points=[
        [0, 0],        // Point A
        [ion_tri_length, 0],        // Point B
        [ion_tri_length/2, ion_tri_length/4]       // Point C
    ]); 
    }
}
module ion_point_niblet(){
    ion_tri_piece_1();
    mirror([0, 1, 0]){
        ion_tri_piece_1();
    }
    translate([2, -(niblet_length+0.01), 0]){
        square([ion_tri_length+0.3,((niblet_length * 2) + 0.02)]); //0.2 used here to connect triangles to square
    }    
}

module create_ion_token(){
    // ion Side length
    s = 23;
    // Height of ion equilateral triangle
    h = s * sqrt(3) / 2;
    //Start of the ion token creation. No, it can't be refactored
    union(){
        translate([0,(h/3)*2,0]){
            rotate([0,0,60]){
                translate([0,(h/3),0]){
                    union(){
                        translate([0,-(h/3)*1,0]){
                            rotate([0,0,60]){
                                translate([0,-((h/3)*2),0]){
                                    union(){
                                        //first niblet
                                        translate([0,-2,0]){
                                            rotate([0,0,90]){
                                                ion_point_niblet();
                                            }
                                        }
                                        
                                        //ion token base
                                        //rotate so we can align the niblets
                                        rotate([0,0,60]){ 
                                            polygon(points=[
                                            [0, 0],        // Point A
                                            [s, 0],        // Point B
                                            [s/2, h]       // Point C
                                            ]);
                                        }
                                    }
                                }
                            }
                        }
                        //second niblet
                        translate([0,-0.5,0]){
                            rotate([0,0,90]){
                                ion_point_niblet();
                            }
                        }
                    }
                }
            }
        }
        //third niblet
        translate([0,-2,0]){
            rotate([0,0,90]){
                ion_point_niblet();
            }
        }
    }
}

module create_vehicle_token(){
    //vehicle_tri_side
    vehicle_tri_height_from_base = 7.25;
    vehicle_tri_base_len = 18;
    vehicle_tri_square_height = 8.5;
    square([vehicle_tri_base_len,vehicle_tri_square_height+0.02]);
    mirror([0,1,0]){
        polygon(points=[
        [0, 0],        // Point A
        [vehicle_tri_base_len, 0],        // Point B
        [vehicle_tri_base_len/2, vehicle_tri_height_from_base]       // Point C
        ]);
    }
    translate([0,vehicle_tri_square_height,0]){
        polygon(points=[
            [0, 0],        // Point A
            [vehicle_tri_base_len, 0],        // Point B
            [vehicle_tri_base_len/2, vehicle_tri_height_from_base]       // Point C
            ]);
    }
}

module create_commander_token(){
    //Commander token
    polygon(points=[
        [12, 0],        // Point A
        [0, 12.3],        // Point B
        [-12.3, 0],       // Point C
        [-6.8, -12.8],       // Point D
        [6.3, -12.8],       // Point E
        ]);
}

module create_aim_token(){
    // Parameters
    side = 7.3;   // side length in mm
    n = 8;      // octagon

    // Circumradius calculation
    R = side / sqrt(2 - 2 * cos(360 / n));

    // Draw octagon
    polygon(points = [
        for (i = [0:n-1])
            [ R * cos(360/n * i),
              R * sin(360/n * i) ]
    ]);
}

difference() {
    // Outer box
    cube([box_x, box_y, box_z]);

    // Shield pocket
    union(){
        translate([shield_x_wall,
        shield_y_wall, box_z+0.1 - pocket_depth])
            cylinder(
                h = pocket_depth,
                d = pocket_radius,
                $fn = 64
            );
        translate([shield_x_wall-(pocket_radius*0.33),
        -0.01, box_z+0.1 - pocket_depth])linear_extrude(
        height=pocket_depth)square(
        [pocket_radius*0.66,4]);
    }
   // wound token pocket
   translate([wound_x_wall,
    wound_y_wall, box_z+0.1 - pocket_depth])
    linear_extrude(height=pocket_depth){
    union(){
        circle(d=16);
        wound_points = [[5.5, -5.5],
        [-5.5, 5.5],
        [9.0, 9.0]];
        
        polygon(points = wound_points);

        mirror([1,0,0]){
            polygon(points = wound_points);
        }
        mirror([0,1,0]){
            polygon(points = wound_points);
        }
        mirror([1,1,0]){
            polygon(points = wound_points);
        }
        translate([-8, -10.1, 0])square([16, 3]);
        }
    }
    //ion token pocket
    translate([ion_x_wall,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_ion_token();
            translate([-7,0])square([14,5]); //extra cutout for ion
        }    
    }
    //Create vehicle token
    translate([vehicle_x_wall,vehicle_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_vehicle_token();
        }    
    }
    
    //Create commander token
    translate([commander_x_wall,commander_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_commander_token();
        }    
    }
    
    //Create aim token
    translate([aim_x_wall,aim_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_aim_token();
            translate([-6,5])square([12,5]);
        }    
    }
}