fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

## Choose your installation method:

| Method                     | OS support                              | Description                                                                                                                           |
|----------------------------|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| [Homebrew](http://brew.sh) | macOS                                   | `brew cask install fastlane`                                                                                                          |
| Installer Script           | macOS                                   | [Download the zip file](https://download.fastlane.tools). Then double click on the `install` script (or run it in a terminal window). |
| RubyGems                   | macOS or Linux with Ruby 2.0.0 or above | `sudo gem install fastlane -NV`                                                                                                       |

# Available Actions
## iOS
### ios watch
```
fastlane ios watch
```
Send a notification when a build is done processing in iTunes Connect
### ios init_apns_stag_dev
```
fastlane ios init_apns_stag_dev
```
Init APNs for Staging server with Development mode. [.env.dev]
### ios init_apns_stag_release
```
fastlane ios init_apns_stag_release
```
Init APNs for Staging server with Release mode. [.env.prod , .env.prod-release]
### ios init_apns_prod_dev
```
fastlane ios init_apns_prod_dev
```
Init APNs for Production server with Dev mode. [.env.dev]
### ios init_apns_pro_release
```
fastlane ios init_apns_pro_release
```
Init APNs for Production server with Release mode. [.env.prod , .env.prod-release]
### ios sync_cert_dev
```
fastlane ios sync_cert_dev
```
Sync certificates for Development
### ios sync_cert_prod
```
fastlane ios sync_cert_prod
```
Sync certificates for Production
### ios beta
```
fastlane ios beta
```
Build & deploy BETA
### ios release
```
fastlane ios release
```
Build & deploy RELEASE
### ios build
```
fastlane ios build
```
Build job
### ios deploy
```
fastlane ios deploy
```
Deploy job
### ios deploy_diawi
```
fastlane ios deploy_diawi
```
Deploy to Diawi
### ios deploy_fabric
```
fastlane ios deploy_fabric
```
Deploy to Fabric
### ios deploy_appstore
```
fastlane ios deploy_appstore
```
Deploy to TestFlight

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
