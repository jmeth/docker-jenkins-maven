# docker-jenkins-maven
---

Jenkins Docker Container with Maven Runtime

---

# Usage

```
docker run -p 8080:8080 -p 50000:50000 jmeth/jenkins-mvn
```

NOTE: read below the _build executors_ part for the role of the `50000` port mapping.

This will store the workspace in /var/jenkins_home. All Jenkins data lives in there - including plugins and configuration.
You will probably want to make that a persistent volume (recommended):

```
docker run -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home jmeth/jenkins-mvn
```

This will store the jenkins data in `/your/home` on the host.
Ensure that `/your/home` is accessible by the jenkins user in container (jenkins user - uid 1000) or use `-u some_other_user` parameter with `docker run`.


You can also use a volume container:

```
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jmeth/jenkins-mvn
```

Then myjenkins container has the volume (please do read about docker volume handling to find out more).


Link with [Docker Official Sonarqube](https://hub.docker.com/_/sonarqube/) 

```
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home --link sonarqube:sonarqube jmeth/jenkins-mvn
```


See the [Docker Official Jenkins](https://hub.docker.com/_/jenkins/) for more info.
