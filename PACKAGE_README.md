# Sample README for packages

<!---
Adding the atPlatform logos gives a nice look for your readme
-->
<img width=250px src="https://atsign.dev/assets/img/atPlatform_logo_gray.svg?sanitize=true">

<!---
Add a badge bar for your package by replacing at_client_mobile below with
your package name below and at_client_sdk with the name of the repo
-->
[![pub package](https://img.shields.io/pub/v/at_client_mobile)](https://pub.dev/packages/at_client_mobile) [![pub points](https://badges.bar/at_client_mobile/pub%20points)](https://pub.dev/packages/at_client_mobile/score) [![build status](https://github.com/atsign-foundation/at_client_sdk/actions/workflows/at_client_sdk.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_client_sdk/actions/workflows/at_client_sdk.yaml) [![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)

<!--- this is a table version
| [![pub package](https://img.shields.io/pub/v/at_client_mobile)](https://pub.dev/packages/at_client_mobile) | [![pub points](https://badges.bar/at_client_mobile/pub%20points)](https://pub.dev/packages/at_client_mobile/score) | [![build status](https://github.com/atsign-foundation/at_client_sdk/actions/workflows/at_client_sdk.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_client_sdk/actions/workflows/at_client_sdk.yaml) | [![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)
|------|------|------|------|------| 
-->
## Overview
<!---
## Who is this for?
The README should be addressed to somebody who's never seen this before.
But also don't assume that they're a novice.
-->
The [package-name] package is for Flutter developers who...

<!---
Give some context and state the intent - we welcome contributions - we want
pull requests and to hear about issues. Include the boilerplate language
below to add some context to @‎platform packages 
-->
This open source package is written in Dart, supports Flutter and follows the
@‎platform's decentralized, edge computing model with the following features: 
- Cryptographic control of data access through personal data stores
- No application backend needed
- End to end encryption where only the data owner has the keys
- Private and surveillance free connectivity
- ... <!--- add package features here -->

We call giving people control of access to their data “flipping the internet”
and you can learn more about how it works by reading this
[overview](https://atsign.dev/docs/overview/).

<!---
Does this package publish to pub.dev or similar? This README will be the
first thing that developers see there and should be written such that it
lets them quickly assess if it fits their need.
-->
## Get started
There are three options to get started using this package.

<!---
If the package has a template that at_app uses to generate a skeleton app,
that is the quickest way for a developer to assess it and get going with
their app.
-->
### 1. Quick start - generate a skeleton app with at_app
This package includes a working sample application in the
[Example](./example) directory that you can use to create a personalized
copy using ```at_app create``` in four commands.

```sh
$ flutter pub global activate at_app 
$ at_app create --sample=<package ID> <app name> 
$ cd <app name>
$ flutter run
```
Notes: 
1. You only need to run ```flutter pub global activate``` once
2. Use ```at_app.bat``` for Windows


<!---
Cloning the repo and example app from GitHub is the next option for a
developer to get started.
-->
### 2. Clone it from GitHub
<!---
Make sure to edit the link below to refer to your package repo.
-->
Feel free to fork a copy of the source from the [GitHub repo](https://github.com/atsign-foundation/at_client_sdk). The example code contained there is the same as the template that is used by at_app above.

```sh
$ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```

<!---
The last option is to use the traditionaL instructions for adding the package to a project which can be found on pub.dev. 
Please be sure to replace the package name in the url below the right one for this package.
-->
### 3. Manually add the package to a project

Instructions on how to manually add this package to you project can be found on pub.dev [here](https://pub.dev/packages/at_client/install).

<!---
Include an explanation on how to setup and use the package
-->
## How it works

<!---
Add details on how to setup the package
-->
### Setup

<!---
Add details on how to use the package in an application
-->
### Usage

<!---
Make sure your source code annotations are clear and comprehensive.
-->
For more information, please see the API documentation listed on pub.dev.

<!---
If we have any pages for these docs on atsign.dev site, it would be 
good to add links.(optional)
-->

<!---
You should include language like below if you would like others to contribute
to your package.
-->
## Open source usage and contributions
This is  open source code, so feel free to use it as is, suggest changes or 
enhancements or create your own version. See [CONTRIBUTING.md](CONTRIBUTING.md) 
for detailed guidance on how to setup tools, tests and make a pull request.

<!---
Have we correctly acknowledged the work of others (and their Trademarks etc.)
where appropriate (per the conditions of their LICENSE?
-->
## Acknowledgement/attribution

<!---
Who created this?  
Do they have complete GitHub profiles?  
How can they be contacted?  
Who is going to respond to pull requests?  
-->
## Maintainers

<!---
## Checklist

- [ ] Writing and style
Does the writing flow, with proper grammar and correct spelling?

- [ ] SEO
Always keep in mind that developers will often use search to find solutions
to their needs. Make sure and add in terms that will help get this package to
the top of the search results for google, pub.dev and medium.com as a minimum.

- [ ] Links
Are the links to external resources correct?
Are the links to other parts of the project correct
(beware stuff carried over from previous repos where the
project might have lived during earlier development)?

- [ ] LICENSE
Which LICENSE are we using?  
Is the LICENSE(.md) file present?  
Does it have the correct dates, legal entities etc.?
-->








