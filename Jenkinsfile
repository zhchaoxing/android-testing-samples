//https://medium.com/appgambit/build-android-application-with-jenkins-pipeline-9e2f6667bae1
agent {label "linux && android"}
node {

	def err = null
	try {
      
        stage('Preparation') { 
            //From other ppl git credentialsId: 'fef4159e-285b-45d9-80ca-5981c4576ba5', url: 'https://github.com/prashant-bhatasana/demoApp/'
			git branch: '$BRANCH_NAME', credentialsId: 'jenkins-hal-testGitHub', url: 'https://github.com/zhchaoxing/android-testing-samples.git'
        }
      
        stage('Dependencies') {
		/*   
                sh 'sudo npm install -g react-native-cli'
                sh 'npm install'
                sh 'react-native link'
                sh 'export JAVA_HOME=/opt/jdk1.8.0_201'  //does not work to change JAVA_HOME and JRE_HOME here, need to set on the agent config
                sh 'export JRE_HOME=/opt/jdk1.8.0_201/jre'
                sh 'export PATH=$PATH:/opt/jdk1.8.0_201/bin:/opt/jdk1.8.0_201/jre/bin'
        */
				//sh 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64'
                //sh 'export JRE_HOME=/usr/lib/jvm/java-11-openjdk-amd64/jre'
                //sh 'export PATH=$PATH:/opt/jdk1.8.0_201/bin:/opt/jdk1.8.0_201/jre/bin'
				sh 'echo ANDROID_HOME: $ANDROID_HOME'
				sh 'echo JRE_HOME: $JRE_HOME'
				sh 'echo JAVA_HOME：$JAVA_HOME'
        }
		
		
		stage('Prep Android') {
			sh 'chmod +x ./prep_android_device.sh'
			sh './prep_android_device.sh'
		}
		
		
		/*
        stage('Clean Build') {
                dir("android") {
                    sh "pwd"
                    sh 'ls -al'
                    sh './clean_all.sh'
                }
        }
		*/
        /*
        stage('Clean Build') {
                sh "pwd"
                sh 'ls -al'
				sh 'chmod +x ./clean_all.sh'
                sh './clean_all.sh'
        }
		*/
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
			// sh './test_all.sh'
			//sh 'integration/ServiceTestRuleSample ./gradlew integration/ServiceTestRuleSample testDebug connectedAndroidTest'
			//sh 'runner/AndroidJunitRunnerSample ./gradlew runner/AndroidJunitRunnerSample testDebug connectedAndroidTest'
			//sh 'runner/AndroidTestOrchestratorSample ./gradlew runner/AndroidTestOrchestratorSample testDebug connectedAndroidTest'
			
			
			
			//withGradle {
				dir("integration/ServiceTestRuleSample") {
					sh './gradlew testDebug connectedAndroidTest'
				}
				dir("runner") {
					dir("AndroidJunitRunnerSample") {
						sh './gradlew testDebug connectedAndroidTest'
					}
					dir("AndroidTestOrchestratorSample") {
						sh './gradlew testDebug connectedAndroidTest'
					}

				}
			//}
        }
		
		stage('test unsigned release ') {
			dir("ui/espresso/AccessibilitySample") {
				sh './gradlew testDebug connectedAndroidTest'
			}
		}
		
        stage('Compile') { //can display download link on build page
            archiveArtifacts artifacts: '**/*.apk', fingerprint: true, onlyIfSuccessful: true            
        }

		stage('Kill Emulator') { //can display download link on build page
            sh '''
        # Disable exit on non 0
        set +e

        kill $(ps aux | grep '[e]mulator' | awk '{print $2}')

        # Enable exit on non 0
        set -e

        '''         
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
}
  
