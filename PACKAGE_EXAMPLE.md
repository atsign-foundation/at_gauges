<!---
Adding the atPlatform logo gives a nice look for your EXAMPLE.md
-->
<img width=250px src="https://atsign.dev/assets/img/atPlatform_logo_gray.svg?sanitize=true">

<!---
## Who is this for?
The EXAMPLE.md should explain what the package does and how to use it as shown with a working 
application that covers the main features of the package. 
-->
## [package-name] example
The [package-name] package is designed to make it easy to add [primary-function] to a flutter app with the following features:
- Feature 1
- Feature 2

<!---
If the package has a template that at_app uses to generate a skeleton app, that is the quickest
way for a developer to assess it and get going with their app.
Make sure and add in your package ID for the at_app sample.
-->
### Give it a try
This package includes a working sample application in the [example](https://github.com/atsign-foundation/at_client_sdk/tree/trunk/at_client_mobile/example) directory that demonstrates the key features of the package. To create a personalized copy, use ```at_app create``` as shown below or check it out on GitHub.

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
It is important to explain what is happening in the sample application in this document and also 
with good quality annotations in the source code repository.
-->
## How it works

<!---
Most applications will need to incorporate the at_onboarding_flutter widget, so a brief intro
and reference is appropriate.
-->
Like most applications built for the  @‎platform, we start with the [at_onboarding_flutter](https://pub.dev/packages/at_onboarding_flutter) 
widget which handles secure management of secret keys for an atsign as cryptographically secure 
replacement for usernames and passwords.

<!---
The onboarding widget "nextScreen" parameter should be described here and is the first widget 
from your package that get used.
-->
After onboarding, the...

<!---
You should list and explain the UI components that are made available in the package and describe 
how to use them.
-->
The package includes the following UI components...

<!---
Most UI components will offer a degree of customization so you should outline what the available 
options are and how to use them.
-->
You can customize them by...

<!---
If your package creates data or has its own namespace, you should describe that it does here.
-->
The package also manages all the data it needs for you...

<!---
Give some context and state the intent - we welcome contributions - we want
pull requests and to hear about issues. Include the boilerplate language
below to add some context to @‎platform packages 
-->
Like everything else we do, this package and even the sample application are open source software 
which means we love it when you gift us with your feedback, contributions and even any bugs 
that you help us to discover. See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidance on how 
to setup tools, tests and make a pull request.
