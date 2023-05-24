# workout_app

## Dev requirement

* touch `.env` file in root of the project
* Install flutter
* Install android studio & related SDK
* Install firebase CLI
  * Windows: `npm install -g firebase-tools`
  * Linux: `curl -sL https://firebase.tools | bash`
* `firebase login`
* flutterfire cli
  * `dart pub global activate flutterfire_cli`
  * Linux: `export PATH="$PATH":"$HOME/.pub-cache/bin"`
  * Windows: Add bin er to environment variable, path is hint in the output of the previous command
* in root the project: `flutterfire configure --project=jd-workout`

I put the sensitive file in `.gitignore` already, so you don't need to worry about it, 

but there's on file `lib/firebase/firebase_config.dart`,

i move the folder to another folder,

so you have to remove it 

before you set up relate firebase config into `.env`.

Finally, you should be able to open google OAuth in login page.

## Dev option
* `flutter run`
  * can't hot reload
* compile from android studio / IntelliJ IDEA Ultimate
  * can hot reload
* add `--no-sound-null-safety` option
  * for IntelliJ IDEA Ultimate, click `three-dot-icon` beside `run` button,
    then click `Edit`, then add `--no-sound-null-safety` in `Additional run args` field

### Flutter install package

`flutter pub get`

## Build

` flutter build apk --release`