classdef mask_reservoir

    methods(Static)

        % Following properties of 'maskInitContext' are available to use:
        %  - BlockHandle 
        %  - MaskObject 
        %  - MaskWorkspace: Use get/set APIs to work with mask workspace.
        function MaskInitialization(maskInitContext)
            maskObj = Simulink.Mask.get(gcb); % Obtén el objeto de la máscara
            useCaudal = maskObj.getParameter('ifCaudal').Value;

            % Actualiza la visibilidad de los parámetros basado en el valor del checkbox
            if strcmp(useCaudal, 'on')
                maskObj.getParameter('caudal').Visible = 'on';
                maskObj.getParameter('m_dot').Visible = 'off';
                
                % Obtener los valores de caudal y area
                caudal = str2double(maskObj.getParameter('caudal').Value);
                area = str2double(maskObj.getParameter('area').Value);
        
                % Calcular m_dot
                m_dot = caudal / area;
                % Asignar el valor calculado a m_dot
                maskObj.getParameter('m_dot').Value = num2str(m_dot);
            else
                maskObj.getParameter('caudal').Visible = 'off';
                maskObj.getParameter('m_dot').Visible = 'on';
            end
        end

        

        % Use the code browser on the left to add the callbacks.


        function ifCaudal(callbackContext)
            maskObj = Simulink.Mask.get(gcb); % Obtén el objeto de la máscara
            useCaudal = maskObj.getParameter('ifCaudal').Value;

            % Actualiza la visibilidad de los parámetros basado en el valor del checkbox
            if strcmp(useCaudal, 'on')
                maskObj.getParameter('caudal').Visible = 'on';
                maskObj.getParameter('m_dot').Visible = 'off';

                % Obtener los valores de caudal y area
                caudal = str2double(maskObj.getParameter('caudal').Value);
                area = str2double(maskObj.getParameter('area').Value);
        
                % Calcular m_dot
                m_dot = caudal / area;
                % Asignar el valor calculado a m_dot
                maskObj.getParameter('m_dot').Value = num2str(m_dot);
            else
                maskObj.getParameter('caudal').Visible = 'off';
                maskObj.getParameter('m_dot').Visible = 'on';
            end
        end
    end
end