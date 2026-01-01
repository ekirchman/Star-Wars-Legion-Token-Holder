ion_tri_length = 6.5;
//niblet_length = 3.8;
module ion_tri_piece_1 (niblet_length) {
    translate([2, niblet_length, 0]){
       polygon(points=[
        [0, 0],        // Point A
        [ion_tri_length, 0],        // Point B
        [ion_tri_length/2, ion_tri_length/4]       // Point C
    ]); 
    }
}
module ion_point_niblet(niblet_length){
    ion_tri_piece_1(niblet_length);
    mirror([0, 1, 0]){
        ion_tri_piece_1(niblet_length);
    }
    translate([2, -(niblet_length+0.01), 0]){
        square([ion_tri_length+0.3,((niblet_length * 2) + 0.02)]); //0.2 used here to connect triangles to square
    }    
}

module create_ion_token(ion_scale=[1.01,1.01], niblet_length = 3.6){
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
                                                ion_point_niblet(niblet_length);
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
                                ion_point_niblet(niblet_length);
                            }
                        }
                    }
                }
            }
        }
        //third niblet
        translate([0,-2,0]){
            rotate([0,0,90]){
                ion_point_niblet(niblet_length);
            }
        }
    }
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
module create_old_observation_token(){
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


module sup_diff(){
    rect_len = 5;
    translate([2, -3.51, 0]){
        square([rect_len,7.02]); //0.2 used here to connect triangles
    }    
}

module sup_arrows(h){
    translate([-2,0,0])square([4,(h*(1/3))+2]);
}

module create_sup_token(sup_scale=[1.2,1.2]){
    // ion Side length
    supression_s = 22;
    // Height of supression equilateral triangle
    supression_h = supression_s * sqrt(3) / 2;
   scale(sup_scale)union(){
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

module create_surge_token(surge_size=15.25){
    size = surge_size;  // square side length (mm)
    radius = 2;    // corner radius (mm)

    offset(r = radius)
    square(size - 2*radius, center=true);
}

module create_dodge_token(){
    circle(r = 10.5, $fn = 6);
}

module create_dodge_icon(){
    dodge_icon_rad =4.25;
    square_x_translate = 4;
    square_y_translate = -(dodge_icon_rad/2);
    rotate([0,0,60]){
        union(){
            translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
            rotate([0,0,60]){
                union(){
                    translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
                    rotate([0,0,60]){
                        union(){
                            translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
                            rotate([0,0,60]){
                                union(){
                                    translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
                                    rotate([0,0,60]){
                                        union(){
                                            translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
                                            rotate([0,0,60]){
                                                union(){
                                                    rotate([0,0,90])circle(r = dodge_icon_rad, $fn = 6);
                                                    translate([square_x_translate,square_y_translate])square(dodge_icon_rad,dodge_icon_rad);
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
        }
    }
}

module create_observation_token(){
    circle(r = 9.75);

}

module create_POI_token(){
    circle(r = 25.7);
}

wound_circle_size= 16;
wound_square_size = 3;
module create_wound_token(){
    union(){
        circle(d=wound_circle_size);
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
        translate([-8, -10.1, 0])square([16, wound_square_size]);
        }
}

module shield_icon(){
    translate([-140,-203,0])import("svgs/shield.svg");
    /*
    ring1 = 20;
    ring2 = 14;
    ring3 = 8;
    scale([0.3,0.3])
    union(){
        circle(r=4);

        difference(){
            circle(r=ring1);
            circle(r=ring1-0.5);
        }
        rotate([0,0,0])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,180])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,60])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,90])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,270])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,310])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,230])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,290])translate([-0.5,0])square([1,ring2]);
        rotate([0,0,140])translate([-0.5,0])square([1,ring2]);
        rotate([0,0,30])translate([-0.5,0])square([1,ring2]);
        rotate([0,0,120])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,340])translate([-0.5,0])square([1,ring1]);
        rotate([0,0,200])translate([-0.5,0])square([1,ring2]);

        difference(){
            circle(r=ring2);
            circle(r=ring2-0.5);
        }

        difference(){
            circle(r=ring3);
            circle(r=ring3-0.5);
        }
    }
    */
}

module wound_icon(){
    import("svgs/wound.svg");
}

module lightning_icon(){
    rotate([0,0,60])mirror([1,1,0])square([4.5,14]);
    translate([-7,-12])rotate([0,0,60])mirror([0,1,0])square([4.5,10]);

    //translate([11,-9.65])rotate([0,0,-120])
    
    translate([-1.5,-15])rotate([0,0,-120])mirror([0,0,0])polygon(points=[
    [0, 0],
    [40/8, 0],   // base
    [0, 30/8]    // height
    ]);
    
}

module ion_icon(){
    // ion Side length
    s = 23;
    // Height of ion equilateral triangle
    h = s * sqrt(3) / 2;
    union(){
        rotate([0,0,120]){
            union(){
                rotate([0,0,120]){
                    union(){
                        translate([-s*(1/2),-s*(1/3),0]){
                            
                            polygon(points=[
                            [0, 0],        // Point A
                            [s, 0],        // Point B
                            [s/2, h]       // Point C
                            ]);
                        }
                      lightning_icon();
                    }
                }
                lightning_icon();
            }
        }
        lightning_icon();
    }
}
module poison_icon(){
    scale([0.05,0.05])import("svgs/poison.svg");
}

module immobilize_icon(){
    scale([0.05,0.05])import("svgs/immobilize.svg");
}

module damage_icon(){
    translate([2,-2.5])scale([0.03,0.03])import("svgs/damage.svg");
}

module aim_icon(){
    translate([7,-7])rotate([0,0,90])scale([0.1,0.1])import("svgs/aim.svg");
}

module observation_icon(){
    translate([7,-7])rotate([0,0,90])scale([0.1,0.1])import("svgs/observation.svg");
}

module standby_icon(){
    translate([7,-7])rotate([0,0,90])scale([0.1,0.1])import("svgs/standby.svg");
}

module suppression_icon(){
    translate([4,-5])rotate([0,0,90])scale([0.1,0.1])import("svgs/Suppression.svg");
}
module surge_icon(){
    translate([8.75,-8.75])rotate([0,0,90])scale([0.1,0.1])import("svgs/surge.svg");
}
module POI_icon(){
    union(){
        difference(){
            circle(r=9.75);
            translate([0,-1])color("red")square([20,2]);
            mirror([1,0,0])translate([0,-1])color("green")square([20,2]);
            circle(r=6.0);
        }
        circle(r=4.0);
    }
}

module commander_icon(){

    commander_s = 6;
    commander_h = commander_s * sqrt(3) / 2;
    neg_commander_s = 4;
    neg_commander_h = neg_commander_s * sqrt(3) / 2;
    small_commander_s = 2.5;
    small_commander_h = small_commander_s * sqrt(3) / 2;
    union(){
        difference(){
            polygon(points=[
            [0, 0],        // Point A
            [commander_s, 0],        // Point B
            [commander_s/2, commander_h]       // Point C
            ]);

            translate([1,0])
            polygon(points=[
            [0, 0],        // Point A
            [neg_commander_s, 0],        // Point B
            [neg_commander_s/2, neg_commander_h]       // Point C
            ]);
        }
        scale([1.5,1.5])
        translate([0.75,-0.5])polygon(points=[
        [0, 0],        // Point A
        [small_commander_s, 0],        // Point B
        [small_commander_s/2, small_commander_h]       // Point C
        ]);

        translate([0,1.6])
        scale([1.2,1.2])
        mirror([0,1,0])translate([-small_commander_s*(1/2),-small_commander_s*(1/3)])polygon(points=[
            [0, 0],        // Point A
            [small_commander_s, 0],        // Point B
            [small_commander_s/2, small_commander_h]       // Point C
            ]);

        translate([6,1.6])
        scale([1.2,1.2])
        mirror([0,1,0])translate([-small_commander_s*(1/2),-small_commander_s*(1/3)])polygon(points=[
            [0, 0],        // Point A
            [small_commander_s, 0],        // Point B
            [small_commander_s/2, small_commander_h]       // Point C
            ]);
    }
}
