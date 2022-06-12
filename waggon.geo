/* --------------------------------------------------------------------

                          Eisenbahnwaggon

                           Einheiten: mm

-------------------------------------------------------------------- */

/* --------------------------------------------------------------------
   Netzfeinheit 
-------------------------------------------------------------------- */

   elen = 400;  // Typische Elementlänge (wenn nötig anpassen)

/* --------------------------------------------------------------------

   Physikalische Gruppen:

   Auflager                    Points  z-Verschiebung festgehalten
   Drehzapfen                  Points  x- und y-Verschiebung 
                                       festgehalten

   H1R                         Points  z-Beschleunigung vorgeschrieben
   H1L                         Points  z-Beschleunigung vorgeschrieben
   H2R                         Points  z-Beschleunigung vorgeschrieben
   H2L                         Points  z-Beschleunigung vorgeschrieben

   Q2R                         Points  Auswertepunkt
   Q5R                         Points  Auswertepunkt
   Q8R                         Points  Auswertepunkt
   Q11R                        Points  Auswertepunkt
   Q2L                         Points  Auswertepunkt
   Q5L                         Points  Auswertepunkt
   Q8L                         Points  Auswertepunkt
   Q11L                        Points  Auswertepunkt

   Bodengruppe:

   BG_Langtraeger_rechts       Line    Langträger rechts
   BG_Langtraeger_links        Line    Langträger links
   BG_Langtraeger_innen        Line    innere Langträger
   BG_Quertraeger_AD           Line    Querträger AD
   BG_Quertraeger_BC           Line    Querträger BC
   BG_Hauptquertraeger         Line    Hauptquerträger
   BG_Quertraeger              Line    Querträger

   BG_Platte                   Surface Bodenplatte

   Seitengruppe:

   SG_A_Saeule_rechts          Line    A-Säule rechts
   SG_A_Saeule_links           Line    A-Säule links
   SG_B_Saeule_rechts          Line    B-Säule rechts
   SG_B_Saeule_links           Line    B-Säule links
   SG_C_Saeule_rechts          Line    C-Säule rechts
   SG_C_Saeule_links           Line    C-Säule links
   SG_D_Saeule_rechts          Line    D-Säule rechts
   SG_D_Saeule_links           Line    D-Säule links
   SG_Fenstersaeulen_rechts    Line    Fenstersäulen rechts
   SG_Fenstersaeulen_links     Line    Fenstersäulen links
   SG_Fenstertraeger_rechts    Line    Fensterträger rechts
   SG_Fenstertraeger_links     Line    Fensterträger links
   SG_Dachtraeger_rechts       Line    Dachträger rechts
   SG_Dachtraeger_links        Line    Dachträger links

   SG_Waende                   Surface Seitenwände

   Dachgruppe:

   DG_Dachboegen_AD            Line    Dachbögen A und D
   DG_Dachboegen_BC            Line    Dachbögen B und C
   DG_Dachboegen               Line    Dachbögen
   DG_Laengstraeger            Line    Längsträger

   DG_Dach                     Surface Dach

-------------------------------------------------------------------- */

/* --------------------------------------------------------------------
   Parameter
-------------------------------------------------------------------- */

   Mesh.RecombineAll = 1;  // viereckige Elemente erzeugen
   debug = 0;              // Ausgabe zur Kontrolle (0 oder 1)

/* --------------------------------------------------------------------
   Abmessungen
-------------------------------------------------------------------- */

   DefineConstant [
     L    = 26000,  // Länge
     B    =  2800,  // Breite
     h    =  2100,  // Höhe an den Seitenwänden
     hf   =  1000,  // Höhe des Fensterträgers
     H    =  2300,  // Höhe in der Mitte
     LHQ  =  3500,  // Abstand der Hauptquerträger von den Wagenenden
     LQ   =  1880,  // Abstand der regelmäßigen Querträger
     LQ1  =  2660,  // Abstand des ersten regelmäßigen Querträgers
     LTQ  =  1200   // Abstand des Türquerträgers von den Wagenenden
   ];

   If (debug == 1)
      Printf("Informationen zum Eisenbahnwaggon:") > "waggon.dbg";
      Printf("----------------------------------") >> "waggon.dbg";
   EndIf
   
/* --------------------------------------------------------------------
   Koordinaten und Vernetzungsparameter
-------------------------------------------------------------------- */

// Koordinaten

   x[] = {0, LTQ, LQ1, LHQ, LQ1 + LQ, LQ1 + 2 * LQ, LQ1 + 3 * LQ,
          LQ1 + 4 * LQ, LQ1 + 5 * LQ, LQ1 + 6 * LQ, LQ1 + 7 * LQ,
          LQ1 + 8 * LQ, LQ1 + 9 * LQ, LQ1 + 10 * LQ, L - LHQ,
          L - LQ1, L - LTQ, L};
   nx = #x[];

   y[] = {-0.5 * B, -0.25 * B, 0, 0.25 * B, 0.5 * B};
   ny  = #y[];

   z[] = {0, hf, h};
   nz  = #z[];

   If (debug == 1)
      Printf("Koordinaten") >> "waggon.dbg";
      For k In {0 : nx-1}
         Printf("x[%2.0f] = %5.0f", k, x[k]) >> "waggon.dbg";
      EndFor
      For k In {0 : ny-1}
         Printf("y[%2.0f] = %5.0f", k, y[k]) >> "waggon.dbg";
      EndFor
      For k In {0 : nz-1}
         Printf("z[%2.0f] = %5.0f", k, z[k]) >> "waggon.dbg";
      EndFor
   EndIf

// Vernetzung: Anzahl Knoten pro Linie

   For k In {0 : nx-2}
       npx[k] = Ceil((x[k+1] - x[k]) / elen) + 1;
   EndFor

   For k In {0 : ny-2}
       npy[k] = Ceil((y[k+1] - y[k]) / elen) + 1;
   EndFor

   For k In {0 : nz - 2}
       npz[k] = Ceil((z[k+1] - z[k]) / elen) + 1;
   EndFor

   If (debug == 1)
      Printf("Knoten pro Linie") >> "waggon.dbg";
      For k In {0 : nx-2}
         Printf("npx[%2.0f] = %2.0f", k, npx[k]) >> "waggon.dbg";
      EndFor
      For k In {0 : ny-2}
         Printf("npy[%2.0f] = %2.0f", k, npy[k]) >> "waggon.dbg";
      EndFor
      For k In {0 : nz-2}
         Printf("npz[%2.0f] = %2.0f", k, npz[k]) >> "waggon.dbg";
      EndFor
   EndIf

/* --------------------------------------------------------------------
   Bodengruppe: BG
-------------------------------------------------------------------- */

// Punkte
// ------

   For k In {0 : ny-1}
       For l In {0 : nx-1}
           p_0~{k}~{l} = newp;
           Point(p_0~{k}~{l}) = {x[l], y[k], 0};
       EndFor
   EndFor

// Langträger
// ----------

   llast = nx - 2;
   klast = ny-1;

   For k In {0 : klast}
       For l In {0 : llast}
           l_0~{k}~{l} = newl;
           Line(l_0~{k}~{l}) = {p_0~{k}~{l}, p_0~{k}~{l+1}};
       EndFor
   EndFor

   Physical Curve("BG_Langtraeger_rechts") = {l_0_0_0 : l_0_0~{llast}};
   Physical Curve("BG_Langtraeger_links") = 
     {l_0~{klast}~{0} : l_0~{klast}~{llast}};
   Physical Curve("BG_Langtraeger_innen") = 
     {l_0_1_0 : l_0~{klast-1}~{llast}};

// Querträger
// ----------

   llast = nx - 1;
   klast = ny - 2;

   For l In {0 : llast}
       For k In {0 : klast}
           q_0~{k}~{l} = newl;
           Line(q_0~{k}~{l}) = {p_0~{k}~{l}, p_0~{k+1}~{l}};
       EndFor
   EndFor

   Physical Curve("BG_Quertraeger_AD") = 
      {q_0_0_0 : q_0_3_0, q_0_0_17 : q_0_3_17};
   Physical Curve("BG_Quertraeger_BC") = 
      {q_0_0_1 : q_0_3_1, q_0_0_16 : q_0_3_16};
   Physical Curve("BG_Hauptquertraeger") =
      {q_0_0_3 : q_0_3_3, q_0_0_14 : q_0_3_14};
   
   qids[] = {2, 4 : 13, 15};
   Physical Curve("BG_Quertraeger") = {};
   nqids = #qids[];
   For k In {0 : nqids - 1}
       l = qids[k];
       Physical Curve("BG_Quertraeger") += {q_0_0~{l} : q_0_3~{l}};
   EndFor

// Bodenplatte
// -----------

   llast = nx - 2;
   klast = ny - 2;
   s1    = news;

   For k In {0 : klast}
       For l In {0 : llast}
           lopno = newll;
           Curve Loop(lopno) = {l_0~{k}~{l}, q_0~{k}~{l+1},
                                -l_0~{k+1}~{l}, -q_0~{k}~{l}};
           Plane Surface(news) = {lopno};
       EndFor
   EndFor

   Physical Surface("BG_Platte") = {s1 : news - 1};

// Vernetzung
// ----------

// Langträger

   llast = nx - 2;
   klast = ny - 1;

   For k In {0 : klast}
       For l In {0 : llast}
           Transfinite Curve {l_0~{k}~{l}} = npx[l];
       EndFor
   EndFor

// Querträger

   llast = nx - 1;
   klast = ny - 2;

   For k In {0 : klast}
       For l In {0 : llast}
           Transfinite Curve {q_0~{k}~{l}} = npy[k];
       EndFor
   EndFor

// Platte

   Transfinite Surface {s1 : news};
   
/* --------------------------------------------------------------------
   Seitengruppe: SG
-------------------------------------------------------------------- */

// Punkte
// ------

   llast = nx - 1;
   mlast = nz - 1;

   For l In {0 : llast}
       For m In {1 : mlast}
           p~{m}~{0}~{l} = newp;
           Point(p~{m}~{0}~{l}) = {x[l], y[0], z[m]};
           p~{m}~{4}~{l} = newp;
           Point(p~{m}~{4}~{l}) = {x[l], y[4], z[m]};
       EndFor
   EndFor

// Fenstertraeger
// --------------

   llast = nx - 3;

   For l In {1 : llast}
       l_1_0~{l} = newl;
       Line(l_1_0~{l}) = {p_1_0~{l}, p_1_0~{l+1}};
   EndFor

   Physical Curve("SG_Fenstertraeger_rechts") = 
     {l_1_0_1 : l_1_0~{llast}};

   For l In {1 : llast}
       l_1_4~{l} = newl;
       Line(l_1_4~{l}) = {p_1_4~{l}, p_1_4~{l+1}};
   EndFor

   Physical Curve("SG_Fenstertraeger_links") = 
     {l_1_4_1 : l_1_4~{llast}};

// Dachtraeger
// -----------

   llast = nx - 2;

   For l In {0 : llast}
       l_2_0~{l} = newl;
       Line(l_2_0~{l}) = {p_2_0~{l}, p_2_0~{l+1}};
   EndFor

   Physical Curve("SG_Dachtraeger_rechts") = 
     {l_2_0_0 : l_2_0~{llast}};

   For l In {0 : llast}
       l_2_4~{l} = newl;
       Line(l_2_4~{l}) = {p_2_4~{l}, p_2_4~{l+1}};
   EndFor

   Physical Curve("SG_Dachtraeger_links") = 
     {l_2_4_0 : l_2_4~{llast}};

// Säulen
// ------

   llast = nx - 1;
   mlast = nz - 2;
   For l In {0 : llast}
       mm[l] = mlast;
   EndFor
   mm[3]  -= 1;
   mm[14] -= 1;
   
   For l In {0 : llast}
       For m In {0 : mm[l]}
           v~{m}~{0}~{l} = newl;
           Line(v~{m}~{0}~{l}) = {p~{m}~{0}~{l}, p~{m+1}~{0}~{l}};
       EndFor
   EndFor

   Physical Curve("SG_A_Saeule_rechts") = {v_0_0_0 : v_1_0_0};
   Physical Curve("SG_B_Saeule_rechts") = {v_0_0_1 : v_1_0_1};
   Physical Curve("SG_C_Saeule_rechts") = {v_0_0_16 : v_1_0_16};
   Physical Curve("SG_D_Saeule_rechts") = {v_0_0_17 : v_1_0_17};

   Physical Curve("SG_Fenstersaeulen_rechts") = 
     {v_0_0_2 : v_1_0_2, v_0_0_4 : v_1_0_13, v_0_0_15 : v_1_0_15};
   
   For l In {0 : llast}
       For m In {0 : mm[l]}
           v~{m}~{4}~{l} = newl;
           Line(v~{m}~{4}~{l}) = {p~{m}~{4}~{l}, p~{m+1}~{4}~{l}};
       EndFor
   EndFor

   Physical Curve("SG_A_Saeule_links") = {v_0_4_0 : v_1_4_0};
   Physical Curve("SG_B_Saeule_links") = {v_0_4_1 : v_1_4_1};
   Physical Curve("SG_C_Saeule_links") = {v_0_4_16 : v_1_4_16};
   Physical Curve("SG_D_Saeule_links") = {v_0_4_17 : v_1_4_17};

   Physical Curve("SG_Fenstersaeulen_links") = 
     {v_0_4_2 : v_1_4_2, v_0_4_4 : v_1_4_13, v_0_4_15 : v_1_4_15};

// Seitenwände
// -----------

   llast = nx - 3;
   s1    = news;

   For l In {1 : llast}
       lopno = newll;
       Curve Loop(lopno) = {l_0_0~{l}, v_0_0~{l+1},
                            -l_1_0~{l}, -v_0_0~{l}};
       Plane Surface(news) = {lopno};
       lopno = newll;
       Curve Loop(lopno) = {l_0_4~{l}, v_0_4~{l+1},
                            -l_1_4~{l}, -v_0_4~{l}};
       Plane Surface(news) = {lopno};
   EndFor

   Physical Surface("SG_Waende") = {s1 : news};

// Vernetzung
// ----------

// Fensterträger

   llast = nx - 3;

   For l In {1 : llast}
       Transfinite Curve {l_1_0~{l}} = npx[l];
       Transfinite Curve {l_1_4~{l}} = npx[l];
   EndFor

// Dachträger

   llast = nx - 2;

   For l In {0 : llast}
       Transfinite Curve {l_2_0~{l}} = npx[l];
       Transfinite Curve {l_2_4~{l}} = npx[l];
   EndFor

// Säulen

   llast = nx - 1;
   
   For l In {0 : llast}
       For m In {0 : mm[l]}
           Transfinite Curve {v~{m}~{0}~{l}} = npz[m];
           Transfinite Curve {v~{m}~{4}~{l}} = npz[m];
       EndFor
   EndFor

// Wände

   Transfinite Surface {s1 : news};
   
/* --------------------------------------------------------------------
   Dachgruppe: DG
-------------------------------------------------------------------- */

// Punkte
// ------

// Geometrie

   dh = H - h;
   b  = 0.5 * B;
   R  = 0.5 * (dh + b^2 / dh);
   p  = Asin(b/R);
   p1 = 0.33 * p;

   ydg[2] = R * Sin(p1);
   ydg[1] = -ydg[2];
   zm = H - R;
   zdg[1] = zm + R * Cos(p1);
   zdg[2] = zdg[1];

// Koordinaten

   llast = nx - 1;

   For l In {0 : llast}
       m~{l} = newp;
       Point(m~{l}) = {x[l], 0, zm};
       For k In {1 : 2}
           p_2~{k}~{l} = newp;
           Point(p_2~{k}~{l}) = {x[l], ydg[k], zdg[k]};
       EndFor
       p_2_3~{l} = p_2_4~{l};
   EndFor

// Dachbögen
// ---------

   llast = nx - 1;
   klast = 2;

   For l In {0 : llast}
       For k In {0 : klast}
           q_2~{k}~{l} = newl;
           Circle(q_2~{k}~{l}) = {p_2~{k}~{l}, m~{l}, p_2~{k+1}~{l}};
       EndFor
   EndFor

   Physical Curve("DG_Dachboegen_AD") = 
     {q_2_0_0 : q_2_2_0, q_2_0_17 : q_2_2_17};
   Physical Curve("DG_Dachboegen_BC") =
     {q_2_0_1 : q_2_2_1, q_2_0_16 : q_2_2_16};
   Physical Curve("DG_Dachboegen") = 
     {q_2_0_2 : q_2_2_2, q_2_0_4 : q_2_2_13, q_2_0_15 : q_2_2_15};

// Längsträger
// -----------

   llast = nx - 2;

   For l In {0 : llast}
       For k In {1 : klast}
           l_2~{k}~{l} = newl;
           Line(l_2~{k}~{l}) = {p_2~{k}~{l}, p_2~{k}~{l+1}};
       EndFor
       l_2_3~{l} = l_2_4~{l};
   EndFor

   Physical Curve("DG_Laengstraeger") = {l_2_1_0 : l_2_2_16};

// Dachschale
// ----------

   llast = nx - 2;
   klast = 2;
   s1    = news;

   For l In {0 : llast}
       For k In {0 : klast}
           lopno = newll;
           Curve Loop(lopno) = {l_2~{k}~{l}, q_2~{k}~{l+1},
                                -l_2~{k+1}~{l}, -q_2~{k}~{l}};
           Surface(news) = {lopno};
       EndFor
   EndFor

   Physical Surface("DG_Dach") = {s1 : news};

// Vernetzung
// ----------

// Bögen

   npu = Ceil(R * p1 / elen) + 1;

   llast = nx - 1;
   klast = 2;

   For l In {0 : llast}
       For k In {0 : klast}
           Transfinite Curve {q_2~{k}~{l}} = npu;
       EndFor
   EndFor

// Längsträger

   llast = nx - 2;

   For l In {0 : llast}
       For k In {1 : 2}
           Transfinite Curve {l_2~{k}~{l}} = npx[l];
       EndFor
   EndFor

// Dach

   Transfinite Surface {s1 : news};

/* --------------------------------------------------------------------
   Einspannung
-------------------------------------------------------------------- */

// Auflageflächen (z-Verschiebung festgehalten)

   Physical Point("Auflager") = {p_0_0_3, p_0_4_3, p_0_0_14, p_0_4_14};

// Drehzapfen (x- und y-Verschiebung festgehalten)

   Physical Point("Drehzapfen") = {p_0_2_3, p_0_2_14};

/* --------------------------------------------------------------------
   Belastung
-------------------------------------------------------------------- */

   Physical Point("H1R") = {p_0_0_3};
   Physical Point("H1L") = {p_0_4_3};
   Physical Point("H2R") = {p_0_0_14};
   Physical Point("H2L") = {p_0_4_14};

/* --------------------------------------------------------------------
   Auswertepunkte
-------------------------------------------------------------------- */

   Physical Point("Q2R")  = {p_0_1_4};
   Physical Point("Q5R")  = {p_0_1_7};
   Physical Point("Q8R")  = {p_0_1_10};
   Physical Point("Q11R") = {p_0_1_13};

   Physical Point("Q2L")  = {p_0_3_4};
   Physical Point("Q5L")  = {p_0_3_7};
   Physical Point("Q8L")  = {p_0_3_10};
   Physical Point("Q11L") = {p_0_3_13};

/* --------------------------------------------------------------------
   Postprocessing
-------------------------------------------------------------------- */

// Einspannung und Belastung

   fontsize = 24;
   fonttype =  4;
   textpos  =  1;
   font = fontsize + 2^8 * fonttype + 2^16 * textpos;

   c_H1r = Point{p_0_0_3};
   c_H1l = Point{p_0_4_3};
   c_D1  = Point{p_0_2_3};
   c_H2r = Point{p_0_0_14};
   c_H2l = Point{p_0_4_14};
   c_D2  = Point{p_0_2_14};

   View "Lagerung" {
      T3(c_H1r[0], c_H1r[1], c_H1r[2], font){ "H1R" };
      T3(c_H1l[0], c_H1l[1], c_H1l[2], font){ "H1L" };
      T3(c_H2r[0], c_H2r[1], c_H2r[2], font){ "H2R" };
      T3(c_H2l[0], c_H2l[1], c_H2l[2], font){ "H2L" };
      T3(c_D1[0], c_D1[1], c_D1[2], font){ "D1" };
      T3(c_D2[0], c_D2[1], c_D2[2], font){ "D2" };
   };

// Auswertepunkte

   c_Q2r  = Point{p_0_1_4};
   c_Q5r  = Point{p_0_1_7};
   c_Q8r  = Point{p_0_1_10};
   c_Q11r = Point{p_0_1_13};
   c_Q2l  = Point{p_0_3_4};
   c_Q5l  = Point{p_0_3_7};
   c_Q8l  = Point{p_0_3_10};
   c_Q11l = Point{p_0_3_13};

   View "Auswertepunkte" {
      T3(c_Q2r[0], c_Q2r[1], c_Q2r[2], font){ "Q2R" };
      T3(c_Q5r[0], c_Q5r[1], c_Q5r[2], font){ "Q5R" };
      T3(c_Q8r[0], c_Q8r[1], c_Q8r[2], font){ "Q8R" };
      T3(c_Q11r[0], c_Q11r[1], c_Q11r[2], font){ "Q11R" };
      T3(c_Q2l[0], c_Q2l[1], c_Q2l[2], font){ "Q2L" };
      T3(c_Q5l[0], c_Q5l[1], c_Q5l[2], font){ "Q5L" };
      T3(c_Q8l[0], c_Q8l[1], c_Q8l[2], font){ "Q8L" };
      T3(c_Q11l[0], c_Q11l[1], c_Q11l[2], font){ "Q11L" };
   };
