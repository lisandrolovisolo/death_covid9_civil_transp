close all;
clear all;

set_names = {'OUTRAS'; 'COVID';	'INDETERMINADA'; 'INSUFICIENCIA_RESPIRATORIA'; 'PNEUMONIA'; 'SEPTICEMIA'; 'SRAG'};
sex_names = {'F';'M'};
age_names = {'_9';'10_19'; '20_29'; '30_39'; '40_49';'50_59';'60_69';'70_79';'80_89';'90_99';'_100';'N_I'}
age_labels = {'0-9','10-19', '20-29', '30-39', '40-49','50-59','60-69','70-79','80-89','90-99','\geq 100','N.A.'}
year_names = {'2019', '2020'}

%sexo_age_ranges_yyear_disease_names
estados_sig = {'AC'; 'AL'; 'AM';'AP'; 'BA'; 'CE'; 'DF'; 'ES'; 'GO'; 'MA'; 'MG'; 'MS'; 'MT'; 'PA'; 'PB'; 'PE'; 'PI'; 'PR'; 'RJ'; 'RN'; 'RO'; 'RR'; 'RS'; 'SC'; 'SE'; 'SP'; 'TO'};
state_choice = 'BR';

data_path = './Portal_Dataset_30-07-2020/';
data_file = [data_path, state_choice, '.csv'];

tabela_o = readtable(data_file);
%
mes = month(table2array(tabela_o(:,1)));
ano = year(table2array(tabela_o(:,1)));
dia = day(table2array(tabela_o(:,1)))

%I = find((mes<6) | ((mes==6)&(dia<=15)));
I = find((mes<=6));% | ((mes==6)&(dia<=15)));

tabela = tabela_o(I,:);



column_names = tabela.Properties.VariableNames;
N_cols = size(column_names,2);

%line 1 -> F, line 2 -> M
total_2019 = zeros(3,length(age_names));
total_2020 = zeros(3,length(age_names));
outras_2019 = zeros(3,length(age_names));
outras_2020 = zeros(3,length(age_names));
covid_2019 = zeros(3,length(age_names));
covid_2020 = zeros(3,length(age_names));
indet_2019 = zeros(3,length(age_names));
indet_2020 = zeros(3,length(age_names));
insuf_resp_2019 = zeros(3,length(age_names));
insuf_resp_2020 = zeros(3,length(age_names));
pneumo_2019 = zeros(3,length(age_names));
pneumo_2020 = zeros(3,length(age_names));
sept_2019 = zeros(3,length(age_names));
sept_2020 = zeros(3,length(age_names));
sars_2019 = zeros(3,length(age_names));
sars_2020 = zeros(3,length(age_names));

for set_number=1:length(set_names),
    set_names(set_number)
    for sex_number=1:2,
        for age_number =1:length(age_names)
            name_comp_2019 = [cell2mat(sex_names(sex_number)),'_',cell2mat(age_names(age_number)),'_2019_', cell2mat(set_names(set_number))];
            name_comp_2020 = [cell2mat(sex_names(sex_number)),'_',cell2mat(age_names(age_number)),'_2020_', cell2mat(set_names(set_number))];
            c_2019 =0; c_2020=0;
            for n = 1:N_cols,
                if (strcmp(cell2mat(column_names(:,n)),name_comp_2019)==1)
                    c_2019 = n;
                elseif (strcmp(cell2mat(column_names(:,n)),name_comp_2020)==1)
                    c_2020 = n;
                end
            end
            if(c_2019~=0)
                if (set_number==1)
                    outras_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==2)
                    covid_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==3)
                    indet_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==4)
                    insuf_resp_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==5)
                    pneumo_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==6)
                    sept_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                elseif (set_number==7)
                    sars_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                end;
            end;
            if(c_2020~=0)
                if (set_number==1)
                    outras_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==2)
                    covid_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==3)
                    indet_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==4)
                    insuf_resp_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==5)
                    pneumo_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==6)
                    sept_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                elseif (set_number==7)
                    sars_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                end;
            end;
        end;
    end;
end;

outras_2019(3,:) = sum(outras_2019,1); 
outras_2020(3,:) = sum(outras_2020,1);
covid_2019(3,:) = sum(covid_2019,1); 
covid_2020(3,:) = sum(covid_2020,1); 
indet_2019(3,:) = sum(indet_2019,1);
indet_2020(3,:) = sum(indet_2020,1);
insuf_resp_2019(3,:) = sum(insuf_resp_2019,1);
insuf_resp_2020(3,:) = sum(insuf_resp_2020,1);
pneumo_2019(3,:) = sum(pneumo_2019,1);
pneumo_2020(3,:) = sum(pneumo_2020,1);
sept_2019(3,:) = sum(sept_2019,1);
sept_2020(3,:) = sum(sept_2020,1);
sars_2019(3,:) = sum(sars_2019,1);
sars_2020(3,:) = sum(sars_2020,1);

total_2019= outras_2019+covid_2019+indet_2019+insuf_resp_2019+pneumo_2019+sept_2019+sars_2019;
total_2020= outras_2020+covid_2020+indet_2020+insuf_resp_2020+pneumo_2020+sept_2020+sars_2020;
tot_resp_2019 = covid_2019 + insuf_resp_2019 + pneumo_2019 + sars_2019;
tot_resp_2020 = covid_2020 + insuf_resp_2020 + pneumo_2020 + sars_2020;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1);
data = [cumsum(total_2020(1,:))'];
hb = bar(data,1,'grouped'); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[.5 .0 .0])
hb(1).LineWidth = 1;
hb(1).EdgeColor = [.5 .0 .0];
hold;
data = [cumsum(total_2019(1,:))'];
hb = bar(data,1,'grouped'); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[.8 0 .0])
hb(1).LineWidth = 1;
hb(1).EdgeColor = [.8 0 .0];
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(cumsum(total_2020(1,:)))); ymin = min(min(cumsum(total_2020(1,:))));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths');
ylim([Ym1 YM1]);

subplot(2,2,2);
data = [cumsum(total_2020(1,:))'];
hb = bar(data,1,'grouped'); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 .5 .0])
hb(1).LineWidth = 1;
hb(1).EdgeColor = [0 .5 .0];
hold;
data = [cumsum(total_2019(1,:))'];
hb = bar(data,1,'grouped'); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 .8 .0])
hb(1).LineWidth = 1;
hb(1).EdgeColor = [0 .8 .0];
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(cumsum(total_2020(2,:)))); ymin = min(min(cumsum(total_2020(2,:))));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths');
ylim([Ym1 YM1]);



figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
data = [total_2019(1,:)', total_2020(1,:)', total_2019(2,:)',  total_2020(2,:)'];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[.5 .0 .0])
set(hb(2), 'FaceColor',[.75 .0 .0])
set(hb(3), 'FaceColor',[.0 .0 .5])
set(hb(4), 'FaceColor',[.0 .0 .75])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data)); ymin = min(min(data));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths');
ylim([Ym1 YM1]);
title({['Number of deaths in ', state_choice, ' from Jan to June']});
set(gca,'FontSize',12); legend('female, 2019','female, 2020', 'male, 2019','male 2020', 'Location','northwest');

subplot(3,1,2)
data = [total_2020(1,:)'-total_2019(1,:)', tot_resp_2020(1,:)'-tot_resp_2019(1,:)', covid_2020(1,:)',  total_2020(2,:)'-total_2019(2,:)', tot_resp_2020(2,:)'-tot_resp_2019(2,:)', covid_2020(2,:)'];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[.8 .0 .0])
set(hb(2), 'FaceColor',[.6 .0 .0])
set(hb(3), 'FaceColor',[.4 .0 .0])
set(hb(4), 'FaceColor',[.0 .0 .8])
set(hb(5), 'FaceColor',[.0 .0 .6])
set(hb(6), 'FaceColor',[.0 .0 .4])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data));
ymin = min(min(data));
[Ym YM] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('change in the number of deaths');
ylim([Ym YM]);
title({['Change in the number of deaths in ', state_choice, ' from Jan to June, 2020 w.r.t 2019']});
set(gca,'FontSize',12); legend('female','female respiratory','female Covid','male','male respiratory','male Covid','Location','northwest');

subplot(3,1,3)
data = [100*((total_2020(1,:)-total_2019(1,:))./total_2019(1,:))', 100*((tot_resp_2020(1,:)-tot_resp_2019(1,:))./tot_resp_2019(1,:))', 100*((total_2020(2,:)-total_2019(2,:))./total_2019(2,:))', 100*((tot_resp_2020(2,:)-tot_resp_2019(2,:))./tot_resp_2019(2,:))'];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[.75 .0 .0])
set(hb(2), 'FaceColor',[.5 .0 .0])
set(hb(3), 'FaceColor',[.0 .0 .75])
set(hb(4), 'FaceColor',[.0 .0 .5])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data));
ymin = min(min(data));
[Ym YM] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('percentage change');
ylim([Ym YM]);
title({['Percentual change in number of deaths (and from respiratory causes) in ', state_choice, ' from Jan to June, 2020 w.r.t 2019']});
set(gca,'FontSize',12); legend('female total','female respiratory','male total','male respiratory', 'Location','northwest');

print(figure(2),[data_path,'./covid19rj_death_sex_age_',state_choice,'.png'],'-dpng','-r300'); 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
data_F=[indet_2019(1,:)', outras_2019(1,:)', sept_2019(1,:)',  insuf_resp_2019(1,:)', pneumo_2019(1,:)', sars_2019(1,:)']
hb = bar(data_F,'stacked')
set(hb(1),'FaceColor',[.0 .0 1.0])
set(hb(2),'FaceColor',[.0 .0 .60])
set(hb(3),'FaceColor',[.0 .0 .30])
set(hb(4),'FaceColor',[.0 1. .0])
set(hb(5),'FaceColor',[.0 .60 .0])
set(hb(6),'FaceColor',[1. .0 .0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_F,2));
ymin = min(sum(data_F,2));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym1 YM1]);
set(gca,'FontSize',12); legend('unknown', 'others','septicemia', 'respiratory insufficiency',  'pneumonia', 'SARI','Location','northwest');
title(['Female deaths in ', state_choice, ' from Jan to June, 2019']);
%hold;

subplot(2,2,3)
data_M=[indet_2019(2,:)', outras_2019(2,:)', sept_2019(2,:)', insuf_resp_2019(2,:)', pneumo_2019(2,:)', sars_2019(2,:)'];
hb = bar(data_M,'stacked')
set(hb(1),'FaceColor',[.0 .0 1.0])
set(hb(2),'FaceColor',[.0 .0 .60])
set(hb(3),'FaceColor',[.0 .0 .30])
set(hb(4),'FaceColor',[.0 1. .0])
set(hb(5),'FaceColor',[.0 .60 .0])
set(hb(6),'FaceColor',[1. .0 .0])
set(gca,'FontSize',12); legend('unknown', 'others','septicemia', 'respiratory insufficiency',  'pneumonia', 'SARI','Location','northwest');
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_M,2));
ymin = min(sum(data_M,2));
[Ym2 YM2] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym2 YM2]);
title(['Male deaths in ', state_choice, ' from Jan to June, 2019']);

subplot(2,2,2)
data_F=[indet_2020(1,:)', outras_2020(1,:)', sept_2020(1,:)', insuf_resp_2020(1,:)', pneumo_2020(1,:)', sars_2020(1,:)', covid_2020(1,:)'];
hb = bar(data_F,'stacked')
set(hb(1),'FaceColor',[.0 .0 1.0])
set(hb(2),'FaceColor',[.0 .0 .60])
set(hb(3),'FaceColor',[.0 .0 .30])
set(hb(4),'FaceColor',[.0 1. .0])
set(hb(5),'FaceColor',[.0 .60 .0])
set(hb(6),'FaceColor',[1. .0 .0])
set(hb(7),'FaceColor',[.60 .0 .0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_F,2));
ymin = min(sum(data_F,2));
[Ym3 YM3] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym3 YM3]);
set(gca,'FontSize',12); legend('unknown', 'others','septicemia', 'respiratory insufficiency',  'pneumonia', 'SARI', 'Covid','Location','northwest');
title(['Female deaths in ', state_choice, ' from Jan to June, 2020']);

subplot(2,2,4)
data_M=[indet_2020(2,:)',outras_2020(2,:)', sept_2020(2,:)', insuf_resp_2020(2,:)', pneumo_2020(2,:)', sars_2020(2,:)', covid_2020(1,:)']
hb = bar(data_M,'stacked')
set(hb(1),'FaceColor',[.0 .0 1.0])
set(hb(2),'FaceColor',[.0 .0 .60])
set(hb(3),'FaceColor',[.0 .0 .30])
set(hb(4),'FaceColor',[.0 1. .0])
set(hb(5),'FaceColor',[.0 .60 .0])
set(hb(6),'FaceColor',[1. .0 .0])
set(hb(7),'FaceColor',[.60 .0 .0])
set(gca,'FontSize',12); legend('unknown', 'others','septicemia', 'respiratory insufficiency',  'pneumonia', 'SARI', 'Covid','Location','northwest');
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_M,2));
ymin = min(sum(data_M,2));
[Ym4 YM4] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym4 YM4]);
title(['Male deaths in ', state_choice, ' from Jan to June, 2020']);

Ym = min([Ym1 Ym2 Ym3 Ym4]);
YM = max([YM1 YM2 YM3 YM4]);
subplot(2,2,1); ylim([Ym YM]);
subplot(2,2,2); ylim([Ym YM]);
subplot(2,2,3); ylim([Ym YM]);
subplot(2,2,4); ylim([Ym YM]);

print(figure(3),[data_path,'./covid19rj_death_sex_age_causes',state_choice,'.png'],'-dpng','-r300'); 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
data_F=[insuf_resp_2019(1,:)', pneumo_2019(1,:)', sars_2019(1,:)']
hb = bar(data_F,'stacked');
set(hb(1),'FaceColor',[.0 1. .0])
set(hb(2),'FaceColor',[.0 .60 .0])
set(hb(3),'FaceColor',[1. .0 .0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_F,2));
ymin = min(sum(data_F,2));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym1 YM1]);
set(gca,'FontSize',12); legend('respiratory insufficiency',  'pneumonia', 'SARI', 'Location','northwest');
title({['Female deaths by respiratory causes in ', state_choice];'from Jan to June, 2019'});

subplot(2,2,3)
data_M=[insuf_resp_2019(2,:)', pneumo_2019(2,:)', sars_2019(2,:)']
hb = bar(data_M,'stacked')
set(hb(1),'FaceColor',[.0 1. .0])
set(hb(2),'FaceColor',[.0 .60 .0])
set(hb(3),'FaceColor',[1. .0 .0])
set(gca,'FontSize',12); legend('respiratory insufficiency',  'pneumonia', 'SARI', 'Location','northwest');
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_M,2));
ymin = min(sum(data_M,2));
[Ym2 YM2] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym2 YM2]);
title({['Male deaths by respiratory causes in ', state_choice];'from Jan to June, 2019'});

subplot(2,2,2)
data_F=[insuf_resp_2020(1,:)', pneumo_2020(1,:)', sars_2020(1,:)', covid_2020(1,:)']
hb = bar(data_F,'stacked')
set(hb(1),'FaceColor',[.0 1. .0])
set(hb(2),'FaceColor',[.0 .60 .0])
set(hb(3),'FaceColor',[1. .0 .0])
set(hb(4),'FaceColor',[.6 .0 .0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_F,2));
ymin = min(sum(data_F,2));
[Ym3 YM3] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym3 YM3]);
set(gca,'FontSize',12); legend('respiratory insufficiency',  'pneumonia', 'SARI', 'Covid','Location','northwest');
title({['Female deaths by respiratory causes in ', state_choice];'from Jan to June, 2020'});

subplot(2,2,4)
data_M=[insuf_resp_2020(2,:)', pneumo_2020(2,:)', sars_2020(2,:)', covid_2020(1,:)']
hb = bar(data_M,'stacked')
set(hb(1),'FaceColor',[.0 1. .0])
set(hb(2),'FaceColor',[.0 .60 .0])
set(hb(3),'FaceColor',[1. .0 .0])
set(hb(4),'FaceColor',[.6 .0 .0])
set(gca,'FontSize',12); legend('respiratory insufficiency',  'pneumonia', 'SARI', 'Covid', 'Location','northwest');
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(sum(data_M,2));
ymin = min(sum(data_M,2));
[Ym4 YM4] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym4 YM4]);
title({['Male deaths by respiratory causes in ', state_choice];'from Jan to June, 2020'});

Ym = min([Ym1 Ym2 Ym3 Ym4]);
YM = max([YM1 YM2 YM3 YM4]);
subplot(2,2,1); ylim([Ym YM]);
subplot(2,2,2); ylim([Ym YM]);
subplot(2,2,3); ylim([Ym YM]);
subplot(2,2,4); ylim([Ym YM]);

print(figure(4),[data_path,'./covid19rj_death_sex_age_resp_causes',state_choice,'.png'],'-dpng','-r300'); 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
data = [insuf_resp_2019(1,:)',insuf_resp_2020(1,:)',  pneumo_2019(1,:)', pneumo_2020(1,:)', sars_2019(1,:)', sars_2020(1,:)', covid_2019(1,:)', covid_2020(1,:)' ];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 1 0])
set(hb(2), 'FaceColor',[0 .8 0])
set(hb(3), 'FaceColor',[0 .6 0])
set(hb(4), 'FaceColor',[0 .4 0])
set(hb(5), 'FaceColor',[1 0 0])
set(hb(6), 'FaceColor',[.8 0 0])
set(hb(7), 'FaceColor',[.6 0 0])
set(hb(8), 'FaceColor',[.4 0 0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data)); ymin = min(min(data));
[Ym1 YM1] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym1 YM1]);
title({'Female deaths by respiratory causes'; ['in ', state_choice, ' from Jan to June, 2019 and 2020']});
set(gca,'FontSize',12); legend('respiratory insufficiency 2019', 'respiratory insufficiency 2020', 'pneumonia 2019', 'pneumonia 2020', 'SARI 2019', 'SARI 2020', 'Covid 2019', 'Covid 2020', 'Location','northwest');

subplot(2,2,2)
data = [insuf_resp_2019(2,:)',insuf_resp_2020(2,:)',  pneumo_2019(2,:)', pneumo_2020(2,:)', sars_2019(2,:)', sars_2020(2,:)', covid_2019(2,:)', covid_2020(2,:)'];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 1 0])
set(hb(2), 'FaceColor',[0 .8 0])
set(hb(3), 'FaceColor',[0 .6 0])
set(hb(4), 'FaceColor',[0 .4 0])
set(hb(5), 'FaceColor',[1 0 0])
set(hb(6), 'FaceColor',[.8 0 0])
set(hb(7), 'FaceColor',[.6 0 0])
set(hb(8), 'FaceColor',[.4 0 0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data)); ymin = min(min(data));
[Ym2 YM2] = y_limits_analysis(ymin, ymax); set(gca,'FontSize',12); ylabel('number of deaths')
ylim([Ym2 YM2]);
title({'Male deaths by respiratory causes'; ['in ', state_choice, ' from Jan to June, 2019 and 2020']});
set(gca,'FontSize',12); legend('respiratory insufficiency 2019', 'respiratory insufficiency 2020', 'pneumonia 2019', 'pneumonia 2020', 'SARI 2019', 'SARI 2020', 'Covid 2019', 'Covid 2020','Location','northwest');
Ym = min([Ym1 Ym2]);
YM = max([YM1 YM2]);
subplot(2,2,1); ylim([Ym YM]);
subplot(2,2,2); ylim([Ym YM]);

subplot(2,2,3)
data = [insuf_resp_2020(1,:)'-insuf_resp_2019(1,:)',  pneumo_2020(1,:)'-pneumo_2019(1,:)', sars_2020(1,:)' - sars_2019(1,:)', covid_2020(1,:)' - covid_2019(1,:)' ];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 1 0])
set(hb(2), 'FaceColor',[0 .6 0])
set(hb(3), 'FaceColor',[1 0 0])
set(hb(4), 'FaceColor',[.6 0 0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data)); ymin = min(min(data)); set(gca,'FontSize',12); ylabel('change in the number of deaths');
[Ym1 YM1] = y_limits_analysis(ymin, ymax);
ylim([Ym1 YM1]);
title({'Change in the number of female deaths by respiratory causes'; ['in ', state_choice, ' from Jan to June, 2020 w.r.t 2019']});
set(gca,'FontSize',12); legend('respiratory insufficiency','pneumonia', 'SARI','Covid', 'Location','northwest');

subplot(2,2,4)
data = [insuf_resp_2020(2,:)' - insuf_resp_2019(2,:)',  pneumo_2020(2,:)' - pneumo_2019(2,:)', sars_2020(2,:)' - sars_2019(2,:)', covid_2020(2,:)' - covid_2019(2,:)'];
hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
set(hb(1), 'FaceColor',[0 1 0])
set(hb(2), 'FaceColor',[0 .6 0])
set(hb(3), 'FaceColor',[1 0 0])
set(hb(4), 'FaceColor',[.6 0 0])
xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
ymax = max(max(data)); ymin = min(min(data)); set(gca,'FontSize',12); ylabel('change in the  number of deaths');
[Ym2 YM2] = y_limits_analysis(ymin, ymax);
ylim([Ym2 YM2]);
title({'Change in the number of male deaths by respiratory causes'; ['in ', state_choice, ' from Jan to June, 2020 w.r.t 2019']});
set(gca,'FontSize',12); legend('respiratory insufficiency','pneumonia', 'SARI','Covid', 'Location','northwest');
Ym = min([Ym1 Ym2]);
YM = max([YM1 YM2]);
subplot(2,2,3); ylim([Ym YM]);
subplot(2,2,4); ylim([Ym YM]);

print(figure(5),[data_path,'./covid19rj_death_sex_age_resp_causes_analysis',state_choice,'.png'],'-dpng','-r300'); 



fileID1 = fopen([data_path,'age_ranges_sint_anal.txt'],'w');
fprintf(fileID1,'\\multirow{2}{*}{State} & \\multirow{2}{*}{Year} & \\multirow{2}{*}{Cause} & \\multicolumn{13}{|c|}{Age ranges} \\\\ \\cline{4-16} \n');
fprintf(fileID1,' & & & all & 0--9 & 10--19 & 20--29 & 30--39 & 40--49 & 50--59 & 60--69 & 70--79 & 80-89 & 90--99 & \\geq 100 & N.A. \\\\ \\hline \\hline \n');

for state_ind = 1:27,
    state_choice = cell2mat(estados_sig(state_ind));
    data_file = [data_path, state_choice, '.csv'];
    tabela_o = readtable(data_file);
    mes = month(table2array(tabela_o(:,1)));
    ano = year(table2array(tabela_o(:,1)));
    dia = day(table2array(tabela_o(:,1)))
    
    %I = find((mes<6) | ((mes==6)&(dia<=15)));
    I = find((mes<=6));% | ((mes==6)&(dia<=15)));
    
    tabela = tabela_o(I,:);
    
    column_names = tabela.Properties.VariableNames;
    N_cols = size(column_names,2);
    
    %line 1 -> F, line 2 -> M
    total_2019 = zeros(3,length(age_names));
    total_2020 = zeros(3,length(age_names));
    outras_2019 = zeros(3,length(age_names));
    outras_2020 = zeros(3,length(age_names));
    covid_2019 = zeros(3,length(age_names));
    covid_2020 = zeros(3,length(age_names));
    indet_2019 = zeros(3,length(age_names));
    indet_2020 = zeros(3,length(age_names));
    insuf_resp_2019 = zeros(3,length(age_names));
    insuf_resp_2020 = zeros(3,length(age_names));
    pneumo_2019 = zeros(3,length(age_names));
    pneumo_2020 = zeros(3,length(age_names));
    sept_2019 = zeros(3,length(age_names));
    sept_2020 = zeros(3,length(age_names));
    sars_2019 = zeros(3,length(age_names));
    sars_2020 = zeros(3,length(age_names));
    
    for set_number=1:length(set_names),
        set_names(set_number)
        for sex_number=1:2,
            for age_number =1:length(age_names)
                name_comp_2019 = [cell2mat(sex_names(sex_number)),'_',cell2mat(age_names(age_number)),'_2019_', cell2mat(set_names(set_number))];
                name_comp_2020 = [cell2mat(sex_names(sex_number)),'_',cell2mat(age_names(age_number)),'_2020_', cell2mat(set_names(set_number))];
                c_2019 =0; c_2020=0;
                for n = 1:N_cols,
                    if (strcmp(cell2mat(column_names(:,n)),name_comp_2019)==1)
                        c_2019 = n;
                    elseif (strcmp(cell2mat(column_names(:,n)),name_comp_2020)==1)
                        c_2020 = n;
                    end
                end
                if(c_2019~=0)
                    if (set_number==1)
                        outras_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==2)
                        covid_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==3)
                        indet_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==4)
                        insuf_resp_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==5)
                        pneumo_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==6)
                        sept_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    elseif (set_number==7)
                        sars_2019(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2019))));
                    end;
                end;
                if(c_2020~=0)
                    if (set_number==1)
                        outras_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==2)
                        covid_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==3)
                        indet_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==4)
                        insuf_resp_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==5)
                        pneumo_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==6)
                        sept_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    elseif (set_number==7)
                        sars_2020(sex_number,age_number) = sum(sum(table2array(tabela(:,c_2020))));
                    end;
                end;
            end;
        end;
    end;
    
    outras_2019(3,:) = sum(outras_2019,1);
    outras_2020(3,:) = sum(outras_2020,1);
    covid_2019(3,:) = sum(covid_2019,1);
    covid_2020(3,:) = sum(covid_2020,1);
    indet_2019(3,:) = sum(indet_2019,1);
    indet_2020(3,:) = sum(indet_2020,1);
    insuf_resp_2019(3,:) = sum(insuf_resp_2019,1);
    insuf_resp_2020(3,:) = sum(insuf_resp_2020,1);
    pneumo_2019(3,:) = sum(pneumo_2019,1);
    pneumo_2020(3,:) = sum(pneumo_2020,1);
    sept_2019(3,:) = sum(sept_2019,1);
    sept_2020(3,:) = sum(sept_2020,1);
    sars_2019(3,:) = sum(sars_2019,1);
    sars_2020(3,:) = sum(sars_2020,1);
    
    total_2019= outras_2019+covid_2019+indet_2019+insuf_resp_2019+pneumo_2019+sept_2019+sars_2019;
    total_2020= outras_2020+covid_2020+indet_2020+insuf_resp_2020+pneumo_2020+sept_2020+sars_2020;
    tot_resp_2019 = covid_2019 + insuf_resp_2019 + pneumo_2019 + sars_2019;
    tot_resp_2020 = covid_2020 + insuf_resp_2020 + pneumo_2020 + sars_2020;
    
    p_resp_2019(state_ind,:) = tot_resp_2019(3,:)./total_2019(3,:)*100;
    a_r_2019 =  sum(tot_resp_2019(3,:))/sum(total_2019(3,:))*100;
    p_resp_2020(state_ind,:) = tot_resp_2020(3,:)./total_2020(3,:)*100;
    a_r_2020 =  sum(tot_resp_2020(3,:))/sum(total_2020(3,:))*100;
    
    p_sept_2019(state_ind,:) = sept_2019(3,:)./total_2019(3,:)*100;
    a_s_2019 =  sum(sept_2019(3,:))/sum(total_2019(3,:))*100;
    p_sept_2020(state_ind,:) = sept_2020(3,:)./total_2020(3,:)*100;
    a_s_2020 =  sum(sept_2019(3,:))/sum(total_2020(3,:))*100;
    
    p_indet_2019(state_ind,:) = indet_2019(3,:)./total_2019(3,:)*100;
    a_i_2019 =  sum(indet_2019(3,:))/sum(total_2019(3,:))*100;
    p_indet_2020(state_ind,:) = indet_2020(3,:)./total_2020(3,:)*100;
    a_i_2020 =  sum(indet_2020(3,:))/sum(total_2020(3,:))*100;

    p_other_2019(state_ind,:) = outras_2019(3,:)./total_2019(3,:)*100;
    a_o_2019 =  sum(outras_2019(3,:))/sum(total_2019(3,:))*100;
    p_other_2020(state_ind,:) = outras_2020(3,:)./total_2020(3,:)*100;
    a_o_2020 =  sum(outras_2020(3,:))/sum(total_2019(3,:))*100;
    
 %   falta all em todas!
    
    fprintf(fileID1,['\\multirow{8}{*}{', cell2mat(estados_sig(state_ind)),'}',' &  \\multirow{4}{*}{2019} & Respiratory & ', num2str(a_r_2019,'%5.2f'), ' &', ...
        num2str(p_resp_2019(state_ind,1),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,2),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,3),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_resp_2019(state_ind,5),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,6),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,7),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_resp_2019(state_ind,9),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,10),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,11),'%5.2f'), ' &', num2str(p_resp_2019(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16}  \n']);
    fprintf(fileID1,[' & & Septicemia & ' , num2str(a_s_2019,'%5.2f'), ' &',...
        num2str(p_sept_2019(state_ind,1),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,2),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,3),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_sept_2019(state_ind,5),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,6),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,7),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_sept_2019(state_ind,9),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,10),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,11),'%5.2f'), ' &', num2str(p_sept_2019(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16}  \n']);
    fprintf(fileID1,[' & & Others & ', num2str(a_o_2019,'%5.2f'), ' &',...
        num2str(p_other_2019(state_ind,1),'%5.2f'), ' &', num2str(p_other_2019(state_ind,2),'%5.2f'), ' &', num2str(p_other_2019(state_ind,3),'%5.2f'), ' &', num2str(p_other_2019(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_other_2019(state_ind,5),'%5.2f'), ' &', num2str(p_other_2019(state_ind,6),'%5.2f'), ' &', num2str(p_other_2019(state_ind,7),'%5.2f'), ' &', num2str(p_other_2019(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_other_2019(state_ind,9),'%5.2f'), ' &', num2str(p_other_2019(state_ind,10),'%5.2f'), ' &', num2str(p_other_2019(state_ind,11),'%5.2f'), ' &', num2str(p_other_2019(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16} \n']);
    fprintf(fileID1,[' & & Unknown & ' , num2str(a_i_2019,'%5.2f'), ' &',...
        num2str(p_indet_2019(state_ind,1),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,2),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,3),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_indet_2019(state_ind,5),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,6),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,7),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_indet_2019(state_ind,9),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,10),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,11),'%5.2f'), ' &', num2str(p_indet_2019(state_ind,12),'%5.2f'), ' \\\\ \\cline{2-16} \n']);
    
    fprintf(fileID1,[' &  \\multirow{4}{*}{2020}  & Respiratory & ', num2str(a_r_2020,'%5.2f'), ' &', ...
        num2str(p_resp_2020(state_ind,1),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,2),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,3),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_resp_2020(state_ind,5),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,6),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,7),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_resp_2020(state_ind,9),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,10),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,11),'%5.2f'), ' &', num2str(p_resp_2020(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16}  \n']);
    fprintf(fileID1,[' & & Septicemia & ' , num2str(a_s_2020,'%5.2f'), ' &', ...
        num2str(p_sept_2020(state_ind,1),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,2),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,3),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_sept_2020(state_ind,5),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,6),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,7),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_sept_2020(state_ind,9),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,10),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,11),'%5.2f'), ' &', num2str(p_sept_2020(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16}  \n']);
    fprintf(fileID1,[' & & Others & ', num2str(a_o_2020,'%5.2f'), ' &', ...
        num2str(p_other_2020(state_ind,1),'%5.2f'), ' &', num2str(p_other_2020(state_ind,2),'%5.2f'), ' &', num2str(p_other_2020(state_ind,3),'%5.2f'), ' &', num2str(p_other_2020(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_other_2020(state_ind,5),'%5.2f'), ' &', num2str(p_other_2020(state_ind,6),'%5.2f'), ' &', num2str(p_other_2020(state_ind,7),'%5.2f'), ' &', num2str(p_other_2020(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_other_2020(state_ind,9),'%5.2f'), ' &', num2str(p_other_2020(state_ind,10),'%5.2f'), ' &', num2str(p_other_2020(state_ind,11),'%5.2f'), ' &', num2str(p_other_2020(state_ind,12),'%5.2f'), ' \\\\ \\cline{3-16}  \n']);
    fprintf(fileID1,[' & & Unknown & ', num2str(a_i_2020,'%5.2f'), ' &', ...
        num2str(p_indet_2020(state_ind,1),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,2),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,3),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,4),'%5.2f'), ' &', ...
        num2str(p_indet_2020(state_ind,5),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,6),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,7),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,8),'%5.2f'), ' &', ...
        num2str(p_indet_2020(state_ind,9),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,10),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,11),'%5.2f'), ' &', num2str(p_indet_2020(state_ind,12),'%5.2f'), ' \\\\ \\hline  \n']);    
end
fclose(fileID1);


% % subplot(3,2,5)
% % data = 100*[(insuf_resp_2020(1,:)'-insuf_resp_2019(1,:)')./insuf_resp_2019(1,:)',  (pneumo_2020(1,:)'-pneumo_2019(1,:)')./pneumo_2019(1,:)', (sars_2020(1,:)' - sars_2019(1,:)')./sars_2019(1,:)', (covid_2020(1,:)' - covid_2019(1,:)')./covid_2019(1,:)' ];
% % hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% % set(hb(1), 'FaceColor',[.8 .8 .8])
% % set(hb(2), 'FaceColor',[.6 .6 .6])
% % set(hb(3), 'FaceColor',[.4 .4 .4])
% % set(hb(4), 'FaceColor',[.2 .2 .2])
% % xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% % ymax = max(max(data)); ymin = min(min(data));
% % [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% % ylim([Ym1 YM1]);
% % title('[%] increase in respiratory causes female deaths from 2019 to 2020 (jan to may)')
% % set(gca,'FontSize',12); legend('respiratory insufficiency','pneumonia', 'sars','covid', 'Location','northwest');
% % 
% % subplot(3,2,6)
% % data = 100*[(insuf_resp_2020(2,:)' - insuf_resp_2019(2,:)')./insuf_resp_2019(2,:)',  (pneumo_2020(2,:)' - pneumo_2019(2,:)')./pneumo_2019(2,:)', (sars_2020(2,:)' - sars_2020(2,:)')./sars_2019(2,:)', (covid_2020(2,:)' - covid_2019(2,:)')./covid_2019(2,:)'];
% % hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% % set(hb(1), 'FaceColor',[.8 .8 .8])
% % set(hb(2), 'FaceColor',[.6 .6 .6])
% % set(hb(3), 'FaceColor',[.4 .4 .4])
% % set(hb(4), 'FaceColor',[.2 .2 .2])
% % xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% % ymax = max(max(data)); ymin = min(min(data));
% % [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% % ylim([Ym2 YM2]);
% % title('[%] increase in respiratory causes male deaths from 2019 to 2020 (jan to may)')
% % set(gca,'FontSize',12); legend('respiratory insufficiency','pneumonia', 'sars','covid', 'Location','northwest');
% % Ym = min([Ym1 Ym2]);
% % YM = max([YM1 YM2]);
% % subplot(3,2,5); ylim([Ym YM]);
% % subplot(3,2,6); ylim([Ym YM]);
% 
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [sars_2019(1,:)',  sars_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('SARI total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [sars_2019(2,:)',  sars_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('SARI total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM])
% 
% subplot(2,2,3)
% data = [sars_2020(1,:)'-sars_2019(1,:)',  sars_2020(2,:)'-sars_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('SARI deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((sars_2020(1,:)-sars_2019(1,:))./sars_2019(1,:))', 100*((sars_2020(2,:)-sars_2019(2,:))./sars_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('SARI deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [insuf_resp_2019(1,:)',  insuf_resp_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('respiratory insufficieny total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [insuf_resp_2019(2,:)',  insuf_resp_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('respiratory insufficieny total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,3)
% data = [insuf_resp_2020(1,:)'-insuf_resp_2019(1,:)',  insuf_resp_2020(2,:)'-insuf_resp_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('respiratory insufficieny deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((insuf_resp_2020(1,:)-insuf_resp_2019(1,:))./insuf_resp_2019(1,:))', 100*((insuf_resp_2020(2,:)-insuf_resp_2019(2,:))./insuf_resp_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('respiratory insufficieny deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM]);
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [pneumo_2019(1,:)',  pneumo_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('pneumonia total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [pneumo_2019(2,:)',  pneumo_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('pneumonia total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM]);
% 
% subplot(2,2,3)
% data = [pneumo_2020(1,:)'-pneumo_2019(1,:)',  pneumo_2020(2,:)'-pneumo_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('pneumonia deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((pneumo_2020(1,:)-pneumo_2019(1,:))./pneumo_2019(1,:))', 100*((pneumo_2020(2,:)-pneumo_2019(2,:))./pneumo_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('pneumonia deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [indet_2019(1,:)',  indet_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('unkonwn cause total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [indet_2019(2,:)',  indet_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('unkonwn cause total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM]);
% 
% subplot(2,2,3)
% data = [indet_2020(1,:)'-indet_2019(1,:)',  indet_2020(2,:)'-indet_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('unkonwn cause deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((indet_2020(1,:)-indet_2019(1,:))./indet_2019(1,:))', 100*((indet_2020(2,:)-indet_2019(2,:))./indet_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('unkonwn cause deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [sept_2019(1,:)',  sept_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('septicemia total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [sept_2019(2,:)',  sept_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('septicemia total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM]);
% 
% subplot(2,2,3)
% data = [sept_2020(1,:)'-sept_2019(1,:)',  sept_2020(2,:)'-sept_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('septicemia deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((sept_2020(1,:)-sept_2019(1,:))./sept_2019(1,:))', 100*((sept_2020(2,:)-sept_2019(2,:))./sept_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('septicemia deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% data = [outras_2019(1,:)',  outras_2020(1,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym1 YM1] = y_limits_analysis(ymin, ymax);
% ylim([Ym1 YM1]);
% title('other causes total number of female deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% subplot(2,2,2)
% data = [outras_2019(2,:)',  outras_2020(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1), 'FaceColor',[.5 .5 .5])
% set(hb(2), 'FaceColor',[.75 .75 .75])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym2 YM2] = y_limits_analysis(ymin, ymax);
% ylim([Ym2 YM2]);
% title('other causes total number of male deaths (jan to may)')
% set(gca,'FontSize',12); legend('2019','2020','Location','northwest');
% 
% Ym = min([Ym1 Ym2]);
% YM = max([YM1 YM2]);
% subplot(2,2,1); ylim([Ym YM]);
% subplot(2,2,2); ylim([Ym YM]);
% 
% subplot(2,2,3)
% data = [outras_2020(1,:)'-outras_2019(1,:)',  outras_2020(2,:)'-outras_2019(2,:)'];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('other causes deaths increase from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
% subplot(2,2,4)
% data = [100*((outras_2020(1,:)-outras_2019(1,:))./outras_2019(1,:))', 100*((outras_2020(2,:)-outras_2019(2,:))./outras_2019(2,:))'  ];
% hb = bar(data); I = find(isinf(data)); data(I)=0; I = find(isnan(data)); data(I)=0;
% set(hb(1),'FaceColor',[.75 .75 .75])
% set(hb(2),'FaceColor',[.50 .50 .50])
% xticklabels(age_labels); set(gca,'FontSize',12); xlabel('age intervals');  grid on; grid minor;
% ymax = max(max(data));
% ymin = min(min(data));
% [Ym YM] = y_limits_analysis(ymin, ymax);
% ylim([Ym YM]);
% title('other causes deaths increase [%] from 2019 to 2020 (jan to may)')
% set(gca,'FontSize',12); legend('female','male','Location','northwest');
% 
