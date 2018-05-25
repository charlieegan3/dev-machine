#!/usr/bin/env bash
# Base16 London Tube - Gnome Terminal color scheme install script - Jan T. Sott
# Modified by charliegan3

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 London Tube Dark (tmux)"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-londontube-dark-tmux"
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
  local key="$1"; shift
  local val="$1"; shift

  if [[ "$type" == "string" ]]; then
    val="'$val'"
  fi

  "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
  {
    "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
    echo "'$val'"
  } | head -c-1 | tr "\n" ,
  )"

  "$DCONF" write "$key" "[$entries]"
}

profiles=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep ":")
for profile in $profiles; do
  echo "Removing Profile $profile"
  dconf reset -f /org/gnome/terminal/legacy/profiles:/$profile
done

[[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

if which "$UUIDGEN" > /dev/null 2>&1; then
  PROFILE_SLUG=`uuidgen`
fi

if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
  DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
else
  DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
fi

DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

# copy existing settings from default profile
$DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

# add new copy to list of profiles
dlist_append $BASE_KEY_NEW/list "$PROFILE_SLUG"

# update profile values with theme options
dset visible-name "'$PROFILE_NAME'"
dset palette "['#231f20', '#ee2e24', '#00853e', '#ffd204', '#009ddc', '#98005d', '#85cebc', '#d9d8d8', '#737171', '#ee2e24', '#00853e', '#ffd204', '#009ddc', '#98005d', '#85cebc', '#ffffff']"
dset background-color "'#231f20'"
dset foreground-color "'#d9d8d8'"
dset bold-color "'#d9d8d8'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
dset use-custom-command "true"
dset custom-command "'tmux'"

profiles=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep ":")
for profile in $profiles; do
  profile=$(echo $profile | sed -e 's/^://g' | sed -e 's/\/$//g')
  echo "Created $profile"
  dconf write /org/gnome/terminal/legacy/profiles:/default "'$profile'"
  dconf write /org/gnome/terminal/legacy/profiles:/list "['$profile']"
  echo "Configured $profile"
done

unset PROFILE_NAME
unset PROFILE_SLUG
unset DCONF
unset UUIDGEN
