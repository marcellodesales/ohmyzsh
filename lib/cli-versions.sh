export AWS_CLI_VERSION=`aws --version | awk '{print $1}' | awk -F "/" '{print $2}'`

COMPOSE_VERSION=`docker-compose -v`
COMPOSE_VERSION=${COMPOSE_VERSION#*version}
COMPOSE_VERSION=${COMPOSE_VERSION%,*}
export COMPOSE_VERSION=${COMPOSE_VERSION/ /}

DOCKER_VERSION=`docker -v`
DOCKER_VERSION=${DOCKER_VERSION#*version}
DOCKER_VERSION=${DOCKER_VERSION%,*}
export DOCKER_VERSION=${DOCKER_VERSION/ /}

KUBECTL_VERSION=`kubectl version --client --short`
KUBECTL_VERSION=${KUBECTL_VERSION#*v}
export KUBECTL_VERSION=${KUBECTL_VERSION/ /}

HELM_VERSION=`helm version --client --short`
HELM_VERSION=${HELM_VERSION#*v}
HELM_VERSION=${HELM_VERSION%+*}
export HELM_VERSION=${HELM_VERSION/ /}

KUSTOMIZE_VERSION=`kustomize version --short | awk '{print $1}' | awk -F/ '{print $2}'`
export KUSTOMIZE_VERSION=${KUSTOMIZE_VERSION}

ARGOCD_VERSION=`argocd version --client --short`
ARGOCD_VERSION=${ARGOCD_VERSION#*v}
ARGOCD_VERSION=${ARGOCD_VERSION%+*}
export ARGOCD_VERSION=${ARGOCD_VERSION/ /}

export EIAM_VERSION=`aws-iam-authenticator version -o yaml | grep Version | awk '{print $2}'`

export TERRAFORM_VERSION=`terraform --version | grep -m1 "" | awk '{print $2}'`

export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWUPSTREAM="yes"
# ARGOCD


