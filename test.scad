//For testing individual pockets
use <Token_Shapes.scad>;

// Box dimensions
box_x = 45;
box_y = 18;
box_z = 10;

// Pocket dimensions
pocket_radius = 21;
pocket_depth  = box_z-3;

ion_x_wall = 16;
ion_y_wall = 0;

dodge_x_wall = 12;
dodge_y_wall = 8;

obs_x_wall = 34;
obs_y_wall = 8;

surge_x_wall = 67;
surge_y_wall = 7;

surge_x_wall2 = 97;
surge_y_wall2 = 7;

old_obs_x_wall = 98;
old_obs_y_wall = 10;

sup_x_wall = 82;
sup_y_wall = box_y-8;

sup_x_wall2 = 114;
sup_y_wall2 = box_y-8;

//6mmx2mm
magnet_d = 7;
magnet_h = 2;

difference() {
    // Outer box
    cube([box_x, box_y, box_z]);
    
    //dodge token
    translate([dodge_x_wall,dodge_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_dodge_token();
            translate([-7,0])square([14,5]); //extra cutout for ion
        }    
        translate([0,0,-1])linear_extrude(height=2)create_dodge_icon();
    }
    //new observation token
    translate([obs_x_wall,obs_y_wall-0.1,box_z+0.1- pocket_depth]){
        union(){
        linear_extrude(height=pocket_depth){
            create_observation_token();
            translate([-7,0])square([14,5]); //extra cutout for ion
        }
        translate([-8.25,-8,-1])
                linear_extrude(height = 2)
                scale([0.12,0.12])import("svgs/observation.svg");
        }
    }
    
    /*
    //ion token pocket
    translate([ion_x_wall,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_ion_token(ion_scale=[1.01,1.01], niblet_length=3.6);
            translate([-7,0])square([14,5]); //extra cutout for ion
        }    
    }
    //ion token pocket
    translate([ion_x_wall+32,ion_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_ion_token(ion_scale=[1.02,1.02], niblet_length=3.2);
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
    
    //Create supression token
    translate([sup_x_wall,sup_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_sup_token();
            translate([-6,5])square([12,5]);
        }    
    }
    */
    /*
    //Create 2nd supression token
    translate([sup_x_wall2,sup_y_wall2-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_sup_token([1.2,1.2]);
            translate([-6,5])square([12,5]);
        }    
    }
    
    //Create surge token
    translate([surge_x_wall2,surge_y_wall2-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            create_surge_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    /*
    /*
    //Create observation token
    translate([old_obs_x_wall,old_obs_y_wall-0.1,box_z+0.1- pocket_depth]){
        linear_extrude(height=pocket_depth){
            rotate([0,0,90])create_observation_token();
            //translate([-6,5])square([12,5]);
        }    
    }
    */
    /*
    //Create a cut for the lip
    lip_cut = 2;
    translate([1, -1, box_z-1])cube([box_x-lip_cut, box_y+2, 2]);
    
    color("red")translate([5, 5, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    color("red")translate([box_x-5, box_y-5, box_z-lip_cut-1])cylinder(h=magnet_h+2, d=magnet_d);
    */
}
//color("red")translate([1, 0, box_z-1])cube([box_x-2, box_y, 2]);


//color("red")create_dodge_token_icon();

//color("green")create_dodge_icon();