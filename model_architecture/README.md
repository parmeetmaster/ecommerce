# Model Architcture Flutter Developers

**Api Folder** : In Api folder we store Api Classes as per Screen and each class contains Future Methods that are not executed.Its executed in providers classes.

**Components**: Components is contains widgets that will use in multiple screens.

**Models**: Models contains different models related to project to store data and transfer data between classes.

**Providers**: Provider are act like controller every opertion like validation calling api from Api classes using utlities etc.Moreover every variable is declared and assign and release value from providers only. Providers are only responsible for Screen rebuild.Main objective is to avoid setState calling.

**Screens**: Screens are contains UI for different screens and components related to  that screen only.

**Utils**: Utils contains common classes and funcitonalities are that used in every single app.


