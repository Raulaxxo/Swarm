# Proyecto Swarm con Nginx

Este proyecto despliega un stack de Docker Swarm utilizando Nginx como servicio principal. La infraestructura puede ser provisionada en AWS usando Terraform.

## Estructura del proyecto

- `docker-compose.yml`: Define el stack de servicios para Docker Swarm.
- `Dockerfile`: (Vacío por defecto, puedes personalizarlo para tu imagen).
- `terraform/`: Contiene la configuración de Terraform para desplegar instancias EC2 en AWS.
- `.github/workflows/deploy-swarm.yml`: Workflow de GitHub Actions para desplegar automáticamente el stack en un servidor remoto vía SSH.

## Despliegue con Terraform

1. Ve al directorio `terraform`:
   ```sh
   cd terraform
   ```
2. Inicializa Terraform:
   ```sh
   terraform init
   ```
3. Aplica la infraestructura:
   ```sh
   terraform apply
   ```
   Esto creará 3 instancias EC2 con Docker instalado.

## Despliegue del stack en Docker Swarm

1. Accede a una de las instancias y crea el cluster Swarm:
   ```sh
   docker swarm init
   ```
2. Agrega los otros nodos como workers usando el token generado por el comando anterior.
3. Copia el archivo `docker-compose.yml` al nodo manager.
4. Despliega el stack:
   ```sh
   docker stack deploy -c docker-compose.yml nginx_stack
   ```

## Automatización con GitHub Actions

El workflow [`deploy-swarm.yml`](.github/workflows/deploy-swarm.yml) copia el archivo `docker-compose.yml` a tu servidor y ejecuta el despliegue automáticamente cuando hay cambios en la rama `main`.

Debes configurar los siguientes secretos en tu repositorio de GitHub:
- `SSH_HOST`
- `SSH_USER`
- `SSH_KEY`

## Personalización

- Puedes modificar el número de réplicas de Nginx en `docker-compose.yml`.
- Para servir archivos estáticos, descomenta y ajusta la sección `volumes` en el servicio Nginx.

## Requisitos

- Docker y Docker Compose instalados en los nodos.
- Acceso SSH al servidor manager del Swarm.
- AWS CLI y credenciales configuradas para usar Terraform.