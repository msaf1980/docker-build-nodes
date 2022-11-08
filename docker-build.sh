#!/bin/sh
# IMAGE_TAG with format NAME-VERSION

FAIL=0
[ -z "${REGISTRY_PROJECT}" ] && {
  echo "REGISTRY_PROJECT not set" >&2
  FAIL=1
}
[ -z "${IMAGE_TAG}" ] && {
  echo "IMAGE_TAG not set (format NAME-VERSION)" >&2
  FAIL=1
}
[ "$FAIL" -ne "0" ] && exit 1

[ -z "${CI_COMMIT_SHA}" ] && CI_COMMIT_SHA="$( git rev-parse --short HEAD )"
[ -z "${CI_COMMIT_REF_NAME}" ] && CI_COMMIT_REF_NAME="$( git symbolic-ref HEAD 2> /dev/null | cut -b 12- )"
[ -z "${CI_USER_NAME}" ] && CI_USER_NAME="$( git config user.email )"

NAME="`echo ${IMAGE_TAG} | sed -E 's/-[0-9\.]+$//'`" 
IMAGE="`echo ${IMAGE_TAG} | sed -E 's/\.[0-9]+$//'`" 
LANG="`echo ${IMAGE_TAG} | awk -F'-' '{ n=NF-1 ; print $n } '`" 
VERSION="`echo ${IMAGE_TAG} | awk -F'-' '{ print $NF  } '`" 
[ "${NAME}" == "" -o "${NAME}" == "${IMAGE_TAG}" ] && {
  echo "parse IMAGE_TAG ${IMAGE_TAG} return NAME ${NAME}, IMAGE_TAG must be in format OS-LANG-VERSION.VERSION_MINOR, dir OS-LANG-VERSIONR must exist" >&2
  exit 1
}
[ "${IMAGE}" == "" -o "${IMAGE}" == "${IMAGE_TAG}" ] && {
  echo "parse IMAGE_TAG ${IMAGE_TAG} return IMAGE ${IMAGE}, IMAGE_TAG must be in format OS-LANG-VERSION.VERSION_MINOR, dir OS-LANG-VERSIONR must exist" >&2
  exit 1
}
[ "${LANG}" == "" -o "${LANG}" == "${IMAGE_TAG}" ] && {
    echo "parse IMAGE_TAG return LANG $LANG, IMAGE_TAG must be in format OS-LANG-VERSION" >&2
    exit 1
}
[ "${VERSION}" == "" -o "${VERSION}" == "${IMAGE_TAG}" ] && {
    echo "parse IMAGE_TAG return VERSION ${VERSION}, IMAGE_TAG must be in format OS-LANG-VERSION" >&2
    exit 1
}

DIR="docker-${IMAGE}"
[ -d "${DIR}" ] || {
  echo "${DIR} not exist, check IMAGE_TAG: ${IMAGE_TAG}" >&2
  exit 1
}

[ -z "${REGISTRY_URL}" ] && {
  PUSH_URL="${REGISTRY_PROJECT}/${NAME}:${VERSION}"
} || {
  PUSH_URL="${REGISTRY_URL}/${REGISTRY_PROJECT}/${NAME}:${VERSION}"
}
LANG_VERSION="${LANG}_version=${VERSION}"
echo "${PUSH_URL} from ${DIR}, ${LANG_VERSION}"

docker build \
      --build-arg ${LANG_VERSION} \
      --label "branch=${CI_COMMIT_REF_NAME}" \
      --label "commit=${CI_COMMIT_SHA}" \
      --label "builder=${CI_USER_NAME}" \
      --tag "${PUSH_URL}" "${DIR}" || exit 1

docker push "${PUSH_URL}" || exit 1
