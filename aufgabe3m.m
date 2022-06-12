clear;

load("aufgabe2_elan200.dat");

file                          =       mfilename("aufgabe3m");
fid                           =  fopen([file, ".res"], "wt");

# Daten

D                             =                         0.04; % Lehrsches
                                                              % Dämpfungsmaß

nofmod                        =                          125; % Anzahl der 
                                                              % Eigenschwingungen
fmax                          =                           30; % höchste 
                                                              % Erregerfrequenz

# Vorbereitung für Berechnung der Übertragungsfunktionen
# ------------------------------------------------------------------------------

# Beschleunigungen

data.H1R.type                 =                      "loads";
data.H1R.name                 =                       "acce";
data.H1R.data                 =                    [0, 0, 1];
data.H1R.lc                   =                            1;

data.H2R.type                 =                      "loads";
data.H2R.name                 =                       "acce";
data.H2R.data                 =                    [0, 0, 1];
data.H2R.lc                   =                            2;

data.H1L.type                 =                      "loads";
data.H1L.name                 =                       "acce";
data.H1L.data                 =                    [0, 0, 1];
data.H1L.lc                   =                            3;

data.H2L.type                 =                      "loads";
data.H2L.name                 =                       "acce";
data.H2L.data                 =                    [0, 0, 1];
data.H2L.lc                   =                            4;

# Dämpfung

data.damping.type             =                     "ratios";
data.damping.data             =                            D;

# Auswertpunkte

data.Q2R.type                 =                    "nodeset";
data.Q5R.type                 =                    "nodeset";
data.Q8R.type                 =                    "nodeset";
data.Q11R.type                =                    "nodeset";

data.Q2L.type                 =                    "nodeset";
data.Q5L.type                 =                    "nodeset";
data.Q8L.type                 =                    "nodeset";
data.Q11L.type                =                    "nodeset";

# Berechnung
# ------------------------------------------------------------------------------

# msh-Datei einlesen

[model, nodesets]             = mfs_import(fid, "waggon_elan200.msh", 
                                "msh", data);
                                
# Komponente initialisieren

waggon                        =          mfs_new(fid, model);

# Matrizen

waggon                        =            mfs_stiff(waggon);
waggon                        =             mfs_mass(waggon);
mp                            = mfs_massproperties(fid, waggon);

# Eigenschwingungen

waggon                        =  mfs_freevib(waggon, nofmod);
mfs_print(fid, waggon, "modes", "freq");
mfs_export([file, ".pos"], "msh", waggon, "modes", "disp");

# Fehlerabschätzung der modalen Reduktion

mfs_reductionerror(fid, waggon, fmax);
mfs_meffmass(fid, waggon, mp.cm);

fclose(fid);

# Daten speichern

save("-binary", [file, ".dat"], "fmax", "waggon", "nodesets");
