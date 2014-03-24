function data=grabar_patrones(fs,nBits)
% GRABAR_PATRONES Script de grabaci�n de la base de datos
%   BD=GRABAR_PATRONES() Es un script de grabaci�n que pregunta al usuario
%   cu�ntas muestras para la base de datos desea grabar. Realiza la
%   grabaci�n y guarda las se�ales grabadas dentro de una celda BD que
%   act�a como base de datos.
%
%   BD=GRABAR_PATRONES(FS) permite especificarle la frecuencia de muestreo.
%   Por defecto son 8000Hz.
%
%   BD=GRABAR_PATRONES(FS,NBITS) permite especificar el n�mero de bits por
%   muestra usados. Por defecto 16 bits.
%
%   Antonio J. Moya D�az
%   20 de Noviembre de 2012
%   Tecnolog�as del Habla, Universidad de Granada

    % Control de los par�metros de entrada
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
    num_pat=input('Cu�ntas muestras desea grabar?\n>');
    
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
        % Grabaci�n
        recordblocking(grabador, 4);
        
        % Obtenci�n de la muestra
        pre_patron=getaudiodata(grabador);
        
        % Recorte y acomodado de la muestra
        data{i,1}=name_pat;
        data{i,2}=recorta_audio(pre_patron,fs,.3);


        if isempty(data{i,2})
            % Control de correci�n del patr�n grabado. Si el patr�n
            % devuelto por la funci�n de recorte es nulo, no se avanza el
            % iterador, repitiendo la �ltima iteraci�n e informando al
            % usuario de que debe repetir la grabaci�n.
            disp('Lo siento, no le entend� bien...');
        else
            % En caso de la grabaci�n haya sido correcta, se aumenta el
            % iterador para pedir el siguiente patr�n.
            i=i+1;
        end
        

    end



end