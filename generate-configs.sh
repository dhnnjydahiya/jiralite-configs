#!/bin/bash

# Set target folder
CONFIG_DIR="./jira-lite-config-repo"

# Create directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Create application.yml
cat > "$CONFIG_DIR/application.yml" <<EOL
spring:
  application:
    name: config-repo
  cloud:
    config:
      server:
        git:
          uri: https://github.com/your-username/jira-lite-config-repo
          default-label: main
          clone-on-start: true
          search-paths: '{application}'
server:
  port: 8888
EOL

# Create application.properties for configserver
cat > "$CONFIG_DIR/configserver.properties" <<EOL
server.port=8888
spring.application.name=configserver
spring.cloud.config.server.git.uri=https://github.com/your-username/jira-lite-config-repo
spring.cloud.config.server.git.default-label=main
spring.cloud.config.server.git.clone-on-start=true
spring.cloud.config.server.git.search-paths={application}
EOL

# Create jira-lite.yml
cat > "$CONFIG_DIR/jira-lite.yml" <<EOL
server:
  port: 8081

spring:
  application:
    name: jira-lite
EOL

# Create jira-lite-dev.yml
cat > "$CONFIG_DIR/jira-lite-dev.yml" <<EOL
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/jira_dev
    username: dev_user
    password: dev_pass

logging:
  level:
    root: DEBUG
EOL

# Create jira-lite-prod.yml
cat > "$CONFIG_DIR/jira-lite-prod.yml" <<EOL
spring:
  datasource:
    url: jdbc:mysql://prod-db-server:3306/jira_prod
    username: prod_user
    password: prod_pass

logging:
  level:
    root: WARN
EOL

echo "✅ All configuration files have been created in $CONFIG_DIR"
