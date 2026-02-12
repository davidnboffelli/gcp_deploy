Servicios requeridos en proyecto donde se crea service account de despliegue de recursos para poder desplegar todos los recursos:
- iam.googleapis.com
- cloudresourcemanager.googleapis.com

Para usar modulo en repo privado:
- crear clave con comando: ssh-keygen -t ed25519
- subir clave publica a repo privado (modulo) en sección Deploy Keys
- subir clave privada a repo workflow en sección Secrets con nombre "SSH_KEY_GITHUB_ACTIONS"
- Ejemplo de uso en step terraform init:
    - name: Terraform Init
      run: |
        eval `ssh-agent -s`
        ssh-add - <<< '${{ secrets.SSH_KEY_GITHUB_ACTIONS }}'
        terraform -chdir=Terraform init 
      env:
        GOOGLE_CREDENTIALS: ${{ secrets.GOOGLE_CREDENTIALS }} 

Siguientes pasos:
- migrar modulo iam (hecho)
- usar modulo iam aca (hecho)
- hacer prueba con roles a user y sa sobre prj service y host (crear atributos prj_host_iam, prj_service_iam) (hecho)
- desplegar ejemplo con 2 o 3 usuarios reales (manu,alejandro,pablo?)
- comentar codigo
- hacer prueba de permisos necesarios para despliegue de recursos?
- definir procedimiento