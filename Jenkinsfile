node {
	parameters {
		string(name: 'BRANCH', defaultValue: 'master', description: 'git分支')
		string(name: 'CREDENTIALS_ID', defaultValue: 'github', description: 'git凭据Id')
		string(name: 'GIT', defaultValue: 'https://github.com/q275541240/eureka.git', description: 'git地址')
		string(name: 'CONTAINER_NAME', defaultValue: 'eureka-single', description: '容器名')
		string(name: 'IMAGE_NAME', defaultValue: 'eureka-single', description: '镜像名')
		string(name: 'JAR_FILE', defaultValue: 'eureka.jar', description: 'Dockerfile中ARG值')
		string(name: 'WORK_PATH', defaultValue: '/web/', description: 'Dockerfile中ARG值')
		string(name: 'EXPOSE_PORT', defaultValue: '8000', description: 'Dockerfile中ARG值')
		string(name: 'JAVA_OPTS', defaultValue: '-Xmx64m -Xms64m', description: 'jvm参数')
		string(name: 'ACTIVE_PROFILES', defaultValue: '--spring.profiles.active=single', description: 'jvm参数')
	}

	stage('Pull Code') {
		git branch: '${BRANCH}', credentialsId: '${CREDENTIALS_ID}', url: '${GIT}'
	}
	stage('Maven Package') {
		sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
	}
	stage('Docker Stop Container') {
		try{
    	    sh 'sudo docker stop "${CONTAINER_NAME}"'
    	}catch(e){
    	    echo 'Docker stop container error'
    	}
	}
	stage('Docker Remove Container') {
		try{
		    sh 'sudo docker rm "${CONTAINER_NAME}"'
    	}catch(e){
    	    echo 'Docker remove container error'
    	}
	}
	stage('Docker Remove Image') {
		try{
		sh 'sudo docker rmi "${IMAGE_NAME}"'
        }catch(e){
            echo 'Docker remove image error'
        }
	}
	stage('Docker Build Image') {
		sh 'sudo docker build -t "${IMAGE_NAME}" --build-arg JAR_FILE="${JAR_FILE}" --build-arg EXPOSE_PORT="${EXPOSE_PORT}" --build-arg WORK_PATH="${WORK_PATH}" --build-arg JAVA_OPTS="${JAVA_OPTS}" --build-arg ACTIVE_PROFILES="${ACTIVE_PROFILES}" .'
	}
	stage('Docker Start Image') {
		sh 'sudo docker run -p "${EXPOSE_PORT}":"${EXPOSE_PORT}" -dit -v /etc/localtime:/etc/localtime -v /etc/hosts:/etc/hosts --name "${CONTAINER_NAME}" "${IMAGE_NAME}"'
	}
}