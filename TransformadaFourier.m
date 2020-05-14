%% EJEMPLO DE ANALISIS DE FOURIER DE UNA SENHAL DE ACELERACION DEL TERRENO

%% Aplicado para varios Lugares.

clearvars

lugaresDeAnalisis = ["Alajuela","Armuelles", "Cinchona", "Cobano", "Damas", "Dominical", "Jaco", "Limon", "Nicoya", "Panama" ];
formatoDelArchivo = ".txt";
direccion = "ubicacion/";

indice = 1;
dimension = length(lugaresDeAnalisis);

while indice<=dimension

    lugarAnalizado = lugaresDeAnalisis(indice);

    % Cargar acelerograma del terreno
    datosDeArchivoCargado = load(strcat(direccion, lugarAnalizado,formatoDelArchivo));
    ug = datosDeArchivoCargado(:,2);
    t  = datosDeArchivoCargado(:,1);

    % Calculo de la transformada de Fourier de ug
    L  = length(t);     % Tamanho de la senhal
    dt = t(2)-t(1);     % Intervalo de muestreo
    Fs = 1/dt;          % Frecuencia de muestreo
    N  = 2^14;          % Cantidad de puntos de Fourier      

    % Calcular la transformada de Fourier
    pf = fft(ug,N);    

    % Calcular el espectro de dos colas
    pf2 = abs(pf/L);

    % Calcular el espectro de una cola
    pf1           = pf2(1:N/2+1);    
    pf1(2:end-1)  = 2*pf1(2:end-1);    

    % Crear vector de frecuencias
    F = (0:(Fs/N):(Fs/2-(Fs/N)));

    %% Graficos

    pause(1); % Pausa en el tiempo (1 segundo)
    
    figure(indice);
    figure('Name',lugarAnalizado);
    
    subplot(3, 1, 1)
    plot(t,ug,'k',[0 t(end)],[0 0],'b--')
    ylim([-1.25*max(ug) 1.25*max(ug)])
    xlim([0 t(end)])
    xlabel('Tiempo [s]')
    ylabel('Amplitud de la senal')
    title ('Amplitud vs  Tiempo')

     subplot(3, 1, 2)
    plot(F,pf1(1:N/2));
    ylabel('Amplitud de la senal')
    xlabel('Frecuencia [Hz]')
     title ('Amplitud vs  Frecuencia')

     subplot(3, 1, 3)
    loglog(F,pf1(1:N/2));
    ylabel('Amplitud de la senal')
    xlabel('Frecuencia [Hz]')
     title ('Amplitud vs  Frecuencia (loglog)')
    grid on

    indice = indice + 1;
end



