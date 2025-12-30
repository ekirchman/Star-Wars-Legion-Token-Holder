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

module create_ion_token(ion_scale=[1.03,1.03]){
    // ion Side length
    s = 23;
    // Height of ion equilateral triangle
    h = s * sqrt(3) / 2;
    //Start of the ion token creation. No, it can't be refactored
    scale(ion_scale)union(){
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

module create_surge_token(){
    size = 15.25;     // square side length (mm)
    radius = 2;    // corner radius (mm)

    offset(r = radius)
    square(size - 2*radius, center=true);
}

module obs_arrow(){
    radius = 14;
    angle = 50;   // degrees

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
                    circle(r=9.20);
                    obs_arrow();
                    }
                }
            }
        }
    }
}