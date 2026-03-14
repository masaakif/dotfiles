# ghq helpers

# short ghq get (GitHub only)
# gget() {
#   ghq get "git@github.com:$1.git"
# }

# cd to ghq repo with fzf
gcd() {
  cd "$(ghq list -p | fzf)"
}

grg() {
  rg "$@" "$(ghq root)"
}
