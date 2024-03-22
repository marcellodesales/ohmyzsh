export AWS_CLI_VERSION=`aws --version 2>/dev/null | awk '{print $1}' | awk -F "/" '{print $2}'`
export AZ_CLI_VERSION=`az version 2>/dev/null | jq '."azure-cli"' -r`

COMPOSE_VERSION=`docker-compose -v 2>/dev/null`
COMPOSE_VERSION=${COMPOSE_VERSION#*version}
COMPOSE_VERSION=${COMPOSE_VERSION%,*}
export COMPOSE_VERSION=${COMPOSE_VERSION/ /}

DOCKER_VERSION=`docker -v 2>/dev/null`
DOCKER_VERSION=${DOCKER_VERSION#*version}
DOCKER_VERSION=${DOCKER_VERSION%,*}
export DOCKER_VERSION=${DOCKER_VERSION/ /}

KUBECTL_VERSION=$(kubectl version --client --short 2>/dev/null | grep Client | awk -F ": " '{print $2}')
KUBECTL_VERSION=${KUBECTL_VERSION#*v}
export KUBECTL_VERSION=${KUBECTL_VERSION/ /}

K8S_VERSION=`kubectl version --short 2>/dev/null | grep Server | awk '{print $3}'`
K8S_VERSION=${K8S_VERSION#*v}
export K8S_VERSION=${K8S_VERSION/ /}

KEYBASE_VERSION=`keybase version -f s 2>/dev/null | grep Client: | awk '{ print $2 }'`
export KEYBASE_VERSION=${KEYBASE_VERSION}
export KEYBASE_USERNAME=`keybase whoami 2>/dev/null`

HELM_VERSION=`helm version --client --short 2>/dev/null`
HELM_VERSION=${HELM_VERSION#*v}
HELM_VERSION=${HELM_VERSION%+*}
export HELM_VERSION=${HELM_VERSION/ /}

KUSTOMIZE_VERSION=`kustomize version --short 2>/dev/null | awk '{print $1}' | awk -F/ '{print $2}'`
export KUSTOMIZE_VERSION=${KUSTOMIZE_VERSION}
if [ -z "${KUSTOMIZE_VERSION}" ]; then
  KUSTOMIZE_VERSION=$(kubectl version --client --short 2>/dev/null | grep Kustomize | awk -F ": " '{print $2}')
  KUSTOMIZE_VERSION=${KUBECTL_VERSION#*v}
  export KUSTOMIZE_VERSION=${KUSTOMIZE_VERSION/ /}
fi


ARGOCD_VERSION=`argocd version --client --short 2>/dev/null`
ARGOCD_VERSION=${ARGOCD_VERSION#*v}
ARGOCD_VERSION=${ARGOCD_VERSION%+*}
export ARGOCD_VERSION=${ARGOCD_VERSION/ /}

ARGO_VERSION=`argo version --short 2>/dev/null | awk '{print $2}' 2>/dev/null`
ARGO_VERSION=${ARGO_VERSION#*v}
ARGO_VERSION=${ARGO_VERSION%+*}
export ARGO_VERSION=${ARGO_VERSION/ /}

export GLOOCTL_VERSION=`glooctl version 2>/dev/null | grep "Client: " | awk '{print $2}' | jq -r '.version'`

export EIAM_VERSION=`aws-iam-authenticator version -o yaml 2>/dev/null | grep Version | awk '{print $2}'`

export TERRAFORM_VERSION=`terraform --version 2>/dev/null | grep -m1 "" | awk '{print $2}'`
export PACKER_VERSION=`packer version 2>/dev/null | awk '{print $2}'`

export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWUPSTREAM="yes"

#export AWS_ACCOUNT=`aws sts get-caller-identity | jq -r '.Account'`