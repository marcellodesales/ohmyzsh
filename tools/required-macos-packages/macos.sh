bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install jq yq argocd
brew install coreutils python3 helm kustomize operator-sdk kind grype watch go cmake gcc crane mtr pnpm node
brew install gpg gitmoji

echo "Opening font downloader... install the font..."
open https://github.com/powerline/fonts/blob/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf 

echo "Go to Iterm2 -> Preferences -> Profiles -> Default -> Text -> Fonts"

