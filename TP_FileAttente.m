
lambda = 10; %taux d'arrivé r/ms
nu = 1 / 0.08; % Taux de départ
finObs = 100; % temps de fin d'observation

i = 1;
tAttMoy = 0;
tMoySerMoy = 0;
txOccMoy = 0;
NbMoyenUtiMoy = 0;
while i < n
    a = arrive(lambda,finObs);
    d = depart(nu,a,finObs);

    %plot(arrive);
    %hold on;
    %plot(depart, 'color', 'red');
    %legend('arrives','departs');
    %hold off;

    %A vérifier 
    tAtt = CalculTpsAtt(a, d);
    tAttMoy = tAttMoy + tAtt;
    
    tMoySer = CalculTpsMoySer(a,d);
    tMoySerMoy = tMoySerMoy + tMoySer;
    
    txOcc = CalculTxOcc(a,d,finObs);
    txOccMoy = txOccMoy + txOcc;
    
    
    
    NbMoyenUti = CalculNbMoyenUti(a,d,finObs);
    NbMoyenUtiMoy = NbMoyenUtiMoy + NbMoyenUti;
%step(arrive,depart,finObs);
    i = i + 1;
end;
    tAttMoy = tAttMoy / n;
    tAttTheorique = lambda / (nu * ( nu - lambda));
    NbMoyenFilAtt = (lambda * lambda) /  (nu * (nu-lambda));
    NbMoyenSer = lambda / nu;
    NbMoyenUtilTheorique = NbMoyenFilAtt + NbMoyenSer;
    NbMoyenUtiMoy = NbMoyenUtiMoy / n;
    txOccTheorique = lambda / nu;
    txOccMoy = txOccMoy / n;
    tMoySerTheorique = 1 / nu;
    tMoySerMoy = tMoySerMoy / n;