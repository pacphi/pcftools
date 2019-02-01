#!/bin/bash

# A curated collection of software to be installed manually and via
# package management for use by Cloud Foundry operators.
# @author Chris Phillipson
# @see http://brew.sh/, https://caskroom.github.io/, and https://github.com/cloudfoundry/homebrew-tap

set -e

export CREDALERT_VERSION=2018-12-07-21-29-15

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Caskrooms
brew tap caskroom/cask
brew tap starkandwayne/cf
brew tap cloudfoundry/tap
brew tap caskroom/versions

# Declare installation packages
brews=( "awscli" "azure-cli" "bosh-cli" "cf-cli" "credhub-cli" "go" "starkandwayne/cf/govc" "jq" "kubernetes-cli" "kubectx" "wget" "git" "starkandwayne/cf/om" "openssl" "python3" "ruby" "pivnet-cli" "starkandwayne/cf/riff" "terraform" "tmux" "wireshark" "wget" "zsh" )
casks=( "google-cloud-sdk" "iterm2" "sourcetree" "visual-studio-code" )

# Install packages
for i in "${brews[@]}"
do
  brew install $i
done

for i in "${casks[@]}"
do
  brew cask install $i
done

# Install cf-uaac
gem install cf-uaac

# Install version managed CLIs
wget https://github.com/pivotal-cf/cred-alert/releases/download/${CREDALERT_VERSION}/cred-alert-cli_darwin
mv cred-alert-cli_darwin cred-alert
chmod +x cred-alert
sudo mv cred-alert /usr/local/bin
