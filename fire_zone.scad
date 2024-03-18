//размеры кирпича
br_w = 250;
br_d = 120;
br_h = 88;

// толщина слоя клея
gl_h = 10;

//размеры беседки по колоннам
bes_w = 5000;
bes_d = 4000;

//толщина фундамента
f_h = 100;
//отмостка
f_otm = 300;
//глубина фундамента колонны
col_f_h = 1000;
//ширина фундамента колонны
col_f_w = 500;

//число колонн по ширине
bes_w_col_count = 3;
//число колонн по длине
bes_d_col_count = 2;
//высота колонны в кирпичах
col_h_br = 23;

//сторона профиля столба колонны
stolb_w = 80;
//длина столба
stolb_l = col_f_h + f_h + col_h_br*(br_h+gl_h);
echo("длина столбов", stolb_l);


//маурлат
mr_h = 100;
mr_w = 100;

//брусок обвязки
obv_h = 150;
obv_w = 150;

//ширина лежня
lz_w= 100;

//размеры конька
kon_a = 50; // по ширине
kon_b = 100; // по высоте
kon_l = 2000;

//размеры стойки
kon_st_a = 50;
kon_st_b = 100;
kon_st_l = 1000;
//ширина планки креления стойки
st_pl_w = 20;


//ширина боковых стропил
side_str_w = 30;
//высота боковых стропил
side_str_h = 100;
//число стропил на коньке по одной стороне
side_str_count = 3;

//ширина верхней стяжки
v_kon_st_x = 50;
//высота верхней стяжки
v_kom_st_z = 100;

//ширина нижней стяжки
n_kon_st_x = 50;
//высота нижней стяжки
n_kom_st_z = 100;

//ширина диагональных стропил
diag_str_w = 50;
//ширина фронтальных стропил
front_str_w = 30;

//Ширина колонны
col_w = br_w + br_d + gl_h;

//Внешняя ширина маурлата и обвязки
obv_mr_w = bes_w - col_w + obv_w;
//Внешняя длина маурлата и обвязки
obv_mr_d = bes_d - col_w + obv_w;


//угол боковых стропил
side_str_angl = atan((kon_st_l + kon_b) / (bes_d/2 - kon_a/2 - col_w/2 + obv_w/2));
//добор верхний стропил длина катета
str_dob_v_l = side_str_h / tan(90-side_str_angl);
//добор нижний стропил длина катета
str_dob_n_l = side_str_h / tan(side_str_angl);

//функция нахождения угла стропил
function calculate_str_angle(a,b,l) = acos((2*a*l +sqrt(pow(2*a*l,2) - 4*(pow(a,2)+pow(b,2))*(pow(l,2)-pow(b,2))))/(2*(pow(a,2)+pow(b,2))));

//гипотенуза для расчета угла диагональных стропил
diag_str_gip = sqrt(pow(obv_mr_d/2,2) + pow((obv_mr_w - kon_l)/2,2));
//угол диагональных страпил
diag_str_angl = calculate_str_angle(
    kon_st_l + kon_b + (kon_a/2) * tan(side_str_angl) + side_str_h/cos(side_str_angl),
    sqrt(pow(obv_mr_d/2,2) + pow((obv_mr_w - kon_l)/2,2)),
    side_str_h
);
//угол поворота диагональных стропил
daig_str_vr_angl = atan(((obv_mr_w - kon_l)/2) / (obv_mr_d/2));

//угол фронтальных стропил
front_str_angl = calculate_str_angle(
    kon_st_l + kon_b + (kon_a/2) * tan(side_str_angl) + side_str_h/cos(side_str_angl),
    (obv_mr_w - kon_l)/2,
    side_str_h
);

//высота по коллонну
abs_col_h = (br_h + gl_h)* col_h_br;
//высота по обвязку
abs_obv_h = abs_col_h + obv_h;
//высота по маурлат
abs_mr_h = abs_obv_h + mr_h;
//высота по стойки конька
abs_st_kon_h = abs_mr_h + kon_st_l;
//высота по конек
abs_kon_h = abs_st_kon_h + kon_b;
//высота по зазор под страпилами
abs_pod_str_h = abs_kon_h + (kon_a/2) * tan(side_str_angl);
//высота по стропилы
abs_str_h = abs_pod_str_h + side_str_h/cos(side_str_angl);

//добор верхний фронтальных стропил длина катета
front_dob_v_l = side_str_h / tan(90-front_str_angl);
//добор нижний фронтальных стропил длина катета
front_dob_n_l = side_str_h / tan(front_str_angl);
//длина фронтальной стропилы без подрезов
front_str_l = (abs_pod_str_h - abs_col_h) / sin(front_str_angl);

//добор верхний диагональных стропил длина катета
diag_dob_v_l = side_str_h / tan(90-diag_str_angl);
//добор нижний диагональных стропил длина катета
diag_dob_n_l = side_str_h / tan(diag_str_angl);
//длина фронтальной стропилы без подрезов
diag_str_l = (abs_pod_str_h - abs_col_h) / sin(diag_str_angl);

//длина свесов от обвязки
sv_l = (obv_h + mr_h) / tan(side_str_angl) + str_dob_n_l / cos (side_str_angl);
echo("длина свесов боковых стропил от обвязки", sv_l);
echo("длина свесов боковых стропил от колонны", sv_l - col_w/2 + obv_w/2);
echo("угол наклона боковых стропил", side_str_angl);

echo("угол наклона диагональных стропил", diag_str_angl);

echo("угол наклона фронтальных стропил", front_str_angl);
front_sv_l = (obv_h + mr_h) / tan(front_str_angl) + front_dob_n_l / cos (front_str_angl);
echo("длина свесов боковых стропил от обвязки", front_sv_l);
echo("длина свесов боковых стропил от колонны", front_sv_l - col_w/2 + obv_w/2);

module front_doboraya_stropila(otstup) {

}

module podpory() {
    module podpor() {
        h1 = (diag_str_gip/2)*tan(diag_str_angl);
        h2 = (diag_str_gip/2+lz_w)*tan(diag_str_angl);
        color("black")translate([-diag_str_w/2,,0]) polyhedron(
            points = [
                [0,0,0],
                [0,0,h1],
                [diag_str_w,0,0],
                [diag_str_w,0,h1],
                [0,lz_w,0],
                [0,lz_w,h2],
                [diag_str_w,lz_w,0],
                [diag_str_w,lz_w,h2]
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [4,5,6],
                [6,7,5],
                [0,1,4],
                [4,5,1],
                [2,3,6],
                [6,7,3],
                [0,2,4],
                [4,6,2],
                [1,3,5],
                [5,7,3]
            ]
        );
    }

    translate([col_w/2 - obv_w/2, col_w/2- obv_w/2, abs_mr_h])
        rotate([0, 0, 270+daig_str_vr_angl])
            translate([0, diag_str_gip/2, 0])
                podpor();

    translate([col_w/2 - obv_w/2, bes_w - (col_w/2- obv_w/2), abs_mr_h])
        rotate([0, 0, 270-daig_str_vr_angl])
            translate([0, diag_str_gip/2, 0])
                podpor();

    translate([bes_d - (col_w/2 - obv_w/2), col_w/2- obv_w/2, abs_mr_h])
        rotate([0, 0, 90-daig_str_vr_angl])
            translate([0, diag_str_gip/2, 0])
                podpor();
    
    translate([bes_d - (col_w/2 - obv_w/2), bes_w - (col_w/2- obv_w/2), abs_mr_h])
        rotate([0, 0, 90+daig_str_vr_angl])
            translate([0, diag_str_gip/2, 0])
                podpor();
}

module ukosiny() {
    a = (diag_str_gip/2) / cos(daig_str_vr_angl) + mr_w;

    module ukosina() {
        rotate([0,0,-90])translate ([-a,0,0]) color("violet")polyhedron(
            points = [
                [0,0,0],
                [0,0,mr_h],
                [lz_w*sqrt(2),0,0],
                [lz_w*sqrt(2),0,mr_h],
                [a,a-lz_w*sqrt(2),0],
                [a,a-lz_w*sqrt(2),mr_h],
                [a,a,0],
                [a,a,mr_h],
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [4,5,6],
                [6,7,5],
                [0,1,6],
                [6,7,1],
                [2,3,4],
                [4,5,3],
                [0,2,4],
                [4,6,0],
                [1,3,5],
                [5,7,1]
                // [4,7,2]
            ]
        );
    }

    translate([col_w/2 - obv_w/2+mr_w,col_w/2 - obv_w/2+mr_w,abs_obv_h])ukosina();
    translate([bes_d - (col_w/2 - obv_w/2+mr_w),col_w/2 - obv_w/2+mr_w,abs_obv_h])rotate([0,0,90])ukosina();
    translate([bes_d - (col_w/2 - obv_w/2+mr_w),bes_w - (col_w/2 - obv_w/2+mr_w),abs_obv_h])rotate([0,0,180])ukosina();
    translate([col_w/2 - obv_w/2+mr_w,bes_w - (col_w/2 - obv_w/2+mr_w),abs_obv_h])rotate([0,0,270])ukosina();
}

module frontalnie_upory() {
    angle = 90-front_str_angl;
    
    osnovanie1 = (obv_mr_w - kon_l)/2 - n_kon_st_x;
    ploshad1 = pow(osnovanie1,2)*sin(angle)*sin(front_str_angl)/(2*sin(90));
    h1 = 2*ploshad1/osnovanie1;
    katet1 = h1*tan(90-angle);

    osnovanie2 = (obv_mr_w - kon_l)/2 - n_kon_st_x - side_str_h;
    ploshad2 = pow(osnovanie2,2)*sin(angle)*sin(front_str_angl)/(2*sin(90));
    h2 = 2*ploshad2/osnovanie2;
    katet2 = h2*tan(90-angle);

    module frontalny_upor() {
        color("orange")translate([-side_str_w/2,0,0])polyhedron(
            points = [
                [0,0,0],
                [side_str_w,0,0],
                [0,side_str_h,0],
                [side_str_w,side_str_h,0],
                [0,katet1,h1],
                [side_str_w,katet1,h1],
                [0,katet2+side_str_h,h2],
                [side_str_w,katet2+side_str_h,h2]
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [4,5,6],
                [6,7,5],
                [0,2,4],
                [4,6,2],
                [1,3,5],
                [5,7,3],
                [0,1,4],
                [4,5,1],
                [2,3,6],
                [6,7,3]
            ]
        );
    }

    translate([bes_d/2, bes_w/2 - kon_l/2 - n_kon_st_x, abs_mr_h]) rotate([0,0,180]) frontalny_upor();
    translate([bes_d/2, bes_w/2 + kon_l/2 + n_kon_st_x, abs_mr_h]) frontalny_upor();
}

module frontalnie_stropily() {
    module front_stropila() {
        translate([0, -front_str_w/2, 0]) polyhedron(
            points = [
                [0,0,0],
                [front_dob_v_l + front_str_l + front_dob_n_l,0,0],
                [front_dob_v_l,0,-side_str_h],
                [front_dob_v_l + front_str_l,0,-side_str_h],
                [0,front_str_w,0],
                [front_dob_v_l + front_str_l + front_dob_n_l,front_str_w,0],
                [front_dob_v_l,front_str_w,-side_str_h],
                [front_dob_v_l + front_str_l,front_str_w,-side_str_h],
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [4,5,6],
                [6,7,5],
                [0,2,4],
                [4,6,2],
                [0,1,4],
                [4,5,1],
                [2,3,6],
                [6,7,3],
                [1,3,5],
                [5,7,3]
            ]
        );
    }

    translate([bes_d/2,bes_w / 2 - (kon_l / 2),abs_str_h])
        rotate([0, front_str_angl, -90])
            front_stropila();

    translate([bes_d/2,bes_w / 2 + (kon_l / 2),abs_str_h])
        rotate([0, front_str_angl, 90])
            front_stropila();
}

// module diag_stropila() {
//     module diag_stropila() {
//         translate([0, -diag_str_w/2, 0]) polyhedron(
//             points = [
//                 [0,0,0],
//                 [diag_dob_v_l + diag_str_l + diag_dob_n_l,0,0],
//                 [diag_dob_v_l,0,-side_str_h],
//                 [diag_dob_v_l + diag_str_l,0,-side_str_h],
//                 [0,front_str_w,0],
//                 [front_dob_v_l + front_str_l + front_dob_n_l,front_str_w,0],
//                 [front_dob_v_l,front_str_w,-side_str_h],
//                 [front_dob_v_l + front_str_l,front_str_w,-side_str_h],
//             ],
//             faces = [
//                 [0,1,2],
//                 [2,3,1],
//                 [4,5,6],
//                 [6,7,5],
//                 [0,2,4],
//                 [4,6,2],
//                 [0,1,4],
//                 [4,5,1],
//                 [2,3,6],
//                 [6,7,3],
//                 [1,3,5],
//                 [5,7,3]
//             ]
//         );
//     }
// }

module diag_stropila() {
    //длина стропил без срезов
    str_l = (abs_pod_str_h - abs_col_h) / sin(diag_str_angl);
    union() {
        //срез верхний
        translate([diag_dob_v_l, diag_str_w/2, 0]) rotate ([0, 90, 180]) polyhedron(
            points =[
                [0, 0, 0],
                [0, diag_str_w, 0],
                [side_str_h, 0, 0],
                [side_str_h, diag_str_w, 0],
                [0, 0, diag_dob_v_l],
                [0, diag_str_w, diag_dob_v_l]
            ],
            faces = [
                [0,1,4],
                [1,4,5],
                [2,3,4],
                [3,4,5],
                [0,2,4],
                [1,3,5]
            ]
        );
        //середина
        translate([diag_dob_v_l, -diag_str_w/2, -side_str_h]) cube([str_l, diag_str_w, side_str_h]);
        //срез нижний
        translate([diag_dob_v_l + str_l, -diag_str_w/2, 0]) rotate ([0, 90, 0]) polyhedron(
            points = [
                [0, 0, 0],
                [0, diag_str_w, 0],
                [side_str_h, 0, 0],
                [side_str_h, diag_str_w, 0],
                [0, 0, diag_dob_n_l],
                [0, diag_str_w, diag_dob_n_l]
            ],
            faces = [
                [0,1,4],
                [1,4,5],
                [2,3,4],
                [3,4,5],
                [0,2,4],
                [1,3,5]
            ]
        );
    }
}

module diag_str_group() {
    translate([bes_d/2,bes_w / 2 - (kon_l / 2),abs_str_h])
        rotate([0, diag_str_angl, -daig_str_vr_angl]) diag_stropila();

    translate([bes_d/2,bes_w / 2 + (kon_l / 2),abs_str_h])
        rotate([0, diag_str_angl, daig_str_vr_angl]) diag_stropila();    

    translate([bes_d/2,bes_w / 2 - (kon_l / 2),abs_str_h])
        rotate([0, diag_str_angl, 180 + daig_str_vr_angl]) diag_stropila();

    translate([bes_d/2,bes_w / 2 + (kon_l / 2),abs_str_h])
        rotate([0, diag_str_angl, 180 - daig_str_vr_angl]) diag_stropila();
}      


module nizny_styazhka() {
    h = abs_str_h - abs_mr_h; //высота равнобедренного т-ка.
    l = 2*(h / tan(side_str_angl)); //основание равнобедренного т-ка.

        color("brown") translate([-l/2,0,0])polyhedron(
            points = [
                [0, 0, 0],
                [0, n_kon_st_x, 0],
                [n_kom_st_z/tan(side_str_angl), 0, n_kom_st_z],
                [n_kom_st_z/tan(side_str_angl), n_kon_st_x, n_kom_st_z],
                [l - n_kom_st_z/tan(side_str_angl), 0, n_kom_st_z],
                [l - n_kom_st_z/tan(side_str_angl), n_kon_st_x, n_kom_st_z],
                [l, 0, 0],
                [l, n_kon_st_x, 0]
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [0,1,6],
                [6,7,1],
                [2,3,4],
                [4,5,3],
                [4,5,6],
                [6,7,5],
                [0,2,6],
                [2,4,6],
                [1,3,7],
                [3,5,7]
            ]
        );
}

module niznie_styazhki() {
    otstup = kon_l / (side_str_count - 1);

    union() {
        translate([bes_d/2, bes_w/2 - kon_l/2 - n_kon_st_x, abs_mr_h]) nizny_styazhka();
        for (i = [1 : 1 : side_str_count - 2]){
            translate([bes_d/2, bes_w/2 - (kon_l/2) + i*otstup + side_str_w/2, abs_mr_h])
                nizny_styazhka();
        }
        translate([bes_d/2, bes_w/2 + kon_l/2, abs_mr_h]) nizny_styazhka();
    }
}

module verhny_styazhka() {
    h = abs_str_h - abs_kon_h; //высота равнобедренного т-ка.
    l = 2*(h / tan(side_str_angl)); //основание равнобедренного т-ка.

        color("brown") translate([-l/2,0,0])polyhedron(
            points = [
                [0, 0, 0],
                [0, v_kon_st_x, 0],
                [v_kom_st_z/tan(side_str_angl), 0, v_kom_st_z],
                [v_kom_st_z/tan(side_str_angl), v_kon_st_x, v_kom_st_z],
                [l - v_kom_st_z/tan(side_str_angl), 0, v_kom_st_z],
                [l - v_kom_st_z/tan(side_str_angl), v_kon_st_x, v_kom_st_z],
                [l, 0, 0],
                [l, v_kon_st_x, 0]
            ],
            faces = [
                [0,1,2],
                [2,3,1],
                [0,1,6],
                [6,7,1],
                [2,3,4],
                [4,5,3],
                [4,5,6],
                [6,7,5],
                [0,2,6],
                [2,4,6],
                [1,3,7],
                [3,5,7]
            ]
        );
}

module verhnye_styazhki() {
    otstup = kon_l / (side_str_count - 1);

    union() {
        translate([bes_d/2, bes_w/2 - kon_l/2 + side_str_w, abs_kon_h])verhny_styazhka();
        for (i = [1 : 1 : side_str_count - 2]){
            translate([bes_d/2, bes_w / 2 - (kon_l / 2) + i * otstup - side_str_w/2 + side_str_w, abs_kon_h])
                verhny_styazhka();
        }
        translate([bes_d/2, bes_w/2 + kon_l/2 - side_str_w - v_kon_st_x, abs_kon_h])verhny_styazhka();
    }
}

module konkova_stropila() {
    //длина стропил без срезов
    str_l = (abs_kon_h - abs_col_h + (kon_a/2 * tan(side_str_angl))) / sin(side_str_angl);
    union() {
        //срез верхний
        translate([str_dob_v_l,side_str_w, 0]) rotate ([0, 90, 180]) polyhedron(
            points =[
                [0, 0, 0],
                [0, side_str_w, 0],
                [side_str_h, 0, 0],
                [side_str_h, side_str_w, 0],
                [0, 0, str_dob_v_l],
                [0, side_str_w, str_dob_v_l]
            ],
            faces = [
                [0,1,4],
                [1,4,5],
                [2,3,4],
                [3,4,5],
                [0,2,4],
                [1,3,5]
            ]
        );
        //середина
        translate([str_dob_v_l, 0, -side_str_h]) cube([str_l, side_str_w, side_str_h]);
        //срез нижний
        translate([str_dob_v_l + str_l, 0, 0]) rotate ([0, 90, 0]) polyhedron(
            points =[
                [0, 0, 0],
                [0, side_str_w, 0],
                [side_str_h, 0, 0],
                [side_str_h, side_str_w, 0],
                [0, 0, str_dob_n_l],
                [0, side_str_w, str_dob_n_l]
            ],
            faces = [
                [0,1,4],
                [1,4,5],
                [2,3,4],
                [3,4,5],
                [0,2,4],
                [1,3,5]
            ]
        );
    }
}

module konkovyie_stropily() {

    otstup = kon_l / (side_str_count - 1);

    union() {
        translate([bes_d/2, bes_w / 2 - (kon_l / 2), abs_str_h])
            rotate([0,side_str_angl,0])
                konkova_stropila();
        for (i = [1 : 1 : side_str_count - 2]){
            translate([bes_d/2, bes_w / 2 - (kon_l / 2) + i * otstup - side_str_w/2, abs_str_h])
                rotate([0,side_str_angl,0])
                    konkova_stropila();
        }
        translate([bes_d/2, bes_w / 2 - (kon_l / 2) + (side_str_count - 1) * otstup - side_str_w, abs_str_h])
            rotate([0,side_str_angl,0])
                konkova_stropila();

        translate([bes_d/2, bes_w / 2 - (kon_l / 2), abs_str_h])
            translate([0,side_str_w,  0])
                rotate([0,side_str_angl,180])
                    konkova_stropila();
        for (i = [1 : 1 : side_str_count - 2]){
            translate([bes_d/2, bes_w / 2 - (kon_l / 2) + i * otstup - side_str_w/2, abs_str_h])
                translate([0,side_str_w,  0])
                    rotate([0,side_str_angl,180])
                        konkova_stropila();
        }
        translate([bes_d/2, bes_w / 2 - (kon_l / 2) + (side_str_count - 1) * otstup - side_str_w, abs_str_h])
            translate([0,side_str_w,  0])
                rotate([0,side_str_angl,180])
                    konkova_stropila();
    }
}

module konek() {
    color("green") translate([bes_d/2, bes_w/2 - kon_l/2, abs_st_kon_h]) translate([-kon_a/2, 0, 0]) cube([kon_a, kon_l, kon_b]);
}


module stoyka() {
    color("blue") translate([- kon_st_a/2,0, 0]) cube([kon_st_a, kon_st_b, kon_st_l]);
}

module stoyki() {
    union () {
        translate([bes_d/2, bes_w / 2 - (kon_l / 2), abs_mr_h]) stoyka();
        translate([bes_d/2, bes_w / 2 + (kon_l / 2) - kon_st_b, abs_mr_h]) stoyka();
    }
}

module konkovy_ukosini() {
    module konkova_ukosina () {
        color("pink") translate([-kon_st_a/2,0,0]) polyhedron(
            points = [
                [0, 0, 0],
                [kon_st_a, 0, 0],
                [0, 0, kon_st_b],
                [kon_st_a, 0, kon_st_b],
                [0, kon_st_l/2-kon_st_b, kon_st_l/2],
                [kon_st_a, kon_st_l/2- kon_st_b, kon_st_l/2],
                [0, kon_st_l/2, kon_st_l/2],
                [kon_st_a, kon_st_l/2, kon_st_l/2]
            ],
            faces = [
                [0,1,2],
                [1,2,3],
                [4,5,6],
                [5,6,7],
                [0,2,4],
                [4,6,0],
                [1,3,5],
                [5,7,1],
                [0,1,6],
                [6,7,1],
                [2,3,4],
                [4,5,3]
            ]
        );
    }

    translate([bes_d/2, bes_w/2 - kon_l/2 + kon_st_b, abs_mr_h + kon_st_l/2]) konkova_ukosina();
    translate([bes_d/2, bes_w/2 + kon_l/2 - kon_st_b, abs_mr_h + kon_st_l/2]) rotate([0,0,180]) konkova_ukosina();
}

module lezhen() {
    color("red")
    translate ([ bes_d/2 - lz_w/2, col_w/2 - obv_w / 2 + mr_w, abs_obv_h])
    cube([lz_w, bes_w-col_w+obv_h-2*mr_w, mr_h]);
}

module maurlat_laga(position = [0, 0, 0], rotation = [0, 0, 0], length) {
    translate(position) rotate(rotation) color("grey") union() {
        cube([mr_w, mr_w, mr_h / 2]);
        translate([mr_w, 0, 0]) cube([length - mr_w * 2, mr_w, mr_h]);
        translate([length - mr_w, 0, 0]) cube([mr_w, mr_w, mr_h / 2]);
    }
}

module maurlat() {
    translate([col_w/2 - obv_w/2, col_w/2 - obv_w/2, (gl_h+br_h)*col_h_br + obv_h]) union() {
        maurlat_laga(position = [0, 0, 0], length = bes_d - 2 * (col_w/2-obv_w/2));
        maurlat_laga(position = [0, bes_w + obv_w - col_w - mr_w, 0], length = bes_d - 2 * (col_w/2-obv_w/2));

        maurlat_laga(position = [mr_w, bes_w + obv_w - col_w, mr_h], rotation = [0, 180, 90], length = bes_w - 2 * (col_w/2-obv_w/2));
        maurlat_laga(position = [bes_d  + obv_w - col_w, bes_w + obv_w - col_w, mr_h], rotation = [0, 180, 90], length = bes_w - 2 * (col_w/2-obv_w/2));
    }
}

module obv_laga(position = [0, 0, 0], rotation = [0, 0, 0], length) {
    translate(position) rotate(rotation) color("orange") union() {
        cube([obv_w, obv_w, obv_h / 2]);
        translate([obv_w, 0, 0]) cube([length - obv_w * 2, obv_w, obv_h]);
        translate([length - obv_w, 0, 0]) cube([obv_w, obv_w, obv_h / 2]);
    }
}

module obvuazka() {
    translate([col_w/2 - obv_w/2, col_w/2 - obv_w/2, (gl_h+br_h)*col_h_br]) union() {
        obv_laga(position = [0, 0, 0], length = bes_d - 2 * (col_w/2-obv_w/2));
        obv_laga(position = [0, bes_w - (col_w-obv_w) - obv_w, 0], length = bes_d - 2 * (col_w/2-obv_w/2));

        obv_laga(position = [obv_w, bes_w + obv_w - col_w, obv_h], rotation = [0, 180, 90], length = bes_w - 2 * (col_w/2-obv_w/2));
        obv_laga(position = [bes_d  + obv_w - col_w, bes_w + obv_w - col_w, obv_h], rotation = [0, 180, 90], length = bes_w - 2 * (col_w/2-obv_w/2));
    }
}

/*
ti_w = 200;
ti_d = 100;
ti_h = 60;
module tile(position = [0, 0, 0], rotation = [0, 0, 0]) {
    rotate(rotation) translate(position) color("brown") union() {
        polyhedron(
            points = [[0, 0, ti_h -10], [0, ti_d, ti_h -10], [ti_w, ti_d, ti_h -10], [ti_w, 0, ti_h -10],
            [10, 10, ti_h], [10, ti_d - 10, ti_h], [ti_w - 10, ti_d - 10, ti_h], [ti_w - 10, 10, ti_h]],
            faces = [
                [4, 5, 6, 7],
                [0, 1, 4],
                [4, 5, 1],
                [1, 2, 5],
                [5, 6, 2],
                [2, 3, 6],
                [6, 7, 3],
                [3, 0, 7],
                [7, 4, 0]
            ]
        );
        cube([ti_w, ti_d, ti_h -10]);
    }
    
}

module tile_draw(position = [0, 0, 0], rotation = [0, 0, 0]) {
    rotate(rotation) translate(position) union() {
        tile();
        tile([ti_d, -ti_d, 0], [0, 0, 90]);
        tile([-ti_d, ti_d+ti_w, 0], [0, 0, 0]);
    }
}

module tile_flor(position = [0, 0, 0], rotation = [0, 0, 0], width, depth) {
    length = max (width, depth) / ti_d;
    intersection() {
        union() {
            for (j = [0 : 1 : length - 1]) {
                bias_x = ti_w * j;
                bias_y = - (ti_w + ti_d * 2) * j;

                for (i = [0 : 1 : length - 1]) {
                    x = bias_x + i*ti_d;
                    y = bias_y + i*ti_d;
                    if (0 < x && x < width && 0 < y && y < depth)
                        tile_draw([x, y, 0]);
                }

                bias_x1 = -bias_x;
                bias_y1 = - bias_y;
                for (i = [1 : 1 : length - 1]) {
                    x = -bias_x + i*ti_d;
                    y = -bias_y + i*ti_d;
                    if (0 < x && x < width && 0 < y && y < depth)
                        tile_draw([x, y, 0]);
                }
            }
        }
    }
}

tile_flor(width = 10000, depth = 10000);
*/




module brick(position = [0, 0, 0], rotation = [0, 0, 0], glue = [false, false, false]) {
    glue_position = [
        if (glue[0]) position[0] + 10 else position[0],
        if (glue[1]) position[1] + 10 else position[1],
        if (glue[2]) position[2] + 10 else position[2]
    ];
   
    rotate(rotation) translate(glue_position)
            union() {
                cube([br_w, br_d, br_h]);
                color("grey") union() {
                    if (glue[0]) translate([-gl_h, gl_h, gl_h]) cube([gl_h, br_d - gl_h* 2, br_h - gl_h*2]);
                    if (glue[1]) translate([gl_h, -gl_h, gl_h]) cube([br_w - gl_h*2, gl_h, br_h - gl_h*2]);
                    if (glue[2]) translate([gl_h, gl_h, -gl_h]) cube([br_w - gl_h*2, br_d - gl_h * 2, gl_h]);
                    if (glue[0] && glue[1]) translate([-gl_h, -gl_h, gl_h]) cube([gl_h * 2, gl_h * 2, br_h - gl_h*2]);
                    if (glue[0] && glue[2]) translate([-gl_h, gl_h, -gl_h]) cube([gl_h* 2, br_d - gl_h * 2, gl_h * 2]);
                    if (glue[1] && glue[2]) translate([gl_h, -gl_h, -gl_h]) cube([br_w - gl_h*2, gl_h * 2, gl_h * 2]);
                }
            }
}

module column_level() {
    union() {
        brick([-br_w - gl_h,-120,0], [0,0,180], [true, false, true]);
        brick([120,-120,0], [0,0,90], [true, false, true]);
        brick([120,260,0],[0,0,0],[true, false, true]);
        brick([-br_w - gl_h,260,0],[0,0,270],[true, false, true]);
    }
}

module column(levels=1) {
    union() {
        for(i = [0 : 1 : levels - 1]) {
            if (i%2 == 1)
                mirror([0, 1, ,0])
                    translate([0, -380, 98*i])
                        column_level();
            else
                translate([0,0, 98*i])
                    column_level();
        }
    }
}

module column_group() {
    d_gap = (bes_d - (bes_d_col_count)*(col_w))/(bes_d_col_count - 1);
    for (i = [0 : 1 : bes_d_col_count - 1]) {
        translate([0 + i * (d_gap + col_w), 0, 0])
            column(col_h_br);
    }
    
    w_gap = (bes_w - (bes_w_col_count)*(col_w))/(bes_w_col_count - 1);
    for (i = [1 : 1 : bes_w_col_count - 2]) {
        translate([0, i*(w_gap + col_w), 0])
            column(col_h_br);
        translate([bes_d - col_w, i*(w_gap + col_w), 0])
            column(col_h_br);
    }

    for (i = [0 : 1 : bes_d_col_count - 1]) {
        translate([0 + i * (d_gap + col_w), bes_w - col_w, 0])
            column(col_h_br);
    }    
}

module column_fundaments() {
    fund_d = bes_d -col_w + col_f_w;
    d_gap = (fund_d - (bes_d_col_count)*col_f_w)/(bes_d_col_count - 1);
    for (i = [0 : 1 : bes_d_col_count - 1]) {
        color("grey") translate([col_w/2-col_f_w/2 + i * (d_gap + col_f_w), col_w/2-col_f_w/2,  -f_h - col_f_h])
            cube([col_f_w, col_f_w, col_f_h]);
    }

    fund_w = bes_w -col_w + col_f_w;
    w_gap = (fund_w - (bes_w_col_count)*col_f_w)/(bes_w_col_count - 1);
    for (i = [1 : 1 : bes_w_col_count - 2]) {
        color("grey") translate([col_w/2-col_f_w/2, col_w/2-col_f_w/2 + i*(w_gap + col_f_w),  -f_h - col_f_h])
            cube([col_f_w, col_f_w, col_f_h]);
        color("grey") translate([bes_d - (col_w/2-col_f_w/2) - col_f_w, col_w/2-col_f_w/2 + i*(w_gap + col_f_w),  -f_h - col_f_h])
            cube([col_f_w, col_f_w, col_f_h]);
    }

    for (i = [0 : 1 : bes_d_col_count - 1]) {
        color("grey") translate([col_w/2-col_f_w/2 + i * (d_gap + col_f_w), col_w/2-col_f_w/2 - col_f_w + fund_w,  -f_h - col_f_h])
            cube([col_f_w, col_f_w, col_f_h]);
    }   
}

module stolby() {
    module stolb() {
        color("red") translate([-stolb_w/2,-stolb_w/2, -f_h - col_f_h])
            cube([stolb_w, stolb_w, stolb_l]);
    }

    otstup_d = (bes_d - col_w) / (bes_d_col_count - 1);
    for(i = [0 : 1 : bes_d_col_count - 1]) {
        translate([col_w/2 + i * otstup_d, col_w/2, 0]) stolb();
        translate([col_w/2 + i * otstup_d, bes_w - col_w/2, 0]) stolb();
    }

    otstup_w = (bes_w - col_w) / (bes_w_col_count - 1);
    for(i = [1 : 1 : bes_w_col_count - 2]) {
        translate([col_w/2, col_w/2 + i * otstup_w, 0]) stolb();
        translate([bes_d - col_w/2, col_w/2 + i * otstup_w, 0]) stolb();
    }
}

module fundament() {
    color("grey")
        translate([-f_otm, -f_otm, - f_h])
            cube([bes_d + 2*f_otm, bes_w + 2*f_otm, f_h]);
}


module pavilion() {
    column_fundaments();
    fundament();
    stolby();
    column_group();
    obvuazka();
    maurlat();
    lezhen();
    stoyki();
    konek();
    konkovy_ukosini();
    konkovyie_stropily();
    verhnye_styazhki();
    niznie_styazhki();
    frontalnie_stropily();
    frontalnie_upory();
    diag_str_group();
    ukosiny();
    podpory();
}

pavilion();


// translate([-(sv_l - col_w/2 + obv_w/2)-4, -(front_sv_l- col_w/2 + obv_w/2), abs_col_h])
//     cube([4,obv_mr_w+front_sv_l*2,4]);

