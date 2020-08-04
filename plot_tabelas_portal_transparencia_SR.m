close all;
clear all;

data = '30-07-2020';
data_files = ['./', data, '/'];
tabela = readtable(strcat(data_files,'Mortes_Todos_Estados.csv'));
traces_choices = ['y- ';    'b- ';            'k: ';                        'm- ';       'r- ';        'y- ';  'k- '; 'g- '];
traces_choices_alt = ['y: ';    'b: ';            'k: ';                        'm: ';       'r: ';        'y: ';  'k: '; 'g: '];

legend_names = {'others'; 'COVID-19';	'unknown'; 'respiratory insufficieny'; 'pneumonia'; 'septicemia'; 'SARI'};

mes = month(tabela.DATA_OBITO);
ano = year(tabela.DATA_OBITO);
dia = day(tabela.DATA_OBITO);

data_u = tabela.DATA_OBITO;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
set(gca,'FontSize',16);
I =find(((ano==2019).*(mes<7))); % | ((ano==2019).*(mes==6).*(dia<=30)) );
t = table2array(tabela(I,2:8));
plot( data_u(I), sum(t,2), ':', 'color', [0.15 0.35 0.25], 'LineWidth',2 , 'DisplayName','total 2019');
hold;
plot( data_u(I), sum(t(:,[2,4,5,7]) ,2), '-', 'color', [0.15 0.35 0.25], 'LineWidth',2 , 'DisplayName','respiratory causes 2019');
I =find(((ano==2020).*(mes<7)));% | ((ano==2020).*(mes==6).*(dia<=30)) ) ;
%| ((ano==2020) & (mes<6) & (dia<=07)));
t = table2array(tabela(I,2:8));
plot( datetime(datedisp(datenum(data_u(I))-365)), sum(t,2), 'g:', 'LineWidth',2, 'DisplayName','total 2020');
plot( datetime(datedisp(datenum(data_u(I))-365)), sum(t(:,[2,4,5,7]) ,2), 'g-', 'LineWidth',2 , 'DisplayName','respiratory causes 2020');
set(gca,'FontSize',16);
datetick('x',6);
axis tight;
ylim([0 5000]) ;
leg = legend('show')
legend(gca,'boxoff')
legend(gca,'Location','Northwest')
grid on; grid minor;
title('Daily deaths in 2019 and 2020');
ylabel({'number of deaths'});
%xlabel({'date'});

I =find(((ano==2019).*(mes<7)));% | ((ano==2019).*(mes==6).*(dia<=30)) );
to_plot = [3, 5, 6, 8];
for i = 1:length(to_plot)
    value = table2array(tabela(:,to_plot(i)));
    subplot(2,1,2)
    plot( data_u(I), value(I), traces_choices(to_plot(i)-1,:), 'LineWidth',2 ,'DisplayName', [cell2mat(legend_names(to_plot(i)-1)), ' 2019']);
    if (i==1) hold; end;
end
set(gca,'FontSize',16);
legend('show')
legend(gca,'boxoff')
legend(gca,'Location','Northwest')
grid on; grid minor;
title('Daily deaths in 2019');
datetick('x',6);
axis tight;
ylim([0 1200]) ;
ylabel({'number of deaths'});

clear I
I =find((ano==2020).*(mes<7));% | ((ano==2020).*(mes==6).*(dia<=30)));
for i = 1:length(to_plot)
    value = table2array(tabela(:,to_plot(i)));
    subplot(2,1,2)
    plot( datetime(datedisp(datenum(data_u(I))-365)), value(I), traces_choices_alt(to_plot(i)-1,:), 'LineWidth',2 ,'DisplayName', [cell2mat(legend_names(to_plot(i)-1)), ' 2020']);
end
set(gca,'FontSize',16);
hlegend= legend('show')
legend(gca,'boxoff')
legend(gca,'Location','Northwest')
hlegend.NumColumns=2
grid on; grid minor;
title('Daily deaths from respiratory causes 2019 and 2020');
datetick('x',6);
axis tight;
ylim([0 1200]);
print(figure(1),[data_files,'covid19rj_comparacoes_doencas.png'],'-dpng','-r300'); 

%Estatisiticas
I19_4 =find(((ano==2019).*(mes==4)));
T19_4 = table2array(tabela(I19_4,2:8));
I19_5 =find(((ano==2019).*(mes==5)));
T19_5 = table2array(tabela(I19_5,2:8));
I19_6 =find(((ano==2019).*(mes==6)));
T19_6 = table2array(tabela(I19_6,2:8));

I20_4 =find(((ano==2020).*(mes==4)));
T20_4 = table2array(tabela(I20_4,2:8));
I20_5 =find(((ano==2020).*(mes==5)));
T20_5 = table2array(tabela(I20_5,2:8));
I20_6 =find(((ano==2020).*(mes==6)));
T20_6 = table2array(tabela(I20_6,2:8));


MTotais_19_4 = sum(sum(T19_4(:,:)));
MResp_19_4 = sum(sum(T19_4(:,[2,4,5,7])));
MCovid_19_4 = sum(sum(T19_4(:,2)));
MInsuf_resp_19_4 = sum(sum(T19_4(:,4)));
MPneumo_19_4 = sum(sum(T19_4(:,5)));
MSRAG_19_4 = sum(sum(T19_4(:,7)));
MOthers_19_4 = sum(sum(T19_4(:,1)));
MUnknown_19_4 = sum(sum(T19_4(:,3)));
MSept_19_4 = sum(sum(T19_4(:,6)));

MTotais_19_5 = sum(sum(T19_5(:,:)));
MResp_19_5 = sum(sum(T19_5(:,[2,4,5,7])));
MCovid_19_5 = sum(sum(T19_5(:,2)));
MInsuf_resp_19_5 = sum(sum(T19_5(:,4)));
MPneumo_19_5 = sum(sum(T19_5(:,5)));
MSRAG_19_5 = sum(sum(T19_5(:,7)));
MOthers_19_5 = sum(sum(T19_5(:,1)));
MUnknown_19_5 = sum(sum(T19_5(:,3)));
MSept_19_5 = sum(sum(T19_5(:,6)));

MTotais_19_6 = sum(sum(T19_6(:,:)));
MResp_19_6 = sum(sum(T19_6(:,[2,4,5,7])));
MCovid_19_6 = sum(sum(T19_6(:,2)));
MInsuf_resp_19_6 = sum(sum(T19_6(:,4)));
MPneumo_19_6 = sum(sum(T19_6(:,5)));
MSRAG_19_6 = sum(sum(T19_6(:,7)));
MOthers_19_6 = sum(sum(T19_6(:,1)));
MUnknown_19_6 = sum(sum(T19_6(:,3)));
MSept_19_6 = sum(sum(T19_6(:,6)));

MTotais_20_4 = sum(sum(T20_4(:,:)));
MResp_20_4 = sum(sum(T20_4(:,[2,4,5,7])));
MCovid_20_4 = sum(sum(T20_4(:,2)));
MInsuf_resp_20_4 = sum(sum(T20_4(:,4)));
MPneumo_20_4 = sum(sum(T20_4(:,5)));
MSRAG_20_4 = sum(sum(T20_4(:,7)));
MOthers_20_4 = sum(sum(T20_4(:,1)));
MUnknown_20_4 = sum(sum(T20_4(:,3)));
MSept_20_4 = sum(sum(T20_4(:,6)));

MTotais_20_5 = sum(sum(T20_5(:,:)));
MResp_20_5 = sum(sum(T20_5(:,[2,4,5,7])));
MCovid_20_5 = sum(sum(T20_5(:,2)));
MInsuf_resp_20_5 = sum(sum(T20_5(:,4)));
MPneumo_20_5 = sum(sum(T20_5(:,5)));
MSRAG_20_5 = sum(sum(T20_5(:,7)));
MOthers_20_5 = sum(sum(T20_5(:,1)));
MUnknown_20_5 = sum(sum(T20_5(:,3)));
MSept_20_5 = sum(sum(T20_5(:,6)));

MTotais_20_6 = sum(sum(T20_6(:,:)));
MResp_20_6 = sum(sum(T20_6(:,[2,4,5,7])));
MCovid_20_6 = sum(sum(T20_6(:,2)));
MInsuf_resp_20_6 = sum(sum(T20_6(:,4)));
MPneumo_20_6 = sum(sum(T20_6(:,5)));
MSRAG_20_6 = sum(sum(T20_6(:,7)));
MOthers_20_6 = sum(sum(T20_6(:,1)));
MUnknown_20_6 = sum(sum(T20_6(:,3)));
MSept_20_6 = sum(sum(T20_6(:,6)));

dados_ano_mes(1,:) = [MTotais_19_4, MResp_19_4, MCovid_19_4, MInsuf_resp_19_4, MPneumo_19_4, MSRAG_19_4, MOthers_19_4, MUnknown_19_4, MSept_19_4]; 
dados_ano_mes(2,:) = [MTotais_19_5, MResp_19_5, MCovid_19_5, MInsuf_resp_19_5, MPneumo_19_5, MSRAG_19_5, MOthers_19_5, MUnknown_19_5, MSept_19_5];
dados_ano_mes(3,:) = [MTotais_19_6, MResp_19_6, MCovid_19_6, MInsuf_resp_19_6, MPneumo_19_6, MSRAG_19_6, MOthers_19_6, MUnknown_19_6, MSept_19_6]; 
dados_ano_mes(4,:) = [MTotais_20_4, MResp_20_4, MCovid_20_4, MInsuf_resp_20_4, MPneumo_20_4, MSRAG_20_4, MOthers_20_4, MUnknown_20_4, MSept_20_4]; 
dados_ano_mes(5,:) = [MTotais_20_5, MResp_20_5, MCovid_20_5, MInsuf_resp_20_5, MPneumo_20_5, MSRAG_20_5, MOthers_20_5, MUnknown_20_5, MSept_20_5]; 
dados_ano_mes(6,:) = [MTotais_20_6, MResp_20_6, MCovid_20_6, MInsuf_resp_20_6, MPneumo_20_6, MSRAG_20_6, MOthers_20_6, MUnknown_20_6, MSept_20_6]; 

aumentos_Totais_percent = 100*[(MTotais_20_4-MTotais_19_4)/MTotais_19_4, (MTotais_20_5-MTotais_19_5)/MTotais_19_5, (MTotais_20_6-MTotais_19_6)/MTotais_19_6];
aumentos_Resp_percent = 100*[(MResp_20_4-MResp_19_4)/MResp_19_4, (MResp_20_5-MResp_19_5)/MResp_19_5, (MResp_20_6-MResp_19_6)/MResp_19_6];
aumentos_others_percent = 100*[(MOthers_20_4-MOthers_19_4)/MOthers_19_4, (MOthers_20_5-MOthers_19_5)/MOthers_19_5, (MOthers_20_6-MOthers_19_6)/MOthers_19_6];
aumentos_unknown_percent = 100*[(MUnknown_20_4-MUnknown_19_4)/MUnknown_19_4, (MUnknown_20_5-MUnknown_19_5)/MUnknown_19_5, (MUnknown_20_6-MUnknown_19_6)/MUnknown_19_6];
aumentos_sept_percent = 100*[(MSept_20_4-MSept_19_4)/MSept_19_4, (MSept_20_5-MSept_19_5)/MSept_19_5, (MSept_20_6-MSept_19_6)/MSept_19_6];

%pause

fileID1 = fopen([data,'_num_sint.txt'],'w');
fileID2= fopen([data,'_stats.txt'],'w');

fprintf(fileID1,'State & Month & Year & Total & Respiratory & Covid-19 & Resp. Insufficiency. & Pneumonia & SARI \\\\ \\hline \\hline \n');
fprintf(fileID1,['\\multirow{6}{*}{BR}',' & \\multirow{2}{*}{April} & 2019 & ', num2str(dados_ano_mes(1,1),'%.6g'), ' & ', num2str(dados_ano_mes(1,2),'%.6g'), ' & ',  num2str(dados_ano_mes(1,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(1,4),'%.6g'), ' & ', num2str(dados_ano_mes(1,5),'%.6g'), ' & ',  num2str(dados_ano_mes(1,6),'%.6g'), '\\\\ \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(4,1),'%.6g'), ' & ', num2str(dados_ano_mes(4,2),'%.6g'), ' & ',  num2str(dados_ano_mes(4,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(4,4),'%.6g'), ' & ', num2str(dados_ano_mes(4,5),'%.6g'), ' & ',  num2str(dados_ano_mes(4,6),'%.6g'), '\\\\ \\cline{2-9}  \n']);
fprintf(fileID1,[' ', ' & \\multirow{2}{*}{May}  & 2019 & ', num2str(dados_ano_mes(2,1),'%.6g'), ' & ', num2str(dados_ano_mes(2,2),'%.6g'), ' & ',  num2str(dados_ano_mes(2,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(2,4),'%.6g'), ' & ', num2str(dados_ano_mes(2,5),'%.6g'), ' & ',  num2str(dados_ano_mes(2,6),'%.6g'), '\\\\  \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(5,1),'%.6g'), ' & ', num2str(dados_ano_mes(5,2),'%.6g'), ' & ',  num2str(dados_ano_mes(5,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(5,4),'%.6g'), ' & ', num2str(dados_ano_mes(5,5),'%.6g'), ' & ',  num2str(dados_ano_mes(5,6),'%.6g'), '\\\\ \\cline{2-9} \n']);
fprintf(fileID1,[' ', ' & \\multirow{2}{*}{June}  & 2019 & ', num2str(dados_ano_mes(3,1),'%.6g'), ' & ', num2str(dados_ano_mes(3,2),'%.6g'), ' & ',  num2str(dados_ano_mes(3,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(3,4),'%.6g'), ' & ', num2str(dados_ano_mes(3,5),'%.6g'), ' & ',  num2str(dados_ano_mes(3,6),'%.6g'), '\\\\  \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(6,1),'%.6g'), ' & ', num2str(dados_ano_mes(6,2),'%.6g'), ' & ',  num2str(dados_ano_mes(6,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(6,4),'%.6g'), ' & ', num2str(dados_ano_mes(6,5),'%.6g'), ' & ',  num2str(dados_ano_mes(6,6),'%.6g'), '\\\\ \\hline \n']);

fprintf(fileID2,['State & Type & Month & 2019 & 2020 & Change [percent] \\\\ \\hline \\hline \n']);
fprintf(fileID2,['\\multirow{6}{*}{BR}', '& \\multirow{3}{*}{Total} & April & ', num2str(MTotais_19_4), ' & ', num2str(MTotais_20_4), ' & ', num2str(aumentos_Totais_percent(1),'%5.2f'), '\\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & May & ' , num2str(MTotais_19_5), ' & ', num2str(MTotais_20_5), ' & ',  num2str(aumentos_Totais_percent(2),'%5.2f'), '\\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & June & ' , num2str(MTotais_19_6), ' & ', num2str(MTotais_20_6), ' & ',  num2str(aumentos_Totais_percent(3),'%5.2f'), '\\\\  \\cline{2-6} \n']);
fprintf(fileID2,[' ', '& \\multirow{3}{*}{Respiratory} & April & ', num2str(MResp_19_4), ' & ', num2str(MResp_20_4), ' & ', num2str(aumentos_Resp_percent(1),'%5.2f'), ' \\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & May & ',  num2str(MResp_19_5), ' & ', num2str(MResp_20_5), ' & ', num2str(aumentos_Resp_percent(2),'%5.2f'), '\\\\ \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & June & ',  num2str(MResp_19_6), ' & ', num2str(MResp_20_6), ' & ', num2str(aumentos_Resp_percent(3),'%3$.*2g'), '\\\\ \\hline \n']);


%Fim
data_seq = zeros(27,3,2);
fig_count=2;
estados_sig = {'AC'; 'AL'; 'AM';'AP'; 'BA'; 'CE'; 'DF'; 'ES'; 'GO'; 'MA'; 'MG'; 'MS'; 'MT'; 'PA'; 'PB'; 'PE'; 'PI'; 'PR'; 'RJ'; 'RN'; 'RO'; 'RR'; 'RS'; 'SC'; 'SE'; 'SP'; 'TO'};
w_count =0;
figure;
for j = 1:length(estados_sig)
    clear tabela
    clear ano mes dia
    w_count=w_count+1;
    subplot(7,4,w_count);
    tabela = readtable(strcat(data_files,strcat(strcat('Mortes_', cell2mat(estados_sig(j,:))),'.csv'))); 
    mes = month(tabela.DATA_OBITO);
    ano = year(tabela.DATA_OBITO);
    dia = day(tabela.DATA_OBITO);
    clear I
    I =find(((ano==2019).*(mes<7)));% | ((ano==2019).*(mes==6).*(dia<=30)));
    if w_count ==1
        I'
        length(I)
    end;
    t = table2array(tabela(I,2:8));
    plot( data_u(I), sum(t,2), 'b:', 'LineWidth',2 , 'DisplayName','total 2019');
    hold;
    plot( data_u(I), sum(t(:,[2,4,5,7]) ,2), 'b-', 'LineWidth',2 , 'DisplayName','respiratory 2019');
    clear I
    I =find(((ano==2020).*(mes<7)));% | ((ano==2020).*(mes==6).*(dia<=30)) );
    %if w_count ==2
    %    I'
    %    length(I)
    %    (ano>2019)'
    %    (mes<7)'
    %    ((ano==2020).*(mes<7))'
    %end;
    t = table2array(tabela(I,2:8));
    plot( datetime(datedisp(datenum(data_u(I))-365)), sum(t,2), 'k:', 'LineWidth',2 , 'DisplayName','total 2020');
    plot( datetime(datedisp(datenum(data_u(I))-365)), sum(t(:,[2,4,5,7]) ,2), 'k-', 'LineWidth',2 , 'DisplayName','respiratory 2020');
    set(gca,'FontSize',12);
    datetick('x',3);
    axis tight;
    [Ym YM] = y_limits_analysis(0, max(sum(t,2)));
    ylim([Ym YM]);
    grid on;
    ylabel(   cell2mat(estados_sig(j)));
end;
 w_count=w_count+1;
 
legend('show')
legend(gca,'boxoff')
legend(gca,'Location','northwest') 

print(figure(fig_count),[data_files,'./covid19rj_comparacoes_doencas_estados', num2str(fig_count-1)','.png'],'-dpng','-r300'); 

for j = 1:length(estados_sig)
    clear tabela
    clear I19_4 I19_5 I19_6 I20_4 I20_5 I20_6
    clear ano mes dia
    tabela = readtable(strcat(data_files,strcat(strcat('Mortes_', cell2mat(estados_sig(j,:))),'.csv')));
    mes = month(tabela.DATA_OBITO);
    ano = year(tabela.DATA_OBITO);

  
I19_4 =find(((ano==2019).*(mes==4)));
T19_4 = table2array(tabela(I19_4,2:8));
I19_5 =find(((ano==2019).*(mes==5)));
T19_5 = table2array(tabela(I19_5,2:8));
I19_6 =find(((ano==2019).*(mes==6)));
T19_6 = table2array(tabela(I19_6,2:8));

I20_4 =find(((ano==2020).*(mes==4)));
T20_4 = table2array(tabela(I20_4,2:8));
I20_5 =find(((ano==2020).*(mes==5)));
T20_5 = table2array(tabela(I20_5,2:8));
I20_6 =find(((ano==2020).*(mes==6)));
T20_6 = table2array(tabela(I20_6,2:8));
% 
% if j==2
%     I19_4 
%     I19_5 
%     I19_6
% end;

MTotais_19_4 = sum(sum(T19_4(:,:)));
MResp_19_4 = sum(sum(T19_4(:,[2,4,5,7])));
MCovid_19_4 = sum(sum(T19_4(:,2)));
MInsuf_resp_19_4 = sum(sum(T19_4(:,4)));
MPneumo_19_4 = sum(sum(T19_4(:,5)));
MSRAG_19_4 = sum(sum(T19_4(:,7)));
MOthers_19_4 = sum(sum(T19_4(:,1)));
MUnknown_19_4 = sum(sum(T19_4(:,3)));
MSept_19_4 = sum(sum(T19_4(:,6)));

MTotais_19_5 = sum(sum(T19_5(:,:)));
MResp_19_5 = sum(sum(T19_5(:,[2,4,5,7])));
MCovid_19_5 = sum(sum(T19_5(:,2)));
MInsuf_resp_19_5 = sum(sum(T19_5(:,4)));
MPneumo_19_5 = sum(sum(T19_5(:,5)));
MSRAG_19_5 = sum(sum(T19_5(:,7)));
MOthers_19_5 = sum(sum(T19_5(:,1)));
MUnknown_19_5 = sum(sum(T19_5(:,3)));
MSept_19_5 = sum(sum(T19_5(:,6)));

MTotais_19_6 = sum(sum(T19_6(:,:)));
MResp_19_6 = sum(sum(T19_6(:,[2,4,5,7])));
MCovid_19_6 = sum(sum(T19_6(:,2)));
MInsuf_resp_19_6 = sum(sum(T19_6(:,4)));
MPneumo_19_6 = sum(sum(T19_6(:,5)));
MSRAG_19_6 = sum(sum(T19_6(:,7)));
MOthers_19_6 = sum(sum(T19_6(:,1)));
MUnknown_19_6 = sum(sum(T19_6(:,3)));
MSept_19_6 = sum(sum(T19_6(:,6)));

MTotais_20_4 = sum(sum(T20_4(:,:)));
MResp_20_4 = sum(sum(T20_4(:,[2,4,5,7])));
MCovid_20_4 = sum(sum(T20_4(:,2)));
MInsuf_resp_20_4 = sum(sum(T20_4(:,4)));
MPneumo_20_4 = sum(sum(T20_4(:,5)));
MSRAG_20_4 = sum(sum(T20_4(:,7)));
MOthers_20_4 = sum(sum(T20_4(:,1)));
MUnknown_20_4 = sum(sum(T20_4(:,3)));
MSept_20_4 = sum(sum(T20_4(:,6)));

MTotais_20_5 = sum(sum(T20_5(:,:)));
MResp_20_5 = sum(sum(T20_5(:,[2,4,5,7])));
MCovid_20_5 = sum(sum(T20_5(:,2)));
MInsuf_resp_20_5 = sum(sum(T20_5(:,4)));
MPneumo_20_5 = sum(sum(T20_5(:,5)));
MSRAG_20_5 = sum(sum(T20_5(:,7)));
MOthers_20_5 = sum(sum(T20_5(:,1)));
MUnknown_20_5 = sum(sum(T20_5(:,3)));
MSept_20_5 = sum(sum(T20_5(:,6)));

MTotais_20_6 = sum(sum(T20_6(:,:)));
MResp_20_6 = sum(sum(T20_6(:,[2,4,5,7])));
MCovid_20_6 = sum(sum(T20_6(:,2)));
MInsuf_resp_20_6 = sum(sum(T20_6(:,4)));
MPneumo_20_6 = sum(sum(T20_6(:,5)));
MSRAG_20_6 = sum(sum(T20_6(:,7)));
MOthers_20_6 = sum(sum(T20_6(:,1)));
MUnknown_20_6 = sum(sum(T20_6(:,3)));
MSept_20_6 = sum(sum(T20_6(:,6)));

dados_ano_mes(1,:) = [MTotais_19_4, MResp_19_4, MCovid_19_4, MInsuf_resp_19_4, MPneumo_19_4, MSRAG_19_4, MOthers_19_4, MUnknown_19_4, MSept_19_4]; 
dados_ano_mes(2,:) = [MTotais_19_5, MResp_19_5, MCovid_19_5, MInsuf_resp_19_5, MPneumo_19_5, MSRAG_19_5, MOthers_19_5, MUnknown_19_5, MSept_19_5];
dados_ano_mes(3,:) = [MTotais_19_6, MResp_19_6, MCovid_19_6, MInsuf_resp_19_6, MPneumo_19_6, MSRAG_19_6, MOthers_19_6, MUnknown_19_6, MSept_19_6]; 
dados_ano_mes(4,:) = [MTotais_20_4, MResp_20_4, MCovid_20_4, MInsuf_resp_20_4, MPneumo_20_4, MSRAG_20_4, MOthers_20_4, MUnknown_20_4, MSept_20_4];
dados_ano_mes(5,:) = [MTotais_20_5, MResp_20_5, MCovid_20_5, MInsuf_resp_20_5, MPneumo_20_5, MSRAG_20_5, MOthers_20_5, MUnknown_20_5, MSept_20_5];
dados_ano_mes(6,:) = [MTotais_20_6, MResp_20_6, MCovid_20_6, MInsuf_resp_20_6, MPneumo_20_6, MSRAG_20_6, MOthers_20_6, MUnknown_20_6, MSept_20_6];

aumentos_Totais_percent = 100*[(MTotais_20_4-MTotais_19_4)/MTotais_19_4, (MTotais_20_5-MTotais_19_5)/MTotais_19_5, (MTotais_20_6-MTotais_19_6)/MTotais_19_6];
aumentos_Resp_percent = 100*[(MResp_20_4-MResp_19_4)/MResp_19_4, (MResp_20_5-MResp_19_5)/MResp_19_5, (MResp_20_6-MResp_19_6)/MResp_19_6];
aumentos_others_percent = 100*[(MOthers_20_4-MOthers_19_4)/MOthers_19_4, (MOthers_20_5-MOthers_19_5)/MOthers_19_5, (MOthers_20_6-MOthers_19_6)/MOthers_19_6];
aumentos_unknown_percent = 100*[(MUnknown_20_4-MUnknown_19_4)/MUnknown_19_4, (MUnknown_20_5-MUnknown_19_5)/MUnknown_19_5, (MUnknown_20_6-MUnknown_19_6)/MUnknown_19_6];
aumentos_sept_percent = 100*[(MSept_20_4-MSept_19_4)/MSept_19_4, (MSept_20_5-MSept_19_5)/MSept_19_5, (MSept_20_6-MSept_19_6)/MSept_19_6];

fprintf(fileID1,['\\multirow{6}{*}{',cell2mat(estados_sig(j)),'}', ' & \\multirow{2}{*}{April} & 2019 & ', num2str(dados_ano_mes(1,1),'%.6g'), ' & ', num2str(dados_ano_mes(1,2),'%.6g'), ' & ',  num2str(dados_ano_mes(1,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(1,4),'%.6g'), ' & ', num2str(dados_ano_mes(1,5),'%.6g'), ' & ',  num2str(dados_ano_mes(1,6),'%.6g'), '\\\\ \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(4,1),'%.6g'), ' & ', num2str(dados_ano_mes(4,2),'%.6g'), ' & ',  num2str(dados_ano_mes(4,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(4,4),'%.6g'), ' & ', num2str(dados_ano_mes(4,5),'%.6g'), ' & ',  num2str(dados_ano_mes(4,6),'%.6g'), '\\\\ \\cline{2-9}  \n']);
fprintf(fileID1,[' ', ' & \\multirow{2}{*}{May}  & 2019 & ', num2str(dados_ano_mes(2,1),'%.6g'), ' & ', num2str(dados_ano_mes(2,2),'%.6g'), ' & ',  num2str(dados_ano_mes(2,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(2,4),'%.6g'), ' & ', num2str(dados_ano_mes(2,5),'%.6g'), ' & ',  num2str(dados_ano_mes(2,6),'%.6g'), '\\\\  \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(5,1),'%.6g'), ' & ', num2str(dados_ano_mes(5,2),'%.6g'), ' & ',  num2str(dados_ano_mes(5,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(5,4),'%.6g'), ' & ', num2str(dados_ano_mes(5,5),'%.6g'), ' & ',  num2str(dados_ano_mes(5,6),'%.6g'), '\\\\ \\cline{2-9} \n']);
fprintf(fileID1,[' ', ' & \\multirow{2}{*}{June}  & 2019 & ', num2str(dados_ano_mes(3,1),'%.6g'), ' & ', num2str(dados_ano_mes(3,2),'%.6g'), ' & ',  num2str(dados_ano_mes(3,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(3,4),'%.6g'), ' & ', num2str(dados_ano_mes(3,5),'%.6g'), ' & ',  num2str(dados_ano_mes(3,6),'%.6g'), '\\\\  \n']);
fprintf(fileID1,[' ', ' &  & 2020 & ', num2str(dados_ano_mes(6,1),'%.6g'), ' & ', num2str(dados_ano_mes(6,2),'%.6g'), ' & ',  num2str(dados_ano_mes(6,3),'%.6g'), ... 
     ' & ', num2str(dados_ano_mes(6,4),'%.6g'), ' & ', num2str(dados_ano_mes(6,5),'%.6g'), ' & ',  num2str(dados_ano_mes(6,6),'%.6g'), '\\\\ \\hline \n']);

fprintf(fileID2,['\\multirow{6}{*}{',cell2mat(estados_sig(j)),'}', '& \\multirow{3}{*}{Total} & April & ', num2str(MTotais_19_4), ' & ', num2str(MTotais_20_4), ' & ', num2str(aumentos_Totais_percent(1),'%5.2f'), '\\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & May & ' , num2str(MTotais_19_5), ' & ', num2str(MTotais_20_5), ' & ',  num2str(aumentos_Totais_percent(2),'%5.2f'), '\\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & June & ' , num2str(MTotais_19_6), ' & ', num2str(MTotais_20_6), ' & ',  num2str(aumentos_Totais_percent(3),'%5.2f'), '\\\\  \\cline{2-6} \n']);
fprintf(fileID2,[' ', '& \\multirow{3}{*}{Respiratory} & April & ', num2str(MResp_19_4), ' & ', num2str(MResp_20_4), ' & ', num2str(aumentos_Resp_percent(1),'%5.2f'), ' \\\\  \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & May & ',  num2str(MResp_19_5), ' & ', num2str(MResp_20_5), ' & ', num2str(aumentos_Resp_percent(2),'%5.2f'), '\\\\ \\cline{3-6} \n']);
fprintf(fileID2,[' ', '&  & June & ',  num2str(MResp_19_6), ' & ', num2str(MResp_20_6), ' & ', num2str(aumentos_Resp_percent(3),'%5.2f'), '\\\\ \\hline \n']);


% First number-> month
% Second number -> sequence
data_seq(j,1,1) = aumentos_Totais_percent(1);
data_seq(j,2,1) = aumentos_Totais_percent(2);
data_seq(j,3,1) = aumentos_Totais_percent(3);
data_seq(j,1,2) = aumentos_Resp_percent(1);
data_seq(j,2,2) = aumentos_Resp_percent(2);
data_seq(j,3,2) = aumentos_Resp_percent(3);
data_seq(j,1,3) = aumentos_others_percent(1);
data_seq(j,2,3) = aumentos_others_percent(2);
data_seq(j,3,3) = aumentos_others_percent(3);
data_seq(j,1,4) = aumentos_unknown_percent(1);
data_seq(j,2,4) = aumentos_unknown_percent(2);
data_seq(j,3,4) = aumentos_unknown_percent(3);
data_seq(j,1,5) = aumentos_sept_percent(1);
data_seq(j,2,5) = aumentos_sept_percent(2);
data_seq(j,3,5) = aumentos_sept_percent(3);

end;

corr_april_tot_resp = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,1,2) -mean(mean(mean(data_seq(:,1,2) ) ) ) ) ) )/ (std(data_seq(:,1,1))*std(data_seq(:,1,2)))
corr_may_tot_resp = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,2,2) -mean(mean(mean(data_seq(:,2,2))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,2,2)))
corr_june_tot_resp = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,3,2) -mean(mean(mean(data_seq(:,3,2))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,3,2)))

corr_april_tot_may_resp = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,2,2) -mean(mean(mean(data_seq(:,2,2))))) ) )/(std(data_seq(:,1,1))*std(data_seq(:,2,2)))
corr_april_tot_june_resp = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,3,2) -mean(mean(mean(data_seq(:,3,2))))) ) )/(std(data_seq(:,1,1))*std(data_seq(:,3,2)))
corr_may_tot_april_resp = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,1,2) -mean(mean(mean(data_seq(:,1,2))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,1,2)))
corr_may_tot_june_resp = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,3,2) -mean(mean(mean(data_seq(:,3,2))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,3,2)))
corr_june_tot_april_resp = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,1,2) -mean(mean(mean(data_seq(:,1,2))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,1,2)))
corr_june_tot_may_resp = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,2,2) -mean(mean(mean(data_seq(:,2,2))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,2,2)))

corr_april_tot_others = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,1,3) -mean(mean(mean(data_seq(:,1,3))))) ) )/(std(data_seq(:,1,1))*std(data_seq(:,1,3)))
corr_may_tot_others = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,2,3) -mean(mean(mean(data_seq(:,2,3))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,2,3)))
corr_june_tot_others = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,3,3) -mean(mean(mean(data_seq(:,3,3))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,3,3)))

corr_april_tot_unknown = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,1,4) -mean(mean(mean(data_seq(:,1,4))))) ) )/(std(data_seq(:,1,1))*std(data_seq(:,1,4)))
corr_may_tot_unknown = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,2,4) -mean(mean(mean(data_seq(:,2,4))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,2,4)))
corr_june_tot_unknown = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,3,4) -mean(mean(mean(data_seq(:,3,4))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,3,4)))

corr_april_tot_sept = mean(mean( (data_seq(:,1,1) -mean(mean(mean(data_seq(:,1,1))))).*(data_seq(:,1,5) -mean(mean(mean(data_seq(:,1,5))))) ) )/(std(data_seq(:,1,1))*std(data_seq(:,1,5)))
corr_may_tot_sept = mean(mean( (data_seq(:,2,1) -mean(mean(mean(data_seq(:,2,1))))).*(data_seq(:,2,5) -mean(mean(mean(data_seq(:,2,5))))) ) )/(std(data_seq(:,2,1))*std(data_seq(:,2,5)))
corr_june_tot_sept = mean(mean( (data_seq(:,3,1) -mean(mean(mean(data_seq(:,3,1))))).*(data_seq(:,3,5) -mean(mean(mean(data_seq(:,3,5))))) ) )/(std(data_seq(:,3,1))*std(data_seq(:,3,5)))


fclose(fileID1);
fclose(fileID2);


