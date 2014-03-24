function muestra=grabar_muestra(fs,nBits)
% GRABAR_MUESTRA Script de grabaci�n de la muestra a reconocer
%   M=GRABAR_MUESTRA() es un script de grabaci�n que demanda al usuario la
%   grabaci�n de una muestra a reconocer.
%
%   BD=GRABAR_PATRONES(FS) permite especificarle la frecuencia de muestreo.
%   Por defecto son 8000Hz.
%
%   BD=GRABAR_PATRONES(FS,NBITS) permite especificar el n�mero de bits por
%   muestra usados. Por defecto 16 bits.
%
%   Antonio J. Moya D�az
%   19 de Noviembre de 2012
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
    
    muestra=[];
    
    % Creaci�n del objeto grabador
    grabador=audiorecorder(fs,nBits,nCh);
    
    
    while isempty(muestra)
        % Iteramos hasta que se grabe una muestra correctamente.
        
        % Informe al usuario de lo que se va a realizar
        disp('Pulse espacio para grabar la muestra a reconocer')
        pause
    
        % Aviso al usuario de que debe pronunciar una muestra
        disp('Por favor, pronuncie la muestra ahora');
    
        % Grabaci�n
        recordblocking(grabador,4);
        pre_muestra=getaudiodata(grabador);

        % Recorte y acomodado de la muestra
        muestra=recorta_audio(pre_muestra,fs,.3);
    

        if isempty(muestra)
            % Control de correcci�n de la muestra. El algoritmo de recorte 
            % nos dar� un vector vac�o si la muestra no se grab� 
            % correctamente. Si esto es as�, el while seguir� iterando. 
            % Por tanto, avisamos al usuario de que debe repetir la 
            % grabaci�n.
            disp('Lo siento, no le entendi bien...');
        end
    
    end


end