%% Copyright 2012 Antonio Moya (ajmoyad@gmail.com)
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details. 
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.


%% Ejemplo: Dynamic Time Warping
%   Tecnologías del Habla
%   Universidad de Granada
%
%   Iniciada:               05/11/12
%   Ultima actualización:   20/11/12
%
%   Ejemplo sencillo del funcionamiento de la técnica de Dynamic Time
%   Warping. El código pedirá, en primer lugar, al usuairo la creación de
%   unos patrones, ésto es, de la base de datos de muestras a reconocer.
%   Acto seguido se le pedirá al usuario la grabación de la muestra a
%   reconocer o incógnita, y procederá a realizar el reconocimiento.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./src');

clear, clc, close all

%% Paso 1: Creación de los patrones

% La grabación de los patrones ha sido diseñada en una función aparte.
data=grabar_patrones();

%% Paso 2: Grabación de la incógnita

% La grabación de la incógnita también ha sido diseñada en una función
% aparte.
muestra=grabar_muestra();


%% Paso 3: Reconocimiento

% Se ha diseñado una función dtw que ejecuta el algoritmo para dos señales
% dadas y devuelve el valor de la distancia calculada. Por tanto es
% necesario automatizar el proceso.


disp('Reconociendo la muestra, por favor, espere...')

% Calculamos el numero de veces a iterar, es decir, el número de
% comparaciones a hacer.
it=size(data,1);

% Reservamos el espacio para el vector con las distancias
distancias=zeros(1,it);

% Iteramos haciendo el reconocimiento
for k=1:1:it
    distancias(k)=dtw(data{k,2},muestra);
    disp('.')
end

% Se extrae el valor de distancia más pequeño que será el patrón
% reconocido.
[v,recog]=min(distancias);

% Se muestra el nombre del patrón reconocido.
disp(['Patrón reconocido: ' data{recog,1}]);


