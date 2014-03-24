function data=grabar_patrones(fs,nBits)
% GRABAR_PATRONES Script de grabación de la base de datos
%   BD=GRABAR_PATRONES() Es un script de grabación que pregunta al usuario
%   cuántas muestras para la base de datos desea grabar. Realiza la
%   grabación y guarda las señales grabadas dentro de una celda BD que
%   actúa como base de datos.
%
%   BD=GRABAR_PATRONES(FS) permite especificarle la frecuencia de muestreo.
%   Por defecto son 8000Hz.
%
%   BD=GRABAR_PATRONES(FS,NBITS) permite especificar el número de bits por
%   muestra usados. Por defecto 16 bits.
%
%   Antonio J. Moya Díaz
%   20 de Noviembre de 2012
%   Tecnologías del Habla, Universidad de Granada

    % Control de los parámetros de entrada
    argumentos_entrada=nargin;

    switch argumentos_entrada
        case 0
            fs=8e3;
            nBits=16;
        case 1
            nBits=16;
    end
    
    nCh=1;

    
    % Pedimos al usuario cuantas muestras quere grabar
    num_pat=input('Cuántas muestras desea grabar?\n>');
    
    % Reservamos el espacio para las muestras
    data=cell(num_pat,2);
    
    % Creador del objeto grabador
    grabador=audiorecorder(fs,nBits,nCh);
    
    
    msg2='Por favor, escriba el texto para la muestra ';
    
    
    i=1;% Iterador
    while i<=num_pat

        msg=[msg2 int2str(i) ':\n>'];
        
        name_pat=input(msg,'s');
        pause(1);
        
        disp('Por favor, pronuncie la muestra ahora');
        % Grabación
        recordblocking(grabador, 4);
        
        % Obtención de la muestra
        pre_patron=getaudiodata(grabador);
        
        % Recorte y acomodado de la muestra
        data{i,1}=name_pat;
        data{i,2}=recorta_audio(pre_patron,fs,.3);


        if isempty(data{i,2})
            % Control de correción del patrón grabado. Si el patrón
            % devuelto por la función de recorte es nulo, no se avanza el
            % iterador, repitiendo la última iteración e informando al
            % usuario de que debe repetir la grabación.
            disp('Lo siento, no le entendí bien...');
        else
            % En caso de la grabación haya sido correcta, se aumenta el
            % iterador para pedir el siguiente patrón.
            i=i+1;
        end
        

    end



end