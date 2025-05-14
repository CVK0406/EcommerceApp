# Deploying EcommerceApp to Azure App Service

This guide provides simplified steps for deploying the EcommerceApp to Azure App Service.

## Prerequisites

1.  **Azure Account**
    *   Create an Azure account at [azure.com](https://azure.com)
    *   Ensure you have an active subscription
    *   Register required resource providers:
        ```powershell
        az provider register --namespace Microsoft.Web
        az provider register --namespace Microsoft.DBforMySQL
        ```

2.  **Required Tools**
    *   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
    *   [Maven](https://maven.apache.org/download.cgi)
    *   [Java JDK 8](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)
    *   MySQL command-line client (ensure it's in your PATH)

## Deployment Steps

1.  **Login to Azure**
    ```powershell
    az login
    ```

2.  **Create Resource Group**
    ```powershell
    az group create --name ecommerce-rg --location centralus
    ```

3.  **Create MySQL Flexible Server**
    ```powershell
    az mysql flexible-server create --resource-group ecommerce-rg --name cvkmysql --location centralus --admin-user ecommadmin --admin-password admin --sku-name B_Standard_B1ms --tier Burstable --version 5.7 --storage-size 32 --public-access 0.0.0.0
    ```

4.  **Create App Service Plan**
    ```powershell
    az appservice plan create --resource-group ecommerce-rg --name ecommerce-app-plan --location centralus --sku B1 --is-linux
    ```

5.  **Create Web App**
    ```powershell
    az webapp create --resource-group ecommerce-rg --name cvk-ecommerce-app --runtime "TOMCAT:8.5-jre8" --plan ecommerce-app-plan
    ```

6.  **Configure App Settings**
    ```powershell
    az webapp config appsettings set --resource-group ecommerce-rg --name cvk-ecommerce-app --settings "DB_HOST=cvkmysql.mysql.database.azure.com:3306" "DB_NAME=ecommerce_db" "DB_USER=ecommadmin" "DB_PASSWORD=admin"
    ```

7.  **Initialize Database**
    ```powershell
    # Create database
    mysql -h cvkmysql.mysql.database.azure.com -u ecommadmin -p -e "CREATE DATABASE IF NOT EXISTS ecommerce_db;"
    
    # Import schema (PowerShell)
    Get-Content .\init.sql | mysql -h cvkmysql.mysql.database.azure.com -u ecommadmin -p ecommerce_db
    ```

8.  **Deploy Application**
    ```powershell
    # Build the project
    mvn clean package

    # Deploy to Azure
    mvn azure-webapp:deploy "-Dazure.resourceGroup=ecommerce-rg" "-Dazure.appName=cvk-ecommerce-app" "-Dazure.region=centralus"
    ```

9.  **Access Your Application**
    *   Visit: `https://cvk-ecommerce-app.azurewebsites.net`

## Best Practices

1.  **Security**
    *   Use Azure Key Vault for sensitive information
    *   Enable SSL for database connections
    *   Regularly rotate database passwords
    *   Enable HTTPS for your web app
    *   Configure proper CORS settings

2.  **Performance**
    *   Use Azure CDN for static content
    *   Enable caching where appropriate
    *   Monitor application performance
    *   Use appropriate VM size for your workload

3.  **Monitoring**
    *   Enable Application Insights
    *   Set up alerts for critical metrics
    *   Monitor database performance
    *   Review application logs regularly

4.  **Maintenance**
    *   Keep dependencies updated
    *   Regularly backup your database
    *   Monitor Azure costs
    *   Review and optimize resource usage

## Troubleshooting

1.  **Common Issues**
    *   Database connection issues: Check firewall rules and connection strings
    *   Application startup issues: Review Tomcat logs in Azure Portal
    *   File upload issues: Verify permissions and file size limits

2.  **Useful Commands**
    ```powershell
    # View application logs
    az webapp log tail --resource-group ecommerce-rg --name cvk-ecommerce-app

    # Restart application
    az webapp restart --resource-group ecommerce-rg --name cvk-ecommerce-app

    # View application settings
    az webapp config appsettings list --resource-group ecommerce-rg --name cvk-ecommerce-app
    ```

## Clean Up

To remove all resources when no longer needed:
```powershell
az group delete --name ecommerce-rg --yes
```

## Additional Resources

*   [Azure App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
*   [Java on Azure Documentation](https://docs.microsoft.com/en-us/azure/developer/java/)
*   [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
*   [Maven Plugin for Azure Web Apps](https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Web-App-Maven-Plugin)

---