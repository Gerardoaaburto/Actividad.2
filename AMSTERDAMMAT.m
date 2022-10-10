%---------Identificación de Nulos---------

%Identificamos la matriz de datos faltantes del DataFrame
Matriz_Null= ismissing(AMSTERDAM);

%Identificamos la cantidad de datos faltantes por Columna
Column_Null= sum(Matriz_Null);

%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_Null= sum(Column_Null);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Sustitución de Nulos---------

%Rellenamos datos faltantes por DataFrame usando un método
DataFrame_Fill_1 = fillmissing(AMSTERDAM,'previous','DataVariables',{'host_location','neighbourhood','first_review','last_review','host_neighbourhood'});

%Rellenamos datos faltantes por DataFrame usando diferentes métodos
DataFrame_Fill_2 = fillmissing(DataFrame_Fill_1,'next','DataVariables',{'host_is_superhost','bathrooms_text','license','instant_bookable'});
DataFrame_Fill_3 = fillmissing(DataFrame_Fill_2,'movmean', 6890 ,'DataVariables',{'host_response_rate','host_acceptance_rate','review_scores_rating','review_scores_accuracy','review_scores_cleanliness','reviews_per_month','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value'});
DataFrame_Fill_4 = fillmissing(DataFrame_Fill_3,'movmedian', 6890,'DataVariables',{'bedrooms','beds','calculated_host_listings_count','calculated_host_listings_count_entire_homes','minimum_minimum_nights','maximum_minimum_nights','minimum_maximum_nights','maximum_maximum_nights','minimum_nights_avg_ntm','maximum_nights_avg_ntm'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Identificamos la matriz de datos faltantes del DataFrame
Matriz_Null2= ismissing(DataFrame_Fill_4);

%Identificamos la cantidad de datos faltantes por Columna
Column_Null2= sum(Matriz_Null2);

%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_Null2= sum(Column_Null2);

%---------Identificación de Outliers---------

%Identificamos Matriz de outliers mediante método de quartiles
Outliers1 = isoutlier(DataFrame_Fill_4,'quartiles','DataVariables',{'host_response_rate','host_acceptance_rate','review_scores_rating','review_scores_accuracy','review_scores_cleanliness','reviews_per_month','bedrooms','beds','calculated_host_listings_count','calculated_host_listings_count_entire_homes','minimum_minimum_nights','maximum_minimum_nights','minimum_maximum_nights','maximum_maximum_nights','minimum_nights_avg_ntm','maximum_nights_avg_ntm'});
%Identificamos la cantidad de outliers por Columna
Column_outliers1= sum(Outliers1);
%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_outliers_quartiles= sum(Column_outliers1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Sustitución de Outliers---------
%Rellenamos Outliers por DataFrame usando un método
DataFrame_Filloutliers_1 = filloutliers(DataFrame_Fill_4,'linear','DataVariables',{'host_response_rate','host_acceptance_rate','review_scores_rating','review_scores_accuracy','review_scores_cleanliness','reviews_per_month','bedrooms','beds','calculated_host_listings_count','calculated_host_listings_count_entire_homes','minimum_minimum_nights','maximum_minimum_nights','minimum_maximum_nights','maximum_maximum_nights','minimum_nights_avg_ntm','maximum_nights_avg_ntm'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Filtros de Datos---------
%Filtro por columnas
lista = [17,18,23,24,31,32,35,38,39,41,42,43,44,45,46,47,48,49,52,53,54,55,57,58,59,62,63,64,65,66,67,68,71,72,73,74,75];
Filtro8 = DataFrame_Filloutliers_1(:,lista);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------Correlación de datos---------
%Matriz de correlaciones del Dataframe
Matriz=table2array(Filtro8); %esta línea convierte la tabla en matriz
Mat_Corr=corrcoef(Matriz); %Matriz de correlaciones

%Crear mapa de calor
figure(7)
h = heatmap(Mat_Corr)


%---------Visualización----------figure---
%Geobubble: Visualiza valores de datos en ubicaciones geográficas específicas
figure(1)
geobubble(AMSTERDAM,'latitude','longitude','SizeVariable','number_of_reviews','ColorVariable','room_type','Basemap','streets')
title 'Amsterdam'

figure(2)
geobubble(AMSTERDAM,'latitude','longitude','SizeVariable','price','ColorVariable','neighbourhood','Basemap','satellite')
title 'Amsterdam'

figure(3)
geobubble(AMSTERDAM,'latitude','longitude','SizeVariable','review_scores_rating','ColorVariable','room_type','Basemap','streets')
title 'Amsterdam'

figure(4)
geobubble(AMSTERDAM,'latitude','longitude','SizeVariable','review_scores_location','ColorVariable','neighbourhood_cleansed','Basemap','streets')
title 'Amsterdam'

%Barras paralelas: Visualiza la relación entre 2 o mas variables
Ams_vars= AMSTERDAM(:,[34, 38, 41, 68]);
figure(5)
parallelplot(Ams_vars,'GroupVariable','room_type')
title 'AMS'