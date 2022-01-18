# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
 - first version to build arch arm64

## [v0.0.2] - 2021-05-11
### Added
 - simple docker-compose example
### Changed
- reenabled chown -R "$USER:$USER" "$HOME" in 01-init
- modified readme added links to dockerhub

## [v0.0.1] - 2021-05-09
### Added
- explanation on how this image works in README.md

### Changed
- changed base image from kali-desktop to kali-base
- restructured Dockerfile
- Update S6 Overlay to Version from 1.21.4.0 to 2.2.0.3
- disabled chown -R "$USER:$USER" "$HOME" in 01-init
- changed default vnc resolution from 1280x600x24 to 1280x1024x24

### Removed
- removed all desktop environments except XFCE
