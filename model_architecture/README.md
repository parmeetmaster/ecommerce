# Model Architcture Flutter Developers

**Api Folder** : In Api folder we store Api Classes as per Screen and each class contains Future Methods that are not executed.Its executed in providers classes.

**Components**: Components is contains widgets that will use in multiple screens.

**Models**: Models contains different models related to project to store data and transfer data between classes.

**Providers**: Provider are act like controller every opertion like validation calling api from Api classes using utlities etc.Moreover every variable is declared and assign and release value from providers only. Providers are only responsible for Screen rebuild.Main objective is to avoid setState calling.

Steps Invovle to register provider:
1) class extends  changeNotifier
2) Add class in Multiprovider at main
3) Add consumer to respective screen with builder.
4) use notify listener on event created in order to rebuild state.

Link to know more ==> https://pub.dev/packages/provider
Best Example to understand DigiDonor
Public Repository to learn ==>https://github.com/rrousselGit/provider

**Screens**: Screens are contains UI for different screens and components related to  that screen only. Remember most important we not calling function.

example: inside button **()Tap: provider.performAction**,

**Utils**: Utils contains common classes and funcitonalities are that used in every single app.like

**Constants Package**: Constants package divided in two terms 
**Languages package** and **constStrings**

###### **Language Package** is used to store const string that used for different langauge switch

###### ConstString package is used to store const for backend purpose like Sharepreferenes need to key to get data.


**languageDeligate**=> Language Deligate is contain global function to **get** and **set** language that reflect whole app language.

**Shareprefrences**=> SharePreferences is used to store permanent data inside app. 
reference :https://pub.dev/packages/shared_preferences

**Globals** => Difference between globals and constants are global contains functional and changeable variables values,Also static variable include that are may need to use different palces 

**Applogger**: Applogger is class is used to show presentable logs during error,
reference :https://pub.dev/packages/logger

