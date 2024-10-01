# Step-by-Step Guide from Installation to Deployment

This guide will take you through the process of setting up Docker and Docker Compose on a Linux machine, building Docker images, configuring databases, and deploying your application.

## Step 1: Install Docker on Linux

1. **Update the package database:**

   ```sh
   sudo apt-get update
   ```

2. **Install packages to allow apt to use a repository over HTTPS:**

   ```sh
   sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
   ```

3. **Add Docker’s official GPG key:**

   ```sh
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```

4. **Add the Docker APT repository:**

   ```sh
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   ```

5. **Update the package database again:**

   ```sh
   sudo apt-get update
   ```

6. **Install Docker:**

   ```sh
   sudo apt-get install docker-ce -y
   ```

7. **Check that Docker is installed correctly by running the hello-world image:**

   ```sh
   sudo docker run hello-world
   ```

## Step 2: Install Docker Compose

1. **Download the current stable release of Docker Compose:**

   ```sh
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. **Apply executable permissions to the Docker Compose binary:**

   ```sh
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Verify the installation:**

   ```sh
   docker-compose --version
   ```

## Step 3: Build Docker Images

1. **Open a terminal and navigate to the project directory where the Dockerfiles are located.**

2. **Build the PHP Docker image:**

   ```sh
   docker build . -t <docker-repo>/afriqom-api:alpha
   ```

3. **Build the NGINX Docker image:**

   ```sh
   docker build -t <docker-repo>/afriqom-nginx:alpha deploy/nginx/
   ```

   Note: Replace &lt;docker-repo&gt; with a valid repo name.
   Additional Notes: When SSL certificate in renewed, replace the content of deploy/nginx/ssl/ (take note of the filenames and replace them as-is). After files are replaced, re-run the NGINX Build command above.

## Step 4: Start Services with Docker Compose

1. **Make sure you are in the root directory of the project where the `docker-compose.yml` file is located.**

2. **Ensure that the environment variables in the `docker-compose.yml` are correctly set:**

3. **Start the services using Docker Compose:**

   ```sh
   docker compose up -d
   ```

   or

   ```sh
   docker-compose up -d
   ```

4. **Confirm that Docker containers are running:**

   ```sh
   docker ps
   ```

This command lists all the running containers. You should see entries for the api and web services, indicating that they are running.

## Step 5: Configure MySQL Databases

1. **Create the necessary databases in MySQL:**
   - `afriqom`
   - `afriqom_roles`

2. **Import the SQL files from the `db_scripts` directory into the respective databases:**

   ```sh
   mysql -u root -p afriqom < db_scripts/dev/afriqom.sql
   mysql -u root -p afriqom_roles < db_scripts/dev/afriqom_roles.sql
   ```

## Step 6: Generate XML

1. **Run the following command to generate the XML:**

   ```sh
   curl --location 'http://[domain-name]/api/xmlgen.php' --header 'Content-Type: application/json'
   ```

   The output should look something like this:

   ```text
   --- Generating XML: dbres=primary ---
   primary.blobs.xml
   primary.databoards.xml
   primary.organisations.xml
   primary.subscriptions.xml
   primary.user_subscriptions.xml
   primary.users.xml
   --- Generating XML: dbres=users ---
   users.permissions.xml
   users.preferences.xml
   users.roles.xml
   users.user_roles_lookup.xml
   users.vw_permissions.xml
   --- Creating Administrator Role ---
   --- Administrator role already created ---
   --- Assigning/Updating Administrator Permissions ---
   api.primary.blobs
   api.primary.databoards
   api.primary.organisations
   api.primary.sessions
   api.primary.subscriptions
   api.primary.user_subscriptions
   api.primary.users
   api.users.permissions
   api.users.preferences
   api.users.roles
   api.users.user_roles_lookup
   api.users.vw_permissions
   --- Assigning/Updating Administrator extension Permissions ---
   api.ext.generate.Hash
   api.ext.generate.Pin
   api.ext.push.AdvancedEmail
   api.ext.push.Email
   api.ext.push.SMS
   --- EXTENSIONS DIRECTORY DOES NOT EXIST ---
   --- Assigning/Updating Administrator UI Model Permissions ---
   --- Completed ---
   ```

## Step 7: Execute API Requests

1. **Obtain a session token by logging in:**

   ```sh
   curl --location 'http://[domain-name]/api/index.php?f=sessions:login' \
   --header 'Content-Type: application/json' \
   --data-raw '{
       "username": "admin@afriqom.com",
       "password": "<valid-password>"
   }'
   ```

   Save the token from the response for subsequent requests.

2. **Use the token to make API requests. Replace `your_token` with the actual token obtained from the login request:**

   - **List users:**

     ```sh
     curl --location 'http://[domain-name]/api/index.php?f=users:list&token=your_token' \
     --header 'Content-Type: application/json'
     ```

   - **Get details of a specific user:**

     ```sh
     curl --location 'http://[domain-name]/api/index.php?f=users:list&id=1&token=your_token' \
     --header 'Content-Type: application/json'
     ```

   - **Get specific fields of a user:**

     ```sh
     curl --location 'http://[domain-name]/api/index.php?f=users:list&id=1&fields=id%2Cfull_name%2Cemail%2Cphone_number&token=your_token' \
     --header 'Content-Type: application/json'
     ```

   - **List users with pagination:**

     ```sh
     curl --location 'http://[domain-name]/api/index.php?f=users:list&limit=100&offset=0&token=your_token' \
     --header 'Content-Type: application/json'
     ```

3. **To view user permission data from the roles database, use the `dbres` parameter:**

   ```sh
   curl --location 'http://[domain-name]/api/index.php?f=user_roles_lookup:list&token=your_token&dbres=users' \
   --header 'Content-Type: application/json'
   ```

4. **To view all permissions associated with roles:**

   ```sh
   curl --location 'http://[domain-name]/api/index.php?f=permissions:list&token=your_token&dbres=users' \
   --header 'Content-Type: application/json'
   ```

## Step 8: Refer to the Database

1. **Check the database for the list of tables and views to update REST calls accordingly.**

## Additional Notes

- Ensure MySQL is running and accessible.
- Verify that Docker and Docker Compose are installed and running on your machine.
- Replace placeholder values with actual data where necessary.

