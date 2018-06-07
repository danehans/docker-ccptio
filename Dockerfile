FROM golang:1.9.2

# Set environment variables used by Istio E2E test framework
ENV GOPATH=/go
ENV HUB=istio
ENV TAG=0.8.0
ENV ISTIO_VERSION=0.8.0
ENV ISTIO_BRANCH=release-0.8
ENV KUBECTL_VERSION=1.10.1
ENV ISTIO=/go/src/istio.io

# Download and setup kubectl client used by Istio E2E test framework. 
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN mkdir -p /root/.kube
COPY config /root/.kube/

# Download and setup istioctl client used by Istio E2E test framework. 
RUN curl -L https://git.io/getLatestIstio | sh -
RUN chmod +x istio-${ISTIO_VERSION}/bin/istioctl
RUN mv istio-${ISTIO_VERSION}/bin/istioctl /usr/local/bin/

# Download and setup Istio source code used to build binaries and run Istio E2E tests.
RUN mkdir -p $ISTIO
RUN cd $ISTIO && git clone -b ${ISTIO_BRANCH} https://github.com/istio/istio.git
WORKDIR $ISTIO/istio
RUN make e2e_simple E2E_ARGS="--auth_enable --use_local_cluster --istioctl /usr/local/bin/istioctl"
