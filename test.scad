//For testing individual pockets
use <Token_Shapes.scad>;

// Box dimensions
box_x = 118;
box_y = 28;
box_z = 10;

// Pocket dimensions
pocket_radius = 21;
pocket_depth  = box_z-3;

ion_x_wall = 20;
ion_y_wall = 0;

surge_x_wall = 76;
surge_y_wall = 7;

obs_x_wall = 98;
obs_y_wall = 10;

//6mmx2mm
magnet_d = 7;
magnet_h = 2;

difference() {
    // Outer box
    cube([box_x, box_y, box_z]);
    
    //ion token pocket
    translate([ion_x_wall,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_ion_token(ion_scale=[1.01,1.01]);
            translate([-7,0])square([14,5]); //extra cutout for ion
        }    
    }
    //ion token pocket
    translate([ion_x_wall+32,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_ion_token(ion_scale=[1.02,1.02]);
            translate([-7,0])square([14,5]); //extra cutout for ion
        }    
    }
    
    //Create surge token
    translate([surge_x_wall,surge_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_surge_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    
    //Create observation token
    translate([obs_x_wall,obs_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,90])create_observation_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    
    //Create a cut for the lip
    lip_cut = 2;
    translate([1, -1, box_z-1])cube([box_x-lip_cut, box_y+2, 2]);
    
    color("red")translate([5, 5, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    color("red")translate([box_x-5, box_y-5, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    
}
//color("red")translate([1, 0, box_z-1])cube([box_x-2, box_y, 2]);