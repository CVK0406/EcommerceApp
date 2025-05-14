# CI/CD Setup Guide for E-commerce Application

This guide explains how to set up Continuous Integration and Continuous Deployment (CI/CD) for the e-commerce application using GitHub Actions and Azure. It covers both initial infrastructure provisioning and subsequent automated code deployments.

## Prerequisites

1.  **GitHub Account:** With a repository for the application.
2.  **Azure Account:** With an active subscription.
3.  **Azure CLI:** Installed locally for initial setup and ad-hoc management.
4.  **MySQL Client Tools:** Installed locally for database interaction.
5.  **`init.sql` Script:** This script should be in your repository, designed for **initial database schema creation and seed data population**. It should not be run repeatedly on a live database without modifications for idempotency or as part of a migration strategy.

## Required Secrets for GitHub Actions

Set up the following secrets in your GitHub repository (Settings > Secrets and variables > Actions):

1.  **`AZURE_CREDENTIALS`**: JSON output from creating an Azure Service Principal. This allows GitHub Actions to authenticate with Azure.
2.  **`DB_PASSWORD`**: Password for the MySQL database admin user (`ecommadmin`).

*(Note: `AZURE_WEBAPP_PUBLISH_PROFILE` is an alternative for deployment but using `AZURE_CREDENTIALS` with sufficient permissions is generally preferred for consistency and granular control.)*

## Initial Azure Infrastructure Setup

This section describes how to set up the necessary Azure resources. This is typically a **one-time process** per environment (e.g., staging, production).

**1. Azure Service Principal Setup (One-time)**

   If you haven't already, create a service principal scoped to your resource group:
   ```bash
   az login
   az ad sp create-for-rbac --name "ecommerce-app-cicd-sp" --role "Contributor" \
       --scopes /subscriptions/<your-subscription-id>/resourceGroups/ecommerce-rg \
       --sdk-auth
   ```
   *   Replace `<your-subscription-id>` with your actual subscription ID.
   *   The `ecommerce-rg` resource group will be created by the script below if it doesn't exist.
   *   Copy the entire JSON output. Go to your GitHub repository > Settings > Secrets and variables > Actions, and create a new repository secret named `AZURE_CREDENTIALS`, pasting the JSON output there.

**2. Manual Infrastructure & Initial Database Setup (One-time per environment)**

   The following Azure CLI commands create the necessary resources and initialize the database. Run these locally or adapt them into a separate, one-time execution script/workflow.

   *   **Environment Variables (example values, adjust as needed):**
       ```bash
       RESOURCE_GROUP="ecommerce-rg"
       LOCATION="centralus"
       DB_SERVER="cvkmysql"
       DB_USER="ecommadmin"
       DB_ADMIN_PASSWORD="YOUR_SECURE_DB_PASSWORD" # Use the same password you'll set in GitHub secrets
       DB_NAME="ecommerce_db"
       APP_SERVICE_PLAN_NAME="ecommerce-app-plan"
       AZURE_WEBAPP_NAME="cvk-ecommerce-app"
       ```
       *Replace `YOUR_SECURE_DB_PASSWORD` with the actual password.*

   *   **Azure CLI Commands:**
       ```bash
       # Login to Azure (if not already)
       az login

       # Register Providers (if not already registered)
       az provider register --namespace Microsoft.Web --wait
       az provider register --namespace Microsoft.DBforMySQL --wait

       # Create Resource Group
       az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

       # Create MySQL Flexible Server
       az mysql flexible-server create \
         --resource-group "$RESOURCE_GROUP" \
         --name "$DB_SERVER" \
         --location "$LOCATION" \
         --admin-user "$DB_USER" \
         --admin-password "$DB_ADMIN_PASSWORD" \
         --sku-name Standard_B1ms \
         --tier Burstable \
         --version 5.7 \
         --storage-size 32 \
         --public-access 0.0.0.0 # For production, restrict this

       # Create App Service Plan
       az appservice plan create \
         --resource-group "$RESOURCE_GROUP" \
         --name "$APP_SERVICE_PLAN_NAME" \
         --location "$LOCATION" \
         --sku B1 \
         --is-linux

       # Create Web App
       az webapp create \
         --resource-group "$RESOURCE_GROUP" \
         --name "$AZURE_WEBAPP_NAME" \
         --runtime "TOMCAT|8.5-jre8" \ # Ensure shell compatibility for '|' if running manually
         --plan "$APP_SERVICE_PLAN_NAME"

       # Configure App Settings
       az webapp config appsettings set \
         --resource-group "$RESOURCE_GROUP" \
         --name "$AZURE_WEBAPP_NAME" \
         --settings \
           "DB_HOST=${DB_SERVER}.mysql.database.azure.com:3306" \
           "DB_NAME=${DB_NAME}" \
           "DB_USER=${DB_USER}" \
           "DB_PASSWORD=${DB_ADMIN_PASSWORD}"

       # Initialize Database (ensure init.sql is in current directory and MySQL client is installed)
       # Add your client IP to MySQL firewall if --public-access 0.0.0.0 isn't sufficient for local connection
       mysql -h "${DB_SERVER}.mysql.database.azure.com" -u "$DB_USER" -p"$DB_ADMIN_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
       mysql -h "${DB_SERVER}.mysql.database.azure.com" -u "$DB_USER" -p"$DB_ADMIN_PASSWORD" "${DB_NAME}" < init.sql
       echo "Initial infrastructure and database setup complete."
       ```

## CI/CD Workflow for Code Updates

This GitHub Actions workflow (`.github/workflows/azure-deploy.yml`) automates building and deploying application code updates to the **existing Azure infrastructure**. It does **not** re-create infrastructure or re-run the full `init.sql`.

**File: `.github/workflows/azure-deploy.yml`**
```yaml
name: Build and Deploy Code Updates to Azure

on:
  push:
    branches: [ main ] # Triggers on push to the main branch

env:
  AZURE_WEBAPP_NAME: cvk-ecommerce-app
  AZURE_WEBAPP_PACKAGE_PATH: 'target/EcommerceApp.war' # Assumes finalName in pom.xml is EcommerceApp
  JAVA_VERSION: '8'
  RESOURCE_GROUP: 'ecommerce-rg' # Used by Azure login context if needed by deploy step implicitly
  # Optional: DB env vars if you implement DB migration steps
  # DB_SERVER: 'cvkmysql'
  # DB_NAME: 'ecommerce_db'
  # DB_USER: 'ecommadmin'
  # DB_PASSWORD: ${{ secrets.DB_PASSWORD }}

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up JDK ${{ env.JAVA_VERSION }}
      uses: actions/setup-java@v3
      with:
        java-version: ${{ env.JAVA_VERSION }}
        distribution: 'temurin' 
        cache: 'maven'

    - name: Build with Maven
      # Add -DskipTests if your project has no tests or you want to skip them for this build
      run: mvn clean package -B # -B for batch mode

    # Optional: Add a 'Run Tests' step here if you have tests:
    # - name: Run Tests
    #   run: mvn test -B

    # Deploy to Azure Web App (only on main branch pushes)
    - name: Deploy to Azure Web App
      if: github.ref == 'refs/heads/main' # && success() # Add success() if you have a test step
      uses: azure/login@v1 
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    - run: | # This run step is part of the Deploy sequence when using AZURE_CREDENTIALS
        # Deploy using Azure Web Apps Deploy action
        uses: azure/webapps-deploy@v2
        with:
          app-name: ${{ env.AZURE_WEBAPP_NAME }}
          package: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }}
          # The action uses the Service Principal context from azure/login@v1
          # Ensure the SP has "Website Contributor" or similar role on the Web App.

    # --- OPTIONAL: Database Migration Step ---
    # If you have database schema changes, implement them here using Flyway, Liquibase,
    # or carefully crafted idempotent SQL scripts. Do NOT re-run the full init.sql.
    # - name: Install MySQL Client (if running DB migrations)
    #   if: github.ref == 'refs/heads/main'
    #   run: |
    #     sudo apt-get update -q
    #     sudo apt-get install -yq mysql-client
    # - name: Apply Database Migrations
    #   if: github.ref == 'refs/heads/main'
    #   env:
    #     MYSQL_PWD: ${{ secrets.DB_PASSWORD }}
    #   run: |
    #     echo "Applying database migrations..."
    #     # Example: mysql -h ${{ env.DB_SERVER }}.mysql.database.azure.com -u ${{ env.DB_USER }} ${{ env.DB_NAME }} < ./path/to/migration_script_V2.sql
    #     echo "Database migrations applied."
```

## Workflow Explanation

1.  **Trigger:** The workflow runs on every push to the `main` branch.
2.  **Checkout & Setup:** Checks out the code and sets up the specified Java JDK.
3.  **Build:** Compiles the application and packages it into a `.war` file using `mvn clean package`. (Tests are skipped in this example but can be added).
4.  **Deploy:**
    *   Logs into Azure using the `AZURE_CREDENTIALS` service principal.
    *   Uses the `azure/webapps-deploy@v2` action to deploy the built `.war` file to the specified Azure Web App.

## Manual Code Deployment (Alternative)

If you need to deploy code manually to existing infrastructure:

1.  Build the application locally:
    ```bash
    mvn clean package -DskipTests
    ```
2.  Deploy to Azure using Azure CLI (ensure you are logged in: `az login`):
    ```bash
    az webapp deployment source config-zip \
        --resource-group ecommerce-rg \
        --name cvk-ecommerce-app \
        --src target/EcommerceApp.war # Adjust path if finalName in pom.xml is different
    ```

## Troubleshooting CI/CD

1.  **Build Failures (GitHub Actions):**
    *   Check Maven logs in the GitHub Actions workflow run for compilation errors.
    *   Verify all dependencies in `pom.xml` are correct and accessible.
2.  **Deployment Failures (GitHub Actions):**
    *   Ensure `AZURE_CREDENTIALS` are correct and the service principal has "Website Contributor" (or equivalent) role on the Web App or its resource group.
    *   Verify `AZURE_WEBAPP_NAME` and `AZURE_WEBAPP_PACKAGE_PATH` environment variables are correct.
    *   Check Azure Activity Logs for deployment errors on the Web App.
3.  **Application Not Working After Deployment:**
    *   Check App Service logs (Log stream, Application Insights).
    *   Verify App Settings (database connection strings, etc.) in Azure are correct.
    *   Ensure database schema is compatible with the deployed code version.

## Security Considerations

1.  **Secrets Management:** Never commit `AZURE_CREDENTIALS`, `DB_PASSWORD`, or other sensitive data directly to the repository. Use GitHub Secrets.
2.  **Service Principal Privileges:** Follow the principle of least privilege when assigning roles to the service principal.
3.  **Azure Key Vault:** For production, consider storing secrets like `DB_PASSWORD` in Azure Key Vault and referencing them in App Settings or during deployment.
4.  **Regular Updates:** Keep dependencies, JDK, Maven, Azure CLI, and GitHub Actions (e.g., `actions/checkout@v3`, `azure/login@v1`) updated.

## Monitoring

1.  **Azure Application Insights:** Configure for your Web App to monitor performance, exceptions, and availability.
2.  **Azure Monitor:** Set up alerts for critical failures (e.g., high CPU, HTTP 5xx errors) on your App Service and Database.
3.  **Database Performance:** Monitor your Azure Database for MySQL performance metrics.

## Best Practices for CI/CD

1.  **Environment Parity:** Aim to have development/staging environments that closely mirror production.
2.  **Feature Branches:** Use feature branches for new development and merge to `main` via Pull Requests (which can trigger builds/tests but not necessarily deployments).
3.  **Database Migrations:** Implement a robust database migration strategy (e.g., Flyway, Liquibase) for schema changes. **Do not re-run the full `init.sql` on a live database.**
4.  **Logging:** Implement comprehensive logging within your application.
5.  **Backups:** Ensure regular backups for your Azure Database for MySQL (Azure provides automated backups).

## Support

1.  Check Azure documentation and GitHub Actions documentation.
2.  Review detailed logs from GitHub Actions workflow runs.
3.  Consult your team or system administrator.

---