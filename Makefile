icons:
	flutter pub run flutter_launcher_icons:main

update:
	flutter pub outdated --mode=null-safety
	flutter pub upgrade

prepare:
	flutter config --no-analytics
	dart --disable-analytics
	flutter --version
	flutter doctor -v
	flutter pub get

check:
	dart analyze .
	dart format --set-exit-if-changed .

prepare-check: prepare check

build-android:
	flutter build apk --split-per-abi

build-android-release:
	flutter build appbundle --release

build-apk-release:
	flutter build apk --release --split-per-abi

build-ios:
	flutter build ipa

run-macos:
	flutter run -d macos --hot

run-iphone:
	flutter run -d iPhone

upgrade-build:
	./version.sh build

commit-upgrade:
	git add pubspec.yaml CHANGELOG.md
	git status
	git commit -m "$(shell ./version.sh commit)"

upgrade-and-build: upgrade-build build-ios

push:
	git push origin HEAD

tag:
	git tag -a v$(shell ./version.sh version) -m "v$(shell ./version.sh version)"
	git push origin v$(shell ./version.sh version)

open-build-ipa:
	open build/ios/ipa

changelog:
	./version.sh changelog --name="v$(shell ./version.sh version)" --to=HEAD --force

commit-changelog:
	git add CHANGELOG.md
	git status
	git commit -m "Change: update changelog"

bump: upgrade-and-build changelog commit-upgrade tag push open-build-ipa

pod-update-ios:
	cd ios && pod update && cd ..

pod-update-macos:
	cd macos && pod update && cd ..

pod-update: pod-update-ios pod-update-macos

outdated:
	flutter pub outdated

pub-upgrade:
	flutter pub upgrade

upgrade: pub-upgrade pod-update
	