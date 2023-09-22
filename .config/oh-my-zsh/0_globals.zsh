KERNEL_NAME="$(uname -s)"
MACHINE_NAME="$(uname -m)"

function is_cygwin() {
  [[ "${KERNEL_NAME}" = CYGWIN* ]]
}

function is_mac() {
  [[ "${KERNEL_NAME}" = Darwin ]]
}

if grep microsoft /proc/sys/kernel/osrelease &>/dev/null; then
  IS_WSL=true
else
  IS_WSL=false
fi

function has_cmd() {
  command -v "$1" >/dev/null
  return 0
}

function is_raspberry_pi_os_64() {
  grep "Raspberry Pi" /proc/device-tree/model &>/dev/null && [ "aarch64" = "${MACHINE_NAME}" ]
}
function is_intellij_terminal() {
  compgen -v | grep -e "^_INTELLIJ_.*" >/dev/null && [ $SHLVL = "1" ]
}


export EDITOR=vim
export DEFAULT_PROXY="127.0.0.1:8080"
if $IS_WSL; then
  # WSL Interface on Windows Host
  WINHOST=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
  export DEFAULT_PROXY="$WINHOST:8080"
  export DISPLAY="$WINHOST:0.0"
fi

bindkey '\e.' insert-last-word
bindkey '≥' insert-last-word
if has_cmd dircolors; then
  eval $(dircolors ~/.dircolors.256dark)
  zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
  alias ls='ls --color=auto'
fi

#Terraform
TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
[ -d "${TF_PLUGIN_CACHE_DIR}" ] || mkdir -p "${TF_PLUGIN_CACHE_DIR}"
if is_cygwin; then
  TF_PLUGIN_CACHE_DIR="$(cygpath -m "${TF_PLUGIN_CACHE_DIR}")"
fi
export TF_PLUGIN_CACHE_DIR

#Golang
GOPATH="$HOME/go"
GOBIN="${GOPATH}/bin"
if is_cygwin; then
  #Under cygwin, golang don't recognize unix path style
  GOPATH=$(cygpath -m "${GOPATH}")
  GOBIN=$(cygpath -m "${GOBIN}")
  #Cygwin need the unix path
  PATH="$(cygpath -u "${GOBIN}"):$PATH"
else
  PATH="${GOBIN}:$PATH"
fi
export GOPATH GOBIN

if is_cygwin; then
  export MAVEN_OPTS="-Duser.language=en -Duser.home=$(cygpath -w "$HOME") -Dfile.encoding=UTF-8"
  export JAVA_HOME="D:/jdks/jdk-11.0.8"
  export DOCKER_HOST="127.0.0.1:7070"

  function enable_msvc() {
    VCBUILD_PATH=$(cygpath -u 'D:\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build')
    if [ -d "${VCBUILD_PATH}" ]; then
    query_vcvarsall() {
      local envvar=$1
      (cd "${VCBUILD_PATH}" &&
       cmd /c "VcVarsAll.bat amd64 >nul && d:/cygwin/bin/bash -c 'printenv ${envvar}'")
    }
      export PATH="$(query_vcvarsall PATH):$PATH"
      export INCLUDE="$(query_vcvarsall INCLUDE)"
      export LIB="$(query_vcvarsall LIB)"
    fi
  }

fi

### nnn settings
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
export NNN_FCOLORS=c1e2272e006033f7c6d6abc4
export NNN_COLORS=1234
export NNN_OPTS="cdEnrx"
export PATH=$HOME/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
