
@echo off
echo Cleaning Flutter project...
flutter clean
echo.
echo Clearing Gradle caches...
cd android
rmdir /s /q .gradle
rmdir /s /q build
cd ..
echo.
echo Clearing Dart and pub caches...
rmdir /s /q .dart_tool
rmdir /s /q build
echo.
echo Getting dependencies...
flutter pub get
echo.
echo Clean complete! Try running your app now.
pause
