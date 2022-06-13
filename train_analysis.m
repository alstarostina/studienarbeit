function result = train_analysis( 
  waggon_msh_file,
  nofmod,
  Platte_t,
  Waende_t,
  dg_surface_geom_t,
  Saeulen_f_w,
  Saeulen_f_h,
  Saeulen_f_t,
  T_b,
  T_h,
  T_t,
  T_s,
  I_haupt_b,
  I_haupt_h,
  I_haupt_t,
  I_haupt_s,
  Saeulen_Seiten_w,
  Saeulen_Seiten_h,
  Saeulen_Seiten_t
) 

#material
mat.type = "iso";
mat.E = 70000;
mat.ny = 0.34;
mat.rho = 2.7e-9; %einheiten

#Modell

data.type = "solid";
data.subtype = "3d";

#BodenGruppe BG

#Platte


Platte.t = Platte_t; #mm

data.BG_Platte = struct("type","elements",
                        "name", "s4", 
                        "geom", Platte, 
                        "mat", mat);


vector = [0,0,1];

Kreis.ra = 50;
Kreis.ri = 40;
Kontakt_Langtr_rechts = [-Kreis.ra, -Kreis.ra];
Kontakt_Langtr_links = [Kreis.ra, -Kreis.ra];

geom_rechts = mfs_beamsection("ring", "thin", Kreis.ra, Kreis.ri);
##geom_rechts = mfs_beamsection("I", I_haupt.b, I_haupt.h, I_haupt.t, I_haupt.s);
##Kontakt_Langtr_rechts = [-I_haupt.b, -I_haupt.b];
##Kontakt_Langtr_links = [I_haupt.b, -I_haupt.b]; 
geom_rechts.v = vector;
geom_rechts.P = Kontakt_Langtr_rechts;

geom_links = mfs_beamsection("ring", "thin", Kreis.ra, Kreis.ri);
#geom_links = mfs_beamsection("I", I_haupt.b, I_haupt.h, I_haupt.t, I_haupt.s);
geom_links.v = vector;
geom_links.P = Kontakt_Langtr_links;

#Langtr�ger rechts
data.BG_Langtraeger_rechts = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_rechts, 
                        "mat", mat);
#Langtr�ger links
data.BG_Langtraeger_links = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_links, 
                        "mat", mat);
                        
#Langtr�ger innen
Kreis.ra = 70; 
Kreis.ri = 55;                      
Kontakt_Langtr = [0, Kreis.ra];
geom_innen = mfs_beamsection("ring", "thick", Kreis.ra, Kreis.ri);
geom_innen.v = vector;
geom_innen.P = Kontakt_Langtr;
data.BG_Langtraeger_innen = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_innen, 
                        "mat", mat);

#Quertr�ger
#Hauptquertraeger
I_haupt.b = I_haupt_b; % 100;
I_haupt.h = I_haupt_h; % 150;
I_haupt.t = I_haupt_t; % 5;
I_haupt.s = I_haupt_s; % 10; 
P_haupt = [0, -(0.5*I_haupt.h + I_haupt.t)];

geom_haupt = mfs_beamsection("I", I_haupt.b, I_haupt.h, I_haupt.t, I_haupt.s);
geom_haupt.v = vector;
geom_haupt.P = P_haupt;
data.BG_Hauptquertraeger = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_haupt, 
                        "mat", mat);

I = struct("b", I_haupt.b*0.5, "h", I_haupt.t*0.5, ...
           "t", I_haupt.t*0.5, "s", I_haupt.s*0.5);
geom =  mfs_beamsection("I", I.b, I.h, I.t, I.s);
P_quer = [0, -(0.5*I.h + I.t)];
geom.v = vector;  
geom.P = P_quer; 
data.BG_Quertraeger = struct("type","elements",
                        "name", "b2", 
                        "geom", geom, 
                        "mat", mat);      
                        
                        
                        
data.BG_Quertraeger_AD = data.BG_Quertraeger;
data.BG_Quertraeger_BC = data.BG_Quertraeger;

                        
                    

#Seitengruppe SG

Waende.t = Waende_t; #mm
data.SG_Waende = struct("type","elements",
                        "name", "s4", 
                        "geom", Waende, 
                        "mat", mat); 

#Dach- und Fenstertr�ger
vector = [0,0,1];
T.b = T_b; % 50;
T.h = T_h; % 80;
T.t = T_t; % 10;
T.s = T_s; % 5;
P_links = [0.5*T.b, -0.5*T.h];
P_rechts = [-0.5*T.b, -0.5*T.h];

geom_links = mfs_beamsection("I", T.b, T.h, T.t, T.s);
geom_links.v = vector;
geom_links.P = P_links;
geom_rechts = mfs_beamsection("I", T.b, T.h, T.t, T.s);
geom_rechts.v = vector;
geom_rechts.P = P_rechts;

data.SG_Dachtraeger_links = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_links, 
                        "mat", mat);
data.SG_Dachtraeger_rechts = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_rechts, 
                        "mat", mat);

geom_links_f = mfs_beamsection("I", 1.5*T.b, 1.5*T.h, 1.5*T.t, 1.5*T.s);
geom_links_f.v = vector;
geom_links_f.P = P_links;
geom_rechts_f = mfs_beamsection("I", 1.5*T.b, 1.5*T.h, 1.5*T.t, 1.5*T.s);
geom_rechts_f.v = vector;
geom_rechts_f.P = P_rechts; 

 
                        
data.SG_Fenstertraeger_links  = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_links_f, 
                        "mat", mat);
data.SG_Fenstertraeger_rechts = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_rechts_f, 
                        "mat", mat);

#S�ulen

vector = [0,1,0];
Saeulen_Seiten.w = Saeulen_Seiten_w; % 200;
Saeulen_Seiten.h = Saeulen_Seiten_h; % 250;
Saeulen_Seiten.t = Saeulen_Seiten_t; % 10;
Punkt_links = [0.5*Saeulen_Seiten.w,0];
Punkt_rechts = [-0.5*Saeulen_Seiten.w,0];

geom_links = mfs_beamsection("box", "thin", Saeulen_Seiten.w, Saeulen_Seiten.h, Saeulen_Seiten.t);
geom_links.v = vector;
geom_links.P = Punkt_links;
geom_rechts = mfs_beamsection("box", "thin", Saeulen_Seiten.w, Saeulen_Seiten.h, Saeulen_Seiten.t);
geom_rechts.v = vector;
geom_rechts.P = Punkt_rechts;

Saeule_struct_links = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_links, 
                        "mat", mat);
Saeule_struct_rechts = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_rechts, 
                        "mat", mat);                        

data.SG_A_Saeule_links  = Saeule_struct_links;
data.SG_B_Saeule_links = Saeule_struct_links;
data.SG_C_Saeule_links = Saeule_struct_links;
data.SG_D_Saeule_links = Saeule_struct_links;

                        
data.SG_A_Saeule_rechts = Saeule_struct_rechts;
data.SG_B_Saeule_rechts = Saeule_struct_rechts;
data.SG_C_Saeule_rechts = Saeule_struct_rechts;
data.SG_D_Saeule_rechts = Saeule_struct_rechts;

#Fensters�ulen

vector = [0,1,0];
Saeulen_f.w = Saeulen_f_w;
Saeulen_f.h = Saeulen_f_h;
Saeulen_f.t = Saeulen_f_t;
Punkt_links_f = [0.5*Saeulen_f.w,0];
Punkt_rechts_f = [-0.5*Saeulen_f.w,0];

geom_links = mfs_beamsection("box", "thin", Saeulen_f.w, Saeulen_f.h, Saeulen_f.t);
geom_links.v = vector;
geom_links.P = Punkt_links_f;
geom_rechts = mfs_beamsection("box", "thin", Saeulen_f.w, Saeulen_f.h, Saeulen_f.t);
geom_rechts.v = vector;
geom_rechts.P = Punkt_rechts_f;
Saeule_links_f = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_links, 
                        "mat", mat);
Saeule_rechts_f = struct("type","elements",
                        "name", "b2", 
                        "geom", geom_rechts, 
                        "mat", mat);     

data.SG_Fenstersaeulen_links = Saeule_links_f;
data.SG_Fenstersaeulen_rechts = Saeule_rechts_f;

#Dachgruppe DG

# Dachgruppe
# ------------------------------------------------------------------------------

# Fundamentaldachb�gen (Balken)

dg_fdb_beam.type                =                   "elements";
dg_fdb_beam.name                =                         "b2";
dg_fdb_beam.geom                = mfs_beamsection("box", "thick",
                                  80, 80, 20);
dg_fdb_beam.geom.v              =                    [0, 0, 1];
dg_fdb_beam.geom.P              =                   [0, -37.5];
dg_fdb_beam.mat                 =                          mat;

data.DG_Dachboegen_AD           =                  dg_fdb_beam;

# Strukturdachb�gen (Balken)

dg_sdb_beam.type                =                   "elements";
dg_sdb_beam.name                =                         "b2";
dg_sdb_beam.geom                = mfs_beamsection("I",
                                  60, 60, 3, 5);
dg_sdb_beam.geom.v              =                    [0, 0, 1];
dg_sdb_beam.geom.P              =                     [0, -32];
dg_sdb_beam.mat                 =                          mat;

data.DG_Dachboegen_BC           =                  dg_sdb_beam;
data.DG_Dachboegen              =                  dg_sdb_beam;

# L�ngstr�ger (Balken)

dg_lt_beam.type                 =                   "elements";
dg_lt_beam.name                 =                         "b2";
dg_lt_beam.geom                 = mfs_beamsection("I",
                                  10, 15, 2, 2);
dg_lt_beam.geom.Q               =                [0, 0, -2700];
dg_lt_beam.geom.P               =                    [0, 12.5];
dg_lt_beam.mat                  =                          mat;

data.DG_Laengstraeger           =                   dg_lt_beam;

# Dach (Schale)

dg_surface.type                 =                   "elements";
dg_surface.name                 =                   "s4";
dg_surface.geom.t               =                   dg_surface_geom_t;
dg_surface.mat                  =                   mat;

data.DG_Dach                    =                   dg_surface;
   
#Randbedingungen
data.Auflager = struct("type", "constraints",
                        "name", "prescribed",
                        "dofs", 3);

data.Drehzapfen =  struct("type", "constraints",
                        "name", "prescribed",
                        "dofs", 1:2);                       

fid = fopen("aufgabe2.res","wt");

model = mfs_import(fid,waggon_msh_file, "msh", data);
waggon = mfs_new(fid, model);

#Ausgabe Achsen
mfs_export("waggon.axes", "msh", waggon, "mesh", "axes");

#Matrizen berechnen

waggon                          =            mfs_stiff(waggon);
waggon                          =             mfs_mass(waggon);
mass_prop = mfs_massproperties(fid, waggon);

%refpnt = zeros(1, waggon.nodes.ncoor);
%R = mfs_rigidmotion(waggon.nodes, waggon.dofs.mxdofpnt, refpnt);
%mrr = R' * waggon.mass.M * R;
%mass = mrr(1);

#Eigenschwingungen
waggon                          =  mfs_freevib(waggon, nofmod);

lowest_energy_mode = waggon.modes.freq(1);

result = [lowest_energy_mode mass_prop.m];

disp("first frequency is:"), disp(lowest_energy_mode)

#Berechnung
% mfs_print(fid, waggon, "modes", "freq");
% mfs_export(["aufgabe2", ".dsp"], "msh", waggon, "modes", "disp");

fclose(fid);

% save("-binary", ["aufgabe2", ".dat"], "data" );

endfunction