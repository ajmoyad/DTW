function signal=recorta_audio(s,fs,padding,opt)
% RECORTA_AUDIO Recorta el audio con relleno
%   SG=RECORTA_AUDIO(S,FS,PAD,OPT) recorta una se�al de audio S, muestreada
%   a FS, que contiene una muestra vocal, detectando la actividad de �sta
%   y a�adiendo, si es posible, un relleno antes y despu�s de PAD segundos.
%   Devuelve la se�al recortada en SG. Si se anula la salida muestra una
%   gr�fica con el recorte propuesto, tambi�n puede mostrarla si se a�ade 
%   al final la secuencia 'p'.
%
%   Antonio J. Moya D�az
%   20 de Noviembre de 2012
%   Tecnolog�as del Habla, Universidad de Granada

    % Generamos el relleno en n� de muestras
    pad_m=padding*fs;
    
    % Umbral VAD (Voice activity detection)
    umbral=.33*max(s);
    
    % Limites VAD
    sobre_umbral=find(s>umbral);
    limits=[sobre_umbral(1) sobre_umbral(end)];
    
    % Indices primero y �ltimo de los que extraeremos el sonido
    st=max([limits(1)-pad_m 1]); %comienzo
    fin=min([limits(2)+pad_m length(s)]);%fin
    

    % Si la se�al no tiene el relleno esperado se devolver� un vector vac�o
    % a modo de indicaci�n del error en el recorte.
    if st==1 || fin==length(s)
        signal=[];
    else 
        signal=s(st:fin);
    end

    
%% Representaci�n gr�fica

    if (nargin==4 && strcmp(opt,'p')) || nargout==0
        
        aux=length(s)/8e3;
        ejex_orig=0:1/fs:aux-1/fs;
        ejex_trim=ejex_orig(st:fin);
        
        figure
        subplot(2,1,1),plot(ejex_orig,s),hold on
        subplot(2,1,1),plot(ejex_orig,umbral,'g');
        subplot(2,1,1),stem([ejex_orig(sobre_umbral(1)) ejex_orig(sobre_umbral(end))],[s(sobre_umbral(1)) s(sobre_umbral(end))],'r');
        grid on,xlabel('tiempo(s)'),ylabel('amplitud');
        title('Se�al grabada y trimming');
        
        subplot(2,1,2),plot(ejex_trim,signal);
        axis([ejex_trim(1) ejex_trim(end) min(signal)-0.1 max(signal)+0.1]);
        grid on, xlabel('tiempo(s)'),ylabel('amplitud');
        title('Patr�n generado')
    
    end
    

end
