//Star Wars Legion Token Holder Lid
// Box dimensions
box_x = 195;
box_y = 46;
box_z = 10;

box_rad = 70;
lid_rad = box_rad-1.25;
lip_cut = 3;

//6mmx2mm magnets
magnet_d = 7;
magnet_h = 2;

mirror([0,0,1]){
    difference(){
    cylinder(h=lip_cut, r = lid_rad, $fn = 6);

    //magnets
    color("red")translate([24, -box_rad+15, lip_cut-2])cylinder(h=magnet_h+0.1, d=magnet_d);
    color("green")translate([39, box_rad-31, lip_cut-2])cylinder(h=magnet_h+0.1, d=magnet_d);
    color("blue")translate([-box_rad+8, 4, lip_cut-2])cylinder(h=magnet_h+0.1, d=magnet_d);
    }
    translate([-47,-10,-1])linear_extrude(height=2)scale([0.25,0.25])import("svgs/factions.svg");
}