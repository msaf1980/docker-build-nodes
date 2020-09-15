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

DIR="docker-${IMAGE_TAG}"
[ -d "${DIR}" ] || {
  echo "${DIR} not exist, check IMAGE_TAG" >&2
  exit 1
}

IMAGE="`echo ${IMAGE_TAG} | awk ' match($0, /^(.+)-([0-9\.]+)$/, p) { printf "%s:%s", p[1], p[2] } '`" 
[ "${IMAGE}" == "" -o "${IMAGE}" == ":" ] && {
  echo "parse IMAGE_TAG ${IMAGE_TAG} return ${IMAGE}, IMAGE_TAG must be in format NAME-VERSION" >&2
  exit 1
}

[ -z "${REGISTRY_URL}" ] && {
  PUSH_URL="${REGISTRY_PROJECT}/${IMAGE}"
} || {
  PUSH_URL="${REGISTRY_URL}/${REGISTRY_PROJECT}/${IMAGE}"
}
echo ${PUSH_URL} from ${IMAGE_TAG}

docker build \
      --label "branch=${CI_COMMIT_REF_NAME}" \
      --label "commit=${CI_COMMIT_SHA}" \
      --label "builder=${CI_USER_NAME}" \
      --tag "${PUSH_URL}" "${DIR}" || exit 1

docker push "${PUSH_URL}" || exit 1
