pipeline{
    agent any
    environment{
        SONAR_HOME= tool "sonar"
    }
    stages{
        stage("Clone Code from GitHub"){
            steps{
                git url: "https://github.com/Prateekbhaisare/three_tier_project.git", branch: "main"
            }
        }
        stage('SonarQube Quality Analysis') {
            steps {
                withSonarQubeEnv("sonar") {
                    sh """
                        ${SONAR_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=wanderlust \
                        -Dsonar.projectName=wanderlust \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://sonarqube:9000
                    """
                }
            }
        }
        
        stage('Install Node Modules') {
            steps {
                dir('wanderlust_devops/my_three_tier_project/frontend') {
                    sh 'npm install'
                }
            }
        }
        
        stage("OWASP Dependency Check"){
            steps{
                dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'dc'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage("Sonar Quality Gate Scan"){
            steps{
                timeout(time: 2, unit: "MINUTES"){
                    waitForQualityGate abortPipeline: false
                }
            }
        }

        stage("Deploy using Docker compose"){
            steps{
                dir('my_three_tier_project') {  
                    sh 'docker compose down' || true
                    sh 'docker compose up -d'
                }
            }
        }
    }
}


