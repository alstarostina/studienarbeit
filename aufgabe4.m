clear;

file                          =        mfilename("aufgabe4");

# Leistungs- und Kreuzleistungsdichtespektren der Anregung

load("aufgabe1.dat");
fpsd                          =                            f;

# Übertragungsfunktionen

load("aufgabe3r.dat");
fe                            =                            f;

# Spektren für die Frequenzen der Übertragungsfunktionen

GAA                           =       interp1(fpsd, Gaa, fe); % H1R
GAA(end) = 0;
GBB                           =       interp1(fpsd, Gbb, fe); % H2R
GBB(end) = 0;
GCC                           =       interp1(fpsd, Gcc, fe); % H1L
GCC(end) = 0;
GDD                           =       interp1(fpsd, Gdd, fe); % H2L
GDD(end) = 0;

GAB                           =       interp1(fpsd, Gab, fe); % H1R - H2R
GAB(end) = 0;
GAC                           =       interp1(fpsd, Gac, fe); % H1R - H1L
GAC(end) = 0;
GAD                           =       interp1(fpsd, Gad, fe); % H1R - H2L
GAD(end) = 0;
GBC                           =       interp1(fpsd, Gbc, fe); % H2R - H1L
GBC(end) = 0;
GBD                           =       interp1(fpsd, Gbd, fe); % H2R - H2L
GBD(end) = 0;
GCD                           =       interp1(fpsd, Gcd, fe); % H1L - H2L
GCD(end) = 0;

# Kontrolle der Interpolation mit Plot

figure(1, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
plot(fpsd, Gaa, "color", "blue",
     fe, GAA, "color", "red");
h = legend ("Original", "Interpoliert", "location", "northeast");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("G_{AA} [m^2 / (s^4 Hz)]");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_interpolation_check.jpg"], "-djpg");
close;

# Beitrag der Leistungsdichtespektren zur Antwort
# ------------------------------------------------------------------------------

# Q2R

GQ2R_Q2R                      =      abs(HQ2R_H1R).^2 .* GAA;


GQ2R_Q2R                      = GQ2R_Q2R ...
                                + abs(HQ2R_H2R).^2 .* GBB;
                                
GQ2R_Q2R                      = GQ2R_Q2R ...
                                + abs(HQ2R_H1L).^2 .* GCC;
                                
GQ2R_Q2R                      = GQ2R_Q2R ...
                                + abs(HQ2R_H2L).^2 .* GDD;
 
# Q5R
 
GQ5R_Q5R                      =      abs(HQ5R_H1R).^2 .* GAA;

GQ5R_Q5R                      = GQ5R_Q5R ...
                                + abs(HQ5R_H2R).^2 .* GBB;
                                
GQ5R_Q5R                      = GQ5R_Q5R ...
                                + abs(HQ5R_H1L).^2 .* GCC;
                                
GQ5R_Q5R                      = GQ5R_Q5R ...
                                + abs(HQ5R_H2L).^2 .* GDD;

# Q8R
 
GQ8R_Q8R                      =      abs(HQ8R_H1R).^2 .* GAA;

GQ8R_Q8R                      = GQ8R_Q8R ...
                                + abs(HQ8R_H2R).^2 .* GBB;
                                
GQ8R_Q8R                      = GQ8R_Q8R ...
                                + abs(HQ8R_H1L).^2 .* GCC;
                                
GQ8R_Q8R                      = GQ8R_Q8R ...
                                + abs(HQ8R_H2L).^2 .* GDD;
                                
# Q11R
 
GQ11R_Q11R                    =      abs(HQ11R_H1R).^2 .* GAA;

GQ11R_Q11R                    = GQ11R_Q11R ...
                                + abs(HQ11R_H2R).^2 .* GBB;
                                
GQ11R_Q11R                    = GQ11R_Q11R ...
                                + abs(HQ11R_H1L).^2 .* GCC;
                                
GQ11R_Q11R                    = GQ11R_Q11R ...
                                + abs(HQ11R_H2L).^2 .* GDD;
                                
# Q2L

GQ2L_Q2L                      =      abs(HQ2L_H1R).^2 .* GAA;

GQ2L_Q2L                      = GQ2L_Q2L ...
                                + abs(HQ2L_H2R).^2 .* GBB;

GQ2L_Q2L                      = GQ2L_Q2L ...
                                + abs(HQ2L_H1L).^2 .* GCC;
                                
GQ2L_Q2L                      = GQ2L_Q2L ...
                                + abs(HQ2L_H2L).^2 .* GDD;
 
# Q5L
 
GQ5L_Q5L                      =      abs(HQ5L_H1R).^2 .* GAA;

GQ5L_Q5L                      = GQ5L_Q5L ...
                                + abs(HQ5L_H2R).^2 .* GBB;
                                
GQ5L_Q5L                      = GQ5L_Q5L ...
                                + abs(HQ5L_H1L).^2 .* GCC;
                                
GQ5L_Q5L                      = GQ5L_Q5L ...
                                + abs(HQ5L_H2L).^2 .* GDD;

# Q8L
 
GQ8L_Q8L                      =      abs(HQ8L_H1R).^2 .* GAA;

GQ8L_Q8L                      = GQ8L_Q8L ...
                                + abs(HQ8L_H2R).^2 .* GBB;
                                
GQ8L_Q8L                      = GQ8L_Q8L ...
                                + abs(HQ8L_H1L).^2 .* GCC;
                                
GQ8L_Q8L                      = GQ8L_Q8L ...
                                + abs(HQ8L_H2L).^2 .* GDD;
                                
# Q11L
 
GQ11L_Q11L                    =      abs(HQ11L_H1R).^2 .* GAA;

GQ11L_Q11L                    = GQ11L_Q11L ...
                                + abs(HQ11L_H2R).^2 .* GBB;
                                
GQ11L_Q11L                    = GQ11L_Q11L ...
                                + abs(HQ11L_H1L).^2 .* GCC;
                                
GQ11L_Q11L                    = GQ11L_Q11L ...
                                + abs(HQ11L_H2L).^2 .* GDD;
                                
# Beitrag der Kreuzleistungsdichtespektren zur Antwort
# ------------------------------------------------------------------------------

# Q2R

GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H1R ...
                                .* GAB .* conj(HQ2R_H2R));
                                
                                
GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H1R ...
                                .* GAC .* conj(HQ2R_H1L));
                                
GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H1R ...
                                .* GAD .* conj(HQ2R_H2L));
                                
GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H2R ...
                                .* GBC .* conj(HQ2R_H1L)); 
                                
GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H2R ...
                                .* GBD .* conj(HQ2R_H2L));
                                
GQ2R_Q2R                      = GQ2R_Q2R + 2 * real(HQ2R_H1L ...
                                .* GCD .* conj(HQ2R_H2L)); 

# Q5R

GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H1R ...
                                .* GAB .* conj(HQ5R_H2R));
                                
GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H1R ...
                                .* GAC .* conj(HQ5R_H1L));
                                
GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H1R ...
                                .* GAD .* conj(HQ5R_H2L));
                                
GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H2R ...
                                .* GBC .* conj(HQ5R_H1L)); 
                                
GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H2R ...
                                .* GBD .* conj(HQ5R_H2L));
                                
GQ5R_Q5R                      = GQ5R_Q5R + 2 * real(HQ5R_H1L ...
                                .* GCD .* conj(HQ5R_H2L)); 

# Q8R

GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H1R ...
                                .* GAB .* conj(HQ8R_H2R));
                                
GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H1R ...
                                .* GAC .* conj(HQ8R_H1L));
                                
GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H1R ...
                                .* GAD .* conj(HQ8R_H2L));
                                
GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H2R ...
                                .* GBC .* conj(HQ8R_H1L)); 
                                
GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H2R ...
                                .* GBD .* conj(HQ8R_H2L));
                                
GQ8R_Q8R                      = GQ8R_Q8R + 2 * real(HQ8R_H1L ...
                                .* GCD .* conj(HQ8R_H2L)); 

# Q11R

GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H1R ...
                                .* GAB .* conj(HQ11R_H2R));
                                
GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H1R ...
                                .* GAC .* conj(HQ11R_H1L));
                                
GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H1R ...
                                .* GAD .* conj(HQ11R_H2L));
                                
GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H2R ...
                                .* GBC .* conj(HQ11R_H1L)); 
                                
GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H2R ...
                                .* GBD .* conj(HQ11R_H2L));
                                
GQ11R_Q11R                    = GQ11R_Q11R + 2 * real(HQ11R_H1L ...
                                .* GCD .* conj(HQ11R_H2L)); 

# Q2L

GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H1R ...
                                .* GAB .* conj(HQ2L_H2R));
                                
GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H1R ...
                                .* GAC .* conj(HQ2L_H1L));
                                
GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H1R ...
                                .* GAD .* conj(HQ2L_H2L));
                                
GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H2R ...
                                .* GBC .* conj(HQ2L_H1L)); 
                                
GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H2R ...
                                .* GBD .* conj(HQ2L_H2L));
                                
GQ2L_Q2L                      = GQ2L_Q2L + 2 * real(HQ2L_H1L ...
                                .* GCD .* conj(HQ2L_H2L)); 

# Q5L

GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H1R ...
                                .* GAB .* conj(HQ5L_H2R));
                                
GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H1R ...
                                .* GAC .* conj(HQ5L_H1L));
                                
GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H1R ...
                                .* GAD .* conj(HQ5L_H2L));
                                
GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H2R ...
                                .* GBC .* conj(HQ5L_H1L)); 
                                
GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H2R ...
                                .* GBD .* conj(HQ5L_H2L));
                                
GQ5L_Q5L                      = GQ5L_Q5L + 2 * real(HQ5L_H1L ...
                                .* GCD .* conj(HQ5L_H2L)); 

# Q8L

GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H1R ...
                                .* GAB .* conj(HQ8L_H2R));
                                
GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H1R ...
                                .* GAC .* conj(HQ8L_H1L));
                                
GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H1R ...
                                .* GAD .* conj(HQ8L_H2L));
                                
GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H2R ...
                                .* GBC .* conj(HQ8L_H1L)); 
                                
GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H2R ...
                                .* GBD .* conj(HQ8L_H2L));
                                
GQ8L_Q8L                      = GQ8L_Q8L + 2 * real(HQ8L_H1L ...
                                .* GCD .* conj(HQ8L_H2L));

# Q11L

GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H1R ...
                                .* GAB .* conj(HQ11L_H2R));
                                
GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H1R ...
                                .* GAC .* conj(HQ11L_H1L));
                                
GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H1R ...
                                .* GAD .* conj(HQ11L_H2L));
                                
GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H2R ...
                                .* GBC .* conj(HQ11L_H1L)); 
                                
GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H2R ...
                                .* GBD .* conj(HQ11L_H2L));
                                
GQ11L_Q11L                    = GQ11L_Q11L + 2 * real(HQ11L_H1L ...
                                .* GCD .* conj(HQ11L_H2L)); 

# Ausgabe

figure(2, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(fe, GQ2R_Q2R, "color", "blue",
         fe, GQ5R_Q5R, "color", "green",
         fe, GQ8R_Q8R, "color", "red",
         fe, GQ11R_Q11R, "color", "cyan");
h = legend ("G_{Q2R-Q2R}", "G_{Q5R-Q5R}", "G_{Q8R-Q8R}", "G_{Q11R-Q11R}", 
            "location", "northeast");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("G [m^2 / (s^4 Hz)]");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_Leistungsdichtespektren_rechts.jpg"], "-djpg");
close;

figure(3, "position", [100, 100, 1600, 900], "paperposition", [0, 0, 12.5, 8.5]);
semilogy(fe, GQ2L_Q2L, "color", "blue",
         fe, GQ5L_Q5L, "color", "green",
         fe, GQ8L_Q8L, "color", "red",
         fe, GQ11L_Q11L, "color", "cyan");
h = legend ("G_{Q2L-Q2L}", "G_{Q5L-Q5L}", "G_{Q8L-Q8L}", "G_{Q11L-Q11L}", 
            "location", "northeast");
legend("boxoff"); legend("left");
grid;
xlabel("f [Hz]");
ylabel("G [m^2 / (s^4 Hz)]");
set(h, "fontsize", 20);
set(gca, "fontsize", 20);
print([file, "_Leistungsdichtespektren_links.jpg"], "-djpg");
close;

# Berechnung RMS

RMS_Q2R                       =    sqrt(trapz(fe, GQ2R_Q2R));
RMS_Q5R                       =    sqrt(trapz(fe, GQ5R_Q5R));
RMS_Q8R                       =    sqrt(trapz(fe, GQ8R_Q8R));
RMS_Q11R                      =  sqrt(trapz(fe, GQ11R_Q11R));
RMS_Q2L                       =    sqrt(trapz(fe, GQ2L_Q2L));
RMS_Q5L                       =    sqrt(trapz(fe, GQ5L_Q5L));
RMS_Q8L                       =    sqrt(trapz(fe, GQ8L_Q8L));
RMS_Q11L                      =  sqrt(trapz(fe, GQ11L_Q11L));

fid                           =  fopen([file, ".res"], "wt");

fprintf(fid, "          RMS-Wert:\n\n");
fprintf(fid, "RMS_Q2R    %0.4f\n", RMS_Q2R);
fprintf(fid, "RMS_Q5R    %0.4f\n", RMS_Q5R);
fprintf(fid, "RMS_Q8R    %0.4f\n", RMS_Q8R);
fprintf(fid, "RMS_Q11R   %0.4f\n", RMS_Q11R);
fprintf(fid, "RMS_Q2L    %0.4f\n", RMS_Q2L);
fprintf(fid, "RMS_Q5L    %0.4f\n", RMS_Q5L);
fprintf(fid, "RMS_Q8L    %0.4f\n", RMS_Q8L);
fprintf(fid, "RMS_Q11L   %0.4f\n", RMS_Q11L);

fclose(fid); 