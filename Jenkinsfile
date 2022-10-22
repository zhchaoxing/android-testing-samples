agent {label "linux"}
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
			// sh './test_all.sh'
			//sh 'integration/ServiceTestRuleSample ./gradlew integration/ServiceTestRuleSample testDebug connectedAndroidTest'
			//sh 'runner/AndroidJunitRunnerSample ./gradlew runner/AndroidJunitRunnerSample testDebug connectedAndroidTest'
			//sh 'runner/AndroidTestOrchestratorSample ./gradlew runner/AndroidTestOrchestratorSample testDebug connectedAndroidTest'
			
			
			
			sh 'ANDROID_SERIAL=emulator-5556' 
			//# wait for emulator to be up and fully booted, unlock screen
			sh '$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
				

			
			withGradle {
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
			}
        }
		
		stage('test unsigned release ') {
			sh 'ANDROID_SERIAL=emulator-5556' 
			//# wait for emulator to be up and fully booted, unlock screen
			sh '$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
			dir("ui/espresso/AccessibilitySample") {
				sh './gradlew testDebug connectedAndroidTest'
			}
		}
		
        stage('Compile') {
            archiveArtifacts artifacts: '**/*.apk', fingerprint: true, onlyIfSuccessful: true            
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
  
