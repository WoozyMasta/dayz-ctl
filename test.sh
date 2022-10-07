#!/usr/bin/env bash

docker run --rm -ti -e TEST_MODE=true ubuntu:22.04 bash
apt update
apt install curl -y
# shellcheck disable=SC2016
printf '%s\n' '#!/usr/bin/env bash' 'printf '\''Steam: %s\n'\'' "${@}"' > /bin/steam
chmod +x /bin/steam
mkdir -p "$HOME/.steam/steam/steamapps/common/DayZ"
curl -sSfL https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/install | bash
