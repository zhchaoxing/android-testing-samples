def err = null
try {
    agent {label "linux"}
    node {
      
        stage('Preparation') { 
            //From other ppl git credentialsId: 'fef4159e-285b-45d9-80ca-5981c4576ba5', url: 'https://github.com/prashant-bhatasana/demoApp/'
			git branch: '$BRANCH_NAME', credentialsId: 'jenkins-hal-testGitHub', url: 'https://github.com/android/testing-samples.git'
        }
      
        stage('Dependencies') {
		/*
                sh 'sudo npm install -g react-native-cli'
                sh 'npm install'
                sh 'react-native link'
                sh 'export JAVA_HOME=/opt/jdk1.8.0_201'
                sh 'export JRE_HOME=/opt/jdk1.8.0_201/jre'
                sh 'export PATH=$PATH:/opt/jdk1.8.0_201/bin:/opt/jdk1.8.0_201/jre/bin'
        */
				sh 'echo ANDROID_HOME: $ANDROID_HOME'
				sh 'echo JRE_HOME: $JRE_HOME'
				sh 'echo JAVA_HOME：$JAVA_HOME'
        }
        
        stage('Clean Build') {
                /*
				dir("android") {
                    sh "pwd"
                    sh 'ls -al'
                    sh './clean_all.sh'
                } 
				*/				
				sh "pwd"
                sh 'ls -al'
				sh 'chmod +x ./clean_all.sh'
                sh './clean_all.sh'
        }
        /*
        stage('Build release ') {
            parameters {
                credentials credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: '5d34f6f7-b641-4785-frd5-c93b67e71b6b', description: '', name: 'keystore', required: true
            }
            dir("android") {
                sh './test_all.sh'
            }
        }
        */
		
		stage('Build unsigned release ') {
            /*
			parameters {
                credentials credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: '5d34f6f7-b641-4785-frd5-c93b67e71b6b', description: '', name: 'keystore', required: true
            }
			
            dir("android") {
                sh './test_all.sh'
            }
			*/
			sh './test_all.sh'
        }
		
        stage('Compile') {
            archiveArtifacts artifacts: '**/*.apk', fingerprint: true, onlyIfSuccessful: true            
        }
    }
  
} catch (caughtError) { 
    
    err = caughtError
    currentBuild.result = "FAILURE"

} finally {
    
    if(currentBuild.result == "FAILURE"){
              sh "echo 'Build FAILURE'"
    }else{
         sh "echo 'Build SUCCESSFUL'"
    }
   
}