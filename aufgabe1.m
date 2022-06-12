pkg load statistics
pkg load signal

data = dlmread(["az.csv"]);

t = data(:,1);
A = data(:,2);
B = data (:,3);
C = data(:,4);
D = data (:,5);

realisierungen = data(:, 2:5);

m = mean(realisierungen);
sigma = meansq(realisierungen);
gamma = skewness(realisierungen);
beta = kurtosis(realisierungen);

# teil b
#[R, lag] = xcorr ( X, Y maxlag )
zeitschritt = t(2)-t(1);
messdauer = t(end);
maxtau = 0.05*messdauer;
maxlag = ceil(maxtau/zeitschritt);

#lag is the same so overwrite

[autcorrelation_A, lag] = xcorr ( A, maxlag );
[autcorrelation_B, lag] = xcorr ( B, maxlag );
[autcorrelation_C, lag] = xcorr ( C, maxlag );
[autcorrelation_D, lag] = xcorr ( D, maxlag );

plot(lag*zeitschritt, autcorrelation_A,
     lag*zeitschritt, autcorrelation_B,
     lag*zeitschritt, autcorrelation_C,
     lag*zeitschritt, autcorrelation_D);
     
[corr_A_B, lag] = xcorr(A, B, maxlag);
[corr_C_D, lag] = xcorr(C, D, maxlag);

figure
plot(lag*zeitschritt, autcorrelation_A,
      lag*zeitschritt, corr_A_B);
      
[max_val_auto index_auto] = max(autcorrelation_A);
[max_val_corr index_corr] = max(corr_A_B);

t1 = lag(index_auto)*zeitschritt;
t2 = lag(index_corr)*zeitschritt;

delta_t = t2 - t1;
v = 19/delta_t; #Geschwindigkeit [v] = m/s

#teil c

lenw = 64; %??? ???? ????????
overlap = 0.5;
fs = 1/zeitschritt;

[Gaa, f] = pwelch(A, lenw, overlap, [], fs );
[Gbb, f] = pwelch(B, lenw, overlap, [], fs );
[Gcc, f] = pwelch(C, lenw, overlap, [], fs );
[Gdd, f] = pwelch(D, lenw, overlap, [], fs );
length(f)
#loglog plot doesn't like zeros so we omit the first point
loglog(f(2:end),Gaa(2:end),
       f(2:end), Gbb(2:end),
       f(2:end), Gcc(2:end),
       f(2:end), Gdd(2:end));

sigma_LDS = [trapz(f, Gaa), trapz(f, Gbb), trapz(f, Gcc), trapz(f, Gdd)];
error = max(abs(sigma - sigma_LDS)./sigma)*100; #Genauigkeit mit der Mittelwerte übereinstimmen, 0.56 prozent 

[Gab, f] = cpsd(A, B, lenw, overlap, [], fs );
[Gac, f] = cpsd(A, C, lenw, overlap, [], fs );
[Gad, f] = cpsd(A, D, lenw, overlap, [], fs );
[Gbc, f] = cpsd(B, C, lenw, overlap, [], fs );
[Gbd, f] = cpsd(B, D, lenw, overlap, [], fs );
[Gcd, f] = cpsd(C, D, lenw, overlap, [], fs );

gab = Gab .* conj(Gab) ./ (Gaa .* Gbb);
gac = Gac .* conj(Gac) ./ (Gaa .* Gcc);
gad = Gad .* conj(Gad) ./ (Gaa .* Gdd);

figure
semilogx(f(2 : end), gab(2 : end), "color", "blue",
         f(2 : end), gac(2 : end), "color", "green",
         f(2 : end), gad(2 : end), "color", "red");
         
save("-binary", ["aufgabe1", ".dat"], "f", "Gaa", "Gbb", "Gcc", "Gdd", "Gab", "Gac",
     "Gad", "Gbc", "Gbd", "Gcd");         
