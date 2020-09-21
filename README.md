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
Once that is done, you are free to run the app.

Choose between the following schemes:
- **Pokedex_Matheus**: Run this scheme to run the app.
- **Application**: Build this scheme to create the application layer framework (or **Cmd + U** to run its unit tests).
- **UI**: Build this scheme to create the UI layer framework (or **Cmd + U** to run its unit tests).
- **Domain**: Build this scheme to create the Domain layer framework.
- **Data**: Build this scheme to create the Data layer framework (or **Cmd + U** to run its unit tests).
- **Infra**: Build this scheme to create the Infra layer framework (or **Cmd + U** to run its unit tests).
- **UseCaseIntegrationTests**: **Cmd + U** to run the integration tests for several use cases.


## Aditional Information

When favoriting a pokemon, a POST request is sent to this WebHook URL: https://webhook.site/#!/3209dcca-c16d-4d48-8854-77bae12a48b2/09a2269c-8e02-4e62-970b-d0312dd2b6e7/1
