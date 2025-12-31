use <Token_Shapes.scad>;

// Box dimensions
box_x = 145;
box_y = 46;
box_z = 20;

// Pocket dimensions
pocket_radius = 21;
pocket_depth  = box_z - 3;

// Position
shield_x_wall = 12;
shield_y_wall = 10;

wound_x_wall = 90;
wound_y_wall = 10;

ion_x_wall = 65;
ion_y_wall = 0;

old_obs_x_wall = 36;
old_obs_y_wall = 10;

surge_x_wall = 110;
surge_y_wall = 7;

// Opposite side of holder
vehicle_x_wall = 45;
vehicle_y_wall = box_y-16;

commander_x_wall = 14;
commander_y_wall = box_y-12;

aim_x_wall = 64;
aim_y_wall = box_y-8;

stby_x_wall = 85;
stby_y_wall = box_y-8;

sup_x_wall = 105;
sup_y_wall = box_y-8;

sup_x_wall2 = sup_x_wall+25;
sup_y_wall2 = box_y-8;

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
    translate([old_obs_x_wall,old_obs_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,90])create_old_observation_token();
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
    
    //Create 2nd supression token
    translate([sup_x_wall2,sup_y_wall2-0.1,box_z+0.1- pocket_depth]){
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
