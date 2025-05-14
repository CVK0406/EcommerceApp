# E-commerce Web Application

A Java-based e-commerce web application built with Servlets, JSP, and MySQL. This application provides a complete online shopping experience with features like product management, shopping cart, order processing, and user authentication.

## Prerequisites

Before you begin, ensure you have the following installed:
- Java Development Kit (JDK) 8 or higher
- Apache Maven 3.6 or higher
- MySQL Server 8.0 or higher
- Apache Tomcat 9.0 or higher
- Git
- Azure CLI (for cloud deployment)

## Project Setup

1. **Clone the Repository**
   ```bash
   git clone <your-repository-url>
   cd EcommerceApp
   ```

2. **Database Setup**
   - Start your MySQL server
   - Create a new database and user (or use existing)
   - Run the initialization script:
     ```bash
     mysql -u your_username -p < init.sql
     ```

3. **Configure Database Connection**
   - Update the database connection properties in your application
   - Default database name: `ecommerce_db`
   - Default character set: `utf8mb4`
   - Default collation: `utf8mb4_unicode_ci`

4. **Build the Project**
   ```bash
   mvn clean install
   ```

5. **Deploy to Tomcat**
   - Copy the generated WAR file from `target/EcommerceApp.war` to your Tomcat's `webapps` directory
   - Start Tomcat server

## Project Structure

```
EcommerceApp/
├── src/                    # Source code
├── target/                 # Compiled files
├── pom.xml                 # Maven configuration
├── init.sql                # Database initialization script
├── .github/               # GitHub Actions workflows
│   └── workflows/
│       └── azure-deploy.yml
```

## Features

- User Authentication and Authorization
- Product Management
- Shopping Cart
- Order Processing
- Category and Brand Management
- Admin Dashboard
- Responsive Design
- Automated CI/CD Pipeline
- Azure Cloud Deployment

## Dependencies

The project uses the following main dependencies:
- Servlet API 3.0
- JSP API 2.2
- MySQL Connector 8.0
- Commons FileUpload 1.4
- Gson 2.10.1
- JUnit 3.8.1 (for testing)

## Default Credentials

- Admin Username: `admin`
- Admin Password: `admin`

## Development

1. **IDE Setup**
   - Import the project as a Maven project in your preferred IDE
   - Configure Tomcat server in your IDE
   - Set up the project to run on Tomcat

2. **Running Locally**
   - Start MySQL server
   - Start Tomcat server
   - Access the application at `http://localhost:8080/EcommerceApp`

## Deployment

### Local Deployment
Follow the steps in the Project Setup section above.

### Azure Cloud Deployment
1. **Automated Deployment**
   - The application is automatically deployed to Azure when changes are pushed to the main branch

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the development team.