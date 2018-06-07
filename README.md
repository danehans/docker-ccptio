# docker-ccptio

Is a Docker image that runs the Istio E2E "simple" test against a CCP tenant cluster.

Supported Versions:

1. Istio: 0.8.0
2. CCP: 0.1.0

Prerequisites:

1. Access to the kube-apiserver of your CCP tenant cluster.
2. Docker
3. `kubectl` credentials for your tenant cluster.

Clone this repo:
```
git clone https://github.com/danehans/docker-ccptio.git && cd docker-ccptio
```

Copy your `kubectl` credentials to this repo:
```
cp ~/.kube/config .
```

Run the E2E "simple" test my building the Docker image:
```
docker build --rm .
```
