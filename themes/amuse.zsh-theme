# vim:ft=zsh ts=2 sw=2 sts=2

docker_prompt_info() {
  if [ ! -z "${DOCKER_VERSION}" ]; then
    DOCKER_ANY=$(find . -maxdepth 1 -name "*Dockerfile*" | wc -l | awk '{print $1}')
    if [ ${DOCKER_ANY} -gt 0 ]; then
      PROMPT="%{$fg[cyan]%}docker@${DOCKER_VERSION}%{$reset_color%}"
      echo "🐳 ${PROMPT}"
    fi
  fi
}

compose_prompt_info() {
  if [ ! -z "${COMPOSE_VERSION}" ]; then
    COMPOSE_ANY=$(find . -maxdepth 1 -name "*docker-compose*" | wc -l | awk '{print $1}')
    if [ ${COMPOSE_ANY} -gt 0 ]; then
      PROMPT="%{$fg[cyan]%}docker-compose@${COMPOSE_VERSION}%{$reset_color%}"
      echo "🐙 ${PROMPT}"
    fi
  fi
}

kubectl_prompt_info() {
  if [ ! -z "${KUBECTL_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}kubectl@${KUBECTL_VERSION}%{$reset_color%}"
    echo "☸️  ${PROMPT}"
  fi
}

kustomize_prompt_info() {
  if [ ! -z "${KUSTOMIZE_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}kustomize@${KUSTOMIZE_VERSION}%{$reset_color%}"
    echo "📛 ${PROMPT}"
  fi
}

helm_prompt_info() {
  if [ ! -z "${HELM_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}helm@${HELM_VERSION}%{$reset_color%}"
    echo "🎡 ${PROMPT}"
  fi
}

argocd_prompt_info() {
  if [ ! -z "${ARGOCD_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}argocd@${ARGOCD_VERSION}%{$reset_color%}"
    echo "👽 ${PROMPT}"
  fi
}

eiam_prompt_info() {
  if [ ! -z "${EIAM_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}aws-iam-authenticator@${EIAM_VERSION}%{$reset_color%}"
    echo "🔖 ${PROMPT}"
  fi
}

aws_prompt_info() {
  if [ ! -z "${AWS_CLI_VERSION}" ]; then
    PROMPT="%{$fg[cyan]%}aws-cli@${AWS_CLI_VERSION}%{$reset_color%}"
    echo "☁️  ${PROMPT}"
  fi
}

terraform_prompt_info() {
  if [ ! -z "${TERRAFORM_VERSION}" ]; then
    DOCKER_ANY=$(find . -maxdepth 1 -name "*.tf" | wc -l | awk '{print $1}')
    if [ ${DOCKER_ANY} -gt 0 ]; then
      PROMPT="%{$fg[cyan]%}terraform@${TERRAFORM_VERSION}%{$reset_color%}"
      echo "🏗  ${PROMPT}"
    fi
  fi
}

kube_ps1() {
  if [ ! -z "${KUBECTL_VERSION}" ]; then
    KUBE_PS1_CONTEXT="$(kubectl config current-context)"
    KUBE_PS1_NAMESPACE="$(kubectl config view --minify --output 'jsonpath={..namespace}')"
    KUBE_PS1_NAMESPACE="${KUBE_PS1_NAMESPACE:-default}"
    K8S_CONTEXT="%{$fg_bold[blue]%}📦 ${KUBE_PS1_NAMESPACE} 🔐 ${KUBE_PS1_CONTEXT}"
    echo "${K8S_CONTEXT}"
  fi
}

aws_ps1() {
  if [ ! -z "${AWS_CLI_VERSION}" ]; then
    AWS_PS1_PROFILE="${AWS_DEFAULT_PROFILE:-default}"
    AWS_PS1_PROFILE="${AWS_PROFILE:-AWS_PS1_PROFILE}"
    # https://stackoverflow.com/questions/31331788/using-aws-cli-what-is-best-way-to-determine-the-current-region/63496689#63496689
    AWS_PS1_REGION="$(aws configure get region)"
    AWS_CONTEXT="%{$fg_bold[blue]%}👤 ${AWS_PS1_PROFILE} 🌎 ${AWS_PS1_REGION}"
    echo "${AWS_CONTEXT}"
  fi
}


terraform_ps1() {
  if [ ! -z "${TERRAFORM_VERSION}" ]; then
    TERRA_ANY=$(find . -maxdepth 1 -name "*.tf" | wc -l | awk '{print $1}')
    if [ ${TERRA_ANY} -gt 0 ]; then
      TERRAFORM_PS1_CONTEXT=$(terraform workspace show)
      TERRAFORM_CONTEXT="%{$fg_bold[blue]%}🚧 workspace ${TERRAFORM_PS1_CONTEXT}"
      echo "${TERRAFORM_CONTEXT}"
    fi
  fi
}

git_remote() {
  GIT_ANY=$(find . -maxdepth 1 -name "*.git" | wc -l | awk '{print $1}')
  if [ ${GIT_ANY} -gt 0 ]; then
    GIT_REMOTE_ORIGIN=$(git remote show origin | grep Fetch | awk '{split($0,a,"URL:"); print a[2]}' | sed 's/ //g' | sed 's/https:\/\///g' | sed 's/git@//g')
   PROMPT="%{$fg_bold[yellow]%}${GIT_REMOTE_ORIGIN}%{$reset_color%}"
   echo "🧰 ${PROMPT}"
 fi
}
# Too slow to make git calls here
# %{$reset_color%}$(git_remote)%{$reset_color%}

PROMPT='
$(aws_prompt_info) $(eiam_prompt_info) $(terraform_prompt_info)
$(kubectl_prompt_info) $(kustomize_prompt_info) $(helm_prompt_info) $(argocd_prompt_info) $(docker_prompt_info) $(compose_prompt_info)
%{$reset_color%}$(aws_ps1)%{$reset_color%} %{$reset_color%}$(terraform_ps1)%{$reset_color%}
%{$reset_color%}$(kube_ps1)%{$reset_color%} 
%{$fg_bold[green]%}${PWD/#$HOME/~} $(git_prompt_info) ⌚ %{$fg_bold[red]%}%*%{$reset_color%}
$ '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}on %{$fg_bold[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

if [ -e ~/.rvm/bin/rvm-prompt ]; then
  RPROMPT='%{$fg_bold[red]%}‹$(rvm_current)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    RPROMPT='%{$fg_bold[red]%}$(rbenv_version)%{$reset_color%}'
  fi
fi

