function MaskInitialization(maskInitContext)
            maskObj = Simulink.Mask.get(gcb); % Obtén el objeto de la máscara
            useCaudal = maskObj.getParameter('ifCaudal').Value;

            % Actualiza la visibilidad de los parámetros basado en el valor del checkbox
            if strcmp(useCaudal, 'on')
                maskObj.getParameter('caudal').Visible = 'on';
                maskObj.getParameter('m_dot').Visible = 'off';
            else
                maskObj.getParameter('caudal').Visible = 'off';
                maskObj.getParameter('m_dot').Visible = 'on';
            end
        end
        maskInit(); % Llama a la función de inicialización
function ifCaudal(~)
            maskObj = Simulink.Mask.get(gcb); % Obtén el objeto de la máscara
            useCaudal = maskObj.getParameter('ifCaudal').Value;

            % Actualiza la visibilidad de los parámetros basado en el valor del checkbox
            if strcmp(useCaudal, 'on')
                maskObj.getParameter('caudal').Visible = 'on';
                maskObj.getParameter('m_dot').Visible = 'off';
            else
                maskObj.getParameter('caudal').Visible = 'off';
                maskObj.getParameter('m_dot').Visible = 'on';

        
            
end

