fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios watch
```
fastlane ios watch
```

### ios init_apns_stag_dev
```
fastlane ios init_apns_stag_dev
```
Init APNs for Staging server with Development mode

=> fastlane init_apns_stag_dev --env dev
### ios init_apns_stag_release
```
fastlane ios init_apns_stag_release
```
Init APNs for Staging server with Release mode

=> fastlane init_apns_stag_release --env prod ]
### ios init_apns_prod_dev
```
fastlane ios init_apns_prod_dev
```
Init APNs for Production server with Development mode

=> fastlane init_apns_prod_dev --env dev
### ios init_apns_pro_release
```
fastlane ios init_apns_pro_release
```
Init APNs for Production server with Release mode

=> fastlane init_apns_pro_release --env prod
### ios sync_cert_dev
```
fastlane ios sync_cert_dev
```
Sync certificates for Development

=> fastlane sync_cert_dev --env dev
### ios sync_cert_prod
```
fastlane ios sync_cert_prod
```
Sync certificates for Production

=> fastlane sync_cert_prod --env prod
### ios beta
```
fastlane ios beta
```
Build & deploy BETA

=> fastlane beta --env dev
### ios release
```
fastlane ios release
```
Build & deploy RELEASE

=> fastlane beta --env prod
### ios build
```
fastlane ios build
```
Build job

=> fastlane build --env [dev | prod]
### ios deploy
```
fastlane ios deploy
```
Deploy job

=> fastlane deploy provider:[Diawi | Fabric | TestFlight]
### ios deploy_diawi
```
fastlane ios deploy_diawi
```
Deploy to Diawi

=> fastlane deploy_diawi --env [dev | prod]
### ios deploy_fabric
```
fastlane ios deploy_fabric
```
Deploy to Fabric

=> fastlane deploy_fabric --env [dev | prod]
### ios deploy_appstore
```
fastlane ios deploy_appstore
```
Deploy to TestFlight

=> fastlane deploy_appstore --env prod

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
