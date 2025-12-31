//Version 2.0
use <Token_Shapes.scad>;

// Box dimensions
box_x = 195;
box_y = 46;
box_z = 10;

box_rad = 70;

// Pocket dimensions
shield_pocket_radius = 21;
pocket_depth  = box_z - 3;

//6mmx2mm magnets
magnet_d = 7;
magnet_h = 2;

// Position
shield_x_wall = -20;
shield_y_wall = -box_rad+shield_pocket_radius;

wound_circle_size= 16; //This is reflected in Token_Shapes.scad
wound_square_size = 3; //This is reflected in Token_Shapes.scad
wound_x_wall = 0;
wound_y_wall = -box_rad+wound_circle_size+wound_square_size;

ion_side = 23; //reflected in Token_Shapes.scad
ion_x_wall = 23;
ion_y_wall = -box_rad+(ion_side/2)-3;

old_obs_x_wall = -14;
old_obs_y_wall = -box_rad+(9.2*2)+2; //circle radius is 9.2

obs_x_wall = -20;
obs_y_wall = -box_rad+((9.75*2)-1);

surge_x_wall = 10;
surge_y_wall = -box_rad+15.25+2.75; //surge length is 15.25

poison_x_wall = 0;
poison_y_wall = -box_rad+(ion_side/2)-3;


// Opposite side of holder
vehicle_x_wall = 26;
vehicle_y_wall = -box_rad+8;

commander_x_wall = -2;
commander_y_wall = -box_rad+22; //commander height is about 22

aim_x_wall = 14;
aim_y_wall = -box_rad+14.2+4; //aim radius is 7.1, side is 14.2. Square cutout is 5

stby_x_wall = 0;
stby_y_wall = -box_rad+(7.6*2);

sup_x_wall = 22;
sup_y_wall = -box_rad+(((22*1.2)/3)*2);

sup_x_wall2 = -14;
sup_y_wall2 = -box_rad+(((22*1.2)/3)*2);

immobilize_x_wall = 28;
immobilize_y_wall = -box_rad+(ion_side/2)-3;


//Create holder box
difference() {
    // Outer box
    cylinder(h=box_z, r = box_rad, $fn = 6);
    rotate([0,0,-60]){
        rotate([0,0,-60]){
            rotate([0,0,-60]){    
                rotate([0,0,-60]){    
                    rotate([0,0,-60]){    
                        translate([0,
                            -0.01, box_z+0.1 - pocket_depth]){
                                linear_extrude(
                            height=pocket_depth){
                                create_POI_token();
                                thumb_POI_radius = 5;    // corner radius (mm)
                                thumb_POI_length = 24; //(mm)
                                POI_rad = 25.7;
                                offset(thumb_POI_radius)
                                translate([0,-POI_rad-3])square(thumb_POI_length - 2*thumb_POI_radius, center=true);;
                                }
                            }

                        // Shield pocket
                        union(){
                            translate([shield_x_wall,
                            shield_y_wall, box_z+0.1 - pocket_depth])
                                cylinder(
                                    h = pocket_depth,
                                    d = shield_pocket_radius,
                                    $fn = 64
                                );
                            translate([(-shield_pocket_radius*0.33)+shield_x_wall,
                            -box_rad+9, box_z+0.1 - pocket_depth]){
                                linear_extrude(height=pocket_depth){
                                    square([shield_pocket_radius*0.66,4]);
                                }                                
                            }
                            //shield icon
                            translate([-20,-49,3])scale([0.18,0.18]){
                                color("yellow")linear_extrude(height=2)shield_icon();
                            }
                        }
                       
                       // wound token pocket
                       translate([wound_x_wall,
                        wound_y_wall, box_z+0.1 - pocket_depth]){
                            linear_extrude(height=pocket_depth){
                                create_wound_token();
                            }
                            rotate([0,0,-4])translate([-6.5,-6.5,0])color("red")scale([0.1,0.1])wound_icon();
                        }
                        
                        //ion token pocket
                        translate([ion_x_wall,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
                            linear_extrude(height=pocket_depth){
                                create_ion_token();
                                translate([-7,0])square([14,5]); //extra cutout for ion
                            }    
                        }
                    }
                    
                    //poison token pocket (same size & shape as ion)
                    translate([poison_x_wall,poison_y_wall-0.1,box_z+0.1- pocket_depth]){
                        linear_extrude(height=pocket_depth){
                            create_ion_token();
                            translate([-7,0])square([14,5]); //extra cutout for ion
                        }    
                    }
                    
                    //Immobilize token pocket (same size & shape as ion)
                    translate([immobilize_x_wall,immobilize_y_wall-0.1,box_z+0.1- pocket_depth]){
                        linear_extrude(height=pocket_depth){
                            create_ion_token();
                            translate([-7,0])square([14,5]); //extra cutout for ion
                        }    
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
                    linear_extrude(height=pocket_depth){
                        create_commander_token();
                    }    
                }
            }
            
            //Create aim token
            translate([aim_x_wall,aim_y_wall-0.1,box_z+0.1- pocket_depth]){
                linear_extrude(height=pocket_depth){
                    rotate([0,0,180]){
                        create_aim_token();
                        translate([-6,5])square([12,5]);
                    }
                }    
            }
            
            //Create old observation token
            translate([old_obs_x_wall,old_obs_y_wall-0.1,box_z+0.1- pocket_depth]){
                linear_extrude(height=pocket_depth){
                    rotate([0,0,90])create_old_observation_token();
                    //translate([-6,5])square([12,5]);
                }    
            }
        }
        
        //Create observation token
        translate([obs_x_wall,obs_y_wall-0.1,box_z+0.1- pocket_depth]){
            linear_extrude(height=pocket_depth){
                create_observation_token();
                color("red")translate([-7,-10])square([14,5]);
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
                rotate([0,0,180]){
                    create_sup_token();
                    translate([-6,5])square([12,5]);
                }
            }    
        }
    }
    
    //Create 2nd supression token
    translate([sup_x_wall2,sup_y_wall2-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,180]){
                create_sup_token();
                translate([-6,5])square([12,5]);
            }
        }    
    }
    
    //Create surge token
    translate([surge_x_wall,surge_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_surge_token();
            translate([-6,-10])square([12,5]);
        }    
    }
    
    //Create a cut for the lip
    lip_cut = 3;
    color("gray")translate([0, 0, box_z-3])cylinder(h=box_z-lip_cut, r = box_rad-1, $fn = 6);
    //magnets
    color("red")translate([24, -box_rad+15, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    color("green")translate([39, box_rad-31, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    color("blue")translate([-box_rad+8, 4, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);

}
//color("yellow")translate([11,-72, box_z+0.1- pocket_depth])scale([0.15,0.15,1])shield_icon();