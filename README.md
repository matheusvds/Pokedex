[![Build Status](https://app.bitrise.io/app/3f3509de68c03e35/status.svg?token=gF8edjub3W-8YAowEMWMQA)](https://app.bitrise.io/app/3f3509de68c03e35)

# Pokedex
An iOS application written in Swift using the Clean Architecture design. Built with Xcode 11.7, Swift 5 and for iOS 9.3+.

## Dependencies
- SnapKit 4.0.1
- SDWebImage 5.9.1
- SPM

## Project Structure

- **Pokedex** (app target)
- **Application**: application layer target implemented with the Clean Swift pattern.
- **UI**: contains the whole UI abstractions and implementations used by the application. It's implemented with SnapKit.
- **Domain**: contains the application's use cases abstractions and the core entities.
- **Data**: contains the use cases implementations and external interfaces abstractions.
- **Infra**: contains the implementation of the external interfaces abstractions like an http client.

## Instructions

Make sure you have a Xcode version compatible with Swift 5. Open the *.xcodeproj* file and **wait for SPM to download dependencies**. 
Once that is done, you are free to run the app!
