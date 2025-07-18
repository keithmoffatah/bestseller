# Hello World API

## Purpose

A simple REST API with `/hello` endpoint deployed on Azure using Terraform modules.

## API

- **Endpoint:** `/hello`
- **Method:** GET
- **Response:** `Hello World`

## Assumptions

- The API is currently public, this will allow the stakeholders in the Brande office and Zalando partners to access the api
  - In a future sprint, we will switch to an Azure App Service with a private endpoint and whitelist specific IP addresses. (Currently, the API is public because we do not have specific partner IPs to whitelist.)
- No authentication is added for simplicity.
- Hosted on **Azure App Service** (simple, fast, cost-effective for small scale).
- Terraform state is local for now.
  - In production, would use a remote backend (e.g., Azure Storage Account).
- No CI/CD for main test, but would add GitHub Actions in the future.
- Logging can be viewed in xxxxxx.scm.azurewebsites.net/DebugConsole
  - In production, would integrate with Application Insights.

## Requirements

- Python 3.9+
- Terraform >= 1.4.0
- Azure subscription

## Deploy

1. Create a virtual environment and install dependencies:

   ```bash
   cd app
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

2. Set your unique suffix in `terraform/terraform.tfvars`:

   ```hcl
   unique_suffix = "your-unique-suffix"
   ```

3. Deploy infrastructure with Terraform:

   ```bash
   cd ../terraform
   terraform init
   terraform apply
   ```
   Take note of output URL

4. Deploy your app code to Azure (from project root):

   ```bash
   cd app
   zip -r ../app.zip .
   cd ..
   export APP_NAME="<your-app-service-name>"
   export RESOURCE_GROUP="<your-resource-group>"
   az login
   az webapp deploy \
    --resource-group $RESOURCE_GROUP \
    --name $APP_NAME \
    --src-path app.zip \
    --type zip
   ```
   Replace values `<your-resource-group>` and `<your-app-service-name>` Use portal or Azure CLI to be certain of infra deployment destination
   > **Note:**
   > Make sure you zip the **contents** of the `app/` directory (not the folder itself), so that `app.py` and `requirements.txt` are at the root of the zip file. If you zip the folder itself, Azure will not be able to find your app and deployment will fail with a `ModuleNotFoundError`.

5. Visit the output URL to test your API.

## Troubleshooting

If your app fails to start or you encounter issues:

1. **Check the App Service logs:**
   - Go to the Kudu/Advanced Tools site for your app:
     - `https://<your-app-service-name>.scm.azurewebsites.net/DebugConsole`
     - Example: [https://hello-world-api-keithkeithkeithkeith.scm.azurewebsites.net/DebugConsole](https://hello-world-api-keithkeithkeithkeith.scm.azurewebsites.net/DebugConsole)
   - In the Debug Console, navigate to the `LogFiles` directory to view logs and diagnose problems.

2. **Check the Log Stream in Azure Portal:**
   - Go to your App Service in the Azure Portal.
   - Select **Log stream** from the left menu to view real-time logs.

3. **Common Issues:**
   - App not listening on the correct port (should use the `PORT` environment variable).
   - Startup command or file/module name mismatch.
   - Missing dependencies in `requirements.txt`.

## Note

- Remember to destroy the infrastructure after testing to avoid unnecessary charges:

  ```bash
  cd ../terraform
  terraform destroy
  ```
