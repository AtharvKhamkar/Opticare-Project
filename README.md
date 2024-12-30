# vizzhy

# PROD/Stage Config

flutter run --flavor prod -t lib/main_prod.dart
flutter build apk --flavor prod -t lib/main_prod.dart

# DEV Config

flutter run --flavor dev -t lib/main_dev.dart
flutter build apk --flavor dev -t lib/main_dev.dart

# configure firebase according to Flavors

flutterfire configure --project=vizzhystag-9bdb0 --out=lib/firebase_options_stag.dart --ios-bundle-id=com.vizzhy.multiomics --android-app-id=com.vizzhy.multiomics
