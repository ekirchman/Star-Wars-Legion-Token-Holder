// Box dimensions
box_x = 120;
box_y = 46;
box_z = 20;

// Pocket dimensions
pocket_radius = 21;
pocket_depth  = 17;

// Position
shield_x_wall = 15;
shield_y_wall = 10;

wound_x_wall = 90;
wound_y_wall = 10;

ion_x_wall = 65;
ion_y_wall = 0;

obs_x_wall = 40;
obs_y_wall = 10;

surge_x_wall = 110;
surge_y_wall = 7;

// Opposite side of holder
vehicle_x_wall = 45;
vehicle_y_wall = box_y-16;

commander_x_wall = 14;
commander_y_wall = box_y-10;

aim_x_wall = 64;
aim_y_wall = box_y-8;

stby_x_wall = 85;
stby_y_wall = box_y-8;

sup_x_wall = 105;
sup_y_wall = box_y-8;

ion_tri_length = 6.5;
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
    scale([1.1,1.1])union(){
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
                        translate([0,-2,0]){
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
    vehicle_tri_base_len = 17;
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

module create_octogon(input_side){
    // Parameters
    side = input_side;   // side length in mm
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

module create_aim_token(){
    create_octogon(input_side=7.1);
}

module create_standby_token(){
    create_octogon(input_side=7.6);
}

module obs_arrow(){
    radius = 16;
    angle = 45;   // degrees

    polygon(points = concat(
        [[0,0]],
        [ for (a = [0:1:angle])
            [ radius * cos(a), radius * sin(a) ]
        ]
    ));
}

//observation token
module create_observation_token(){
    union(){
    obs_arrow();
    rotate([0,0,120]){
        union(){
            obs_arrow();
            rotate([0,0,120]){
                union(){
                    circle(r=9.25);
                    obs_arrow();
                    }
                }
            }
        }
    }
}

module sup_diff(){
    rect_len = 5;
    translate([2, -3.51, 0]){
        square([rect_len,7.02]); //0.2 used here to connect triangles
    }    
}

module sup_arrows(h){
    translate([-2,0,0])square([4,(h*(1/3))+2]);
}

module create_sup_token(){
    // ion Side length
    supression_s = 22;
    // Height of supression equilateral triangle
    supression_h = supression_s * sqrt(3) / 2;
   union(){
        sup_arrows(supression_h);
        rotate([0,0,120]){ 
            union(){
                sup_arrows(supression_h);
                rotate([0,0,120]){
                    union(){
                        sup_arrows(supression_h);
                        translate([0,-(supression_h/3)*2,0]){
                            difference(){
                                translate([0,(supression_h/3)*2,0]){
                                    rotate([0,0,60]){
                                        translate([0,(supression_h/3),0]){
                                            difference(){
                                                translate([0,-(supression_h/3)*1,0]){
                                                    rotate([0,0,60]){
                                                        translate([0,-((supression_h/3)*2),0]){
                                                            difference(){
                                                                
                                                                //ion token base
                                                                //rotate so we can align the niblets
                                                                rotate([0,0,60]){ 
                                                                    polygon(points=[
                                                                    [0, 0],        // Point A
                                                                    [supression_s, 0],        // Point B
                                                                    [supression_s/2, supression_h]       // Point C
                                                                    ]);
                                                                }
                                                                //first niblet
                                                                
                                                                translate([0,-5,0]){
                                                                    rotate([0,0,90]){
                                                                        sup_diff();
                                                                    }
                                                                }
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                                //second niblet
                                                translate([0,2,0]){
                                                    rotate([0,0,90]){
                                                        sup_diff();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                //third niblet
                                translate([0,-5,0]){
                                    rotate([0,0,90]){
                                        sup_diff();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module create_surge_token(){
    size = 15;     // square side length (mm)
    radius = 2;    // corner radius (mm)

    offset(r = radius)
    square(size - 2*radius, center=true);
}

//Create holder box
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
        rotate([0,0,90])linear_extrude(height=pocket_depth){
            create_vehicle_token();
        }    
    }
    
    //Create commander token
    translate([commander_x_wall,commander_y_wall-0.1,box_z+0.1- pocket_depth]){
        rotate([0,0,180])linear_extrude(height=pocket_depth){
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
    
    //Create observation token
    translate([obs_x_wall,obs_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,90])create_observation_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    
    //Create standby token
    translate([stby_x_wall,stby_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,90])create_standby_token();
            translate([-6,5])square([12,5]);
        }    
    }
    
    //Create supression token
    translate([sup_x_wall,sup_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_sup_token();
            translate([-6,5])square([12,5]);
        }    
    }
    
    //Create surge token
    translate([surge_x_wall,surge_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_surge_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    
}
/*
//Create surge token
    translate([surge_x_wall,surge_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            color("red")create_surge_token();
            //translate([-6,5])square([12,5]);
        }    
    }
*/