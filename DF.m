%---------Identificación de Nulos---------

%Identificamos la matriz de datos faltantes del DataFrame
Matriz_Nul= ismissing(Mexico1);

%Identificamos la cantidad de datos faltantes por Columna
Column_Nul = sum(Matriz_Nul);

%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_Nul= sum(Column_Nul);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Sustitución de Nulos---------

%Rellenamos datos faltantes por DataFrame usando un método
DataFrame_Fill_1 = fillmissing(Mexico1, 'movmean', 10000, 'DataVariables',{'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'reviews_per_month'});

%Rellenamos datos faltantes por DataFrame usando diferentes métodos
DataFrame_Fill_2 = fillmissing(DataFrame_Fill_1, 'movmedian', 10000,'DataVariables',{'host_response_rate', 'host_acceptance_rate', 'bedrooms','beds'});

%Identificamos la matriz de datos faltantes del DataFrame
Matriz_Null2= ismissing(DataFrame_Fill_2);

%Identificamos la cantidad de datos faltantes por Columna
Column_Null2= sum(Matriz_Null2)

%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_Null2= sum(Column_Null2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Identificación de Outliers---------

%Identificamos Matriz de outliers mediante método de quartiles
Outliers1 = isoutlier(DataFrame_Fill_2,'quartiles','DataVariables',{'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'reviews_per_month', 'host_response_rate', 'host_acceptance_rate', 'bedrooms','beds'});
%Identificamos la cantidad de outliers por Columna
Column_outliers1= sum(Outliers1);
%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_outliers_quartiles= sum(Column_outliers1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Sustitución de Outliers---------
%Rellenamos Outliers por DataFrame usando un método
DataFrame_Filloutliers_1 = filloutliers(DataFrame_Fill_2,'linear','DataVariables',{'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'reviews_per_month', 'host_response_rate', 'host_acceptance_rate', 'bedrooms','beds'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Filtros de Datos---------
%Filtro por columnas
lista = [1,2,4,5,7,8,10,11,12,13,14,15,16,17,18,19,20];
Filtro8 = DataFrame_Filloutliers_1(:,lista);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Correlación de datos---------
%Matriz de correlaciones del Dataframe
Matriz=table2array(Filtro8); %esta línea convierte la tabla en matriz
Mat_Corr=corrcoef(Matriz); %Matriz de correlaciones

%Crear mapa de calor
figure(1)
h = heatmap(Mat_Corr)

%---------Visualización-------------
%Geobubble: Visualiza valores de datos en ubicaciones geográficas específicas
figure(2);
geobubble(Mexico1,'latitude','longitude','SizeVariable','reviews_per_month','ColorVariable','room_type','Basemap','streets')
title 'MEX'

figure(3);
geobubble(Mexico1,'latitude','longitude','SizeVariable','price','ColorVariable','neighbourhood_cleansed','Basemap','satellite')
title 'MEX'

figure(4);
geobubble(Mexico1,'latitude','longitude','SizeVariable','review_scores_rating','ColorVariable','room_type','Basemap','streets')
title 'MEX'

figure(5);
geobubble(Mexico1,'latitude','longitude','SizeVariable','review_scores_location','ColorVariable','neighbourhood_cleansed','Basemap','streets')
title 'MEX'

%Barras paralelas: Visualiza la relación entre 2 o mas variables
Bar_vars= Mexico1(:,[6, 8, 10, 19]);
figure(6);
parallelplot(Bar_vars,'GroupVariable','room_type')
title 'MEX'

writetable(DataFrame_Filloutliers_1,'Mexico_Limpio.xls','Sheet', 1,'Range','A1');