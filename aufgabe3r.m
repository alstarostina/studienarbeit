clear;

load("aufgabe3m.dat");

file                          =       mfilename("aufgabe3r");

# Daten [N, mm]

f                             =                 1 : 1 : fmax; % Erregerfrequenzen
nb                            =                            9; % Errgerfrequenzen 
                                                              % pro Bandbreite

# Frequenzganganalyse

for lc = 1 : 4
  [waggon, f] = mfs_freqresp(waggon, f, "nband", nb, "loadcase", lc);
end

# Ausgabe der Übertragungsfunktionen
# ------------------------------------------------------------------------------

ridQ2R                        =            [nodesets.Q2R, 3];
ridQ5R                        =            [nodesets.Q5R, 3];
ridQ8R                        =            [nodesets.Q8R, 3];
ridQ11R                       =           [nodesets.Q11R, 3];

ridQ2L                        =            [nodesets.Q2L, 3];
ridQ5L                        =            [nodesets.Q5L, 3];
ridQ8L                        =            [nodesets.Q8L, 3];
ridQ11L                       =           [nodesets.Q11L, 3];

# Übertragungsfunktionen rechte Seite

HQ2R_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2R, 1);
HQ2R_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2R, 2);  
HQ2R_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2R, 3);
HQ2R_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2R, 4);           
                                
HQ5R_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5R, 1);
HQ5R_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5R, 2);  
HQ5R_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5R, 3);
HQ5R_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5R, 4);   
                                
HQ8R_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8R, 1);
HQ8R_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8R, 2);  
HQ8R_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8R, 3);
HQ8R_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8R, 4);    

HQ11R_H1R                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11R, 1);
HQ11R_H2R                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11R, 2);  
HQ11R_H1L                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11R, 3);
HQ11R_H2L                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11R, 4);                           
                        
# Übertragungsfunktionen linke Seite

HQ2L_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2L, 1);
HQ2L_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2L, 2);  
HQ2L_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2L, 3);
HQ2L_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ2L, 4);           
                                
HQ5L_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5L, 1);
HQ5L_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5L, 2);  
HQ5L_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5L, 3);
HQ5L_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ5L, 4);   
                                
HQ8L_H1R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8L, 1);
HQ8L_H2R                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8L, 2);  
HQ8L_H1L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8L, 3);
HQ8L_H2L                      = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ8L, 4);    

HQ11L_H1R                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11L, 1);
HQ11L_H2R                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11L, 2);  
HQ11L_H1L                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11L, 3);
HQ11L_H2L                     = mfs_getresp(waggon, "freqresp",
                                "acce", ridQ11L, 4);  
       
# Graphische Darstellung der Übertragungsfunktionen
# ------------------------------------------------------------------------------

# Q2R
       
figure(1, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(f, abs(HQ2R_H1R), "color", "blue",
         f, abs(HQ2R_H2R), "color", "green",
         f, abs(HQ2R_H1L), "color", "red",
         f, abs(HQ2R_H2L), "color", "cyan");                        
h = legend ("H_{Q2R-H1R}", "H_{Q2R-H2R}", "H_{Q2R-H1L}", "H_{Q2R-H2L}",
    "location", "north");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("H_{Q2R}");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_H_functions_Q2R.jpg"], "-djpg");
close;

# Q5R
       
figure(2, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(f, abs(HQ5R_H1R), "color", "blue",
         f, abs(HQ5R_H2R), "color", "green",
         f, abs(HQ5R_H1L), "color", "red",
         f, abs(HQ5R_H2L), "color", "cyan");                        
h = legend ("H_{Q5R-H1R}", "H_{Q5R-H2R}", "H_{Q5R-H1L}", "H_{Q5R-H2L}",
    "location", "north");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("H_{Q5R}");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_H_functions_Q5R.jpg"], "-djpg");
close;

# Q8R
       
figure(3, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(f, abs(HQ8R_H1R), "color", "blue",
         f, abs(HQ8R_H2R), "color", "green",
         f, abs(HQ8R_H1L), "color", "red",
         f, abs(HQ8R_H2L), "color", "cyan");                        
h = legend ("H_{Q8R-H1R}", "H_{Q8R-H2R}", "H_{Q8R-H1L}", "H_{Q8R-H2L}",
    "location", "north");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("H_{Q8R}");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_H_functions_Q8R.jpg"], "-djpg");
close;

# Q11R
       
figure(4, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(f, abs(HQ11R_H1R), "color", "blue",
         f, abs(HQ11R_H2R), "color", "green",
         f, abs(HQ11R_H1L), "color", "red",
         f, abs(HQ11R_H2L), "color", "cyan");                        
h = legend ("H_{Q11R-H1R}", "H_{Q11R-H2R}", "H_{Q11R-H1L}", "H_{Q11R-H2L}",
    "location", "north");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("H_{Q11R}");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_H_functions_Q11R.jpg"], "-djpg");
close;

# Daten speichern

save("-binary", [file, ".dat"], "f", "HQ2R_H1R", "HQ2R_H2R", "HQ2R_H1L", "HQ2R_H2L", 
     "HQ5R_H1R", "HQ5R_H2R", "HQ5R_H1L", "HQ5R_H2L", 
     "HQ8R_H1R", "HQ8R_H2R", "HQ8R_H1L", "HQ8R_H2L",
     "HQ11R_H1R", "HQ11R_H2R", "HQ11R_H1L", "HQ11R_H2L", 
     "HQ2L_H1R", "HQ2L_H2R", "HQ2L_H1L", "HQ2L_H2L",
     "HQ5L_H1R", "HQ5L_H2R", "HQ5L_H1L", "HQ5L_H2L",
     "HQ8L_H1R", "HQ8L_H2R", "HQ8L_H1L", "HQ8L_H2L", 
     "HQ11L_H1R", "HQ11L_H2R", "HQ11L_H1L", "HQ11L_H2L");
