## Architecture

The architecture chosen for the app is the __MVVM architecture.__ This architecture facilitates the __separation of view and business logic,__ allowing us to __test the core functionalities easily.__ The __ViewModel__ is the main actor of the architecture and it is responsible for __exposing the data objects from the model.__ This ViewModel handles most of the view's display logic. The view can "access" this display logic by __a binding mechanism.__ In this case we used __RxSwift__ as this binding mechanism.

We separated the core logic of the project into a __separated framework.__ This allows us to test easily the functionalities of the app without making internal things that should be public otherwise.

### Components

We use components from clean architecture that brings us a __better separation of concerns__ and __better testability.__

* #### Assemblies (DI)

Assemblies are responsible for assembling application features, that is, creating object graphs. They are dependency containers. What are the advantages between this dependency container and Swinjec, for example? The differences between this mechanism and Swinject are minimal. The main difference between Swinject and this DI mechanism is that this solution is not thread safety. In addition we have total control of the assemblies, and we don't have dependencies in third-party libraries.
The rule to follow in order to correctly use these assemblies is to __never inject assemblies directly to other objects in the application.__ Objects can't be directly related to assemblies.

In the main app we have an Assembly component, that is responsible for setting up the app window, and instanciate the CoreAssembly object.

Each Scene of the app has its own assembler responsible of creating the scene components.

* #### Navigator

Navigators are responsible for __navigating to a scene.__ They need the providers in order to provide the instances of the scenes. If the providers didn't exist and, considering that we can't inject assemblies directly to the objects of the application, we would be attaching the navigator with the dependencies of the scenes. Keep in mind that the navigator could be used in more than one scene.

* #### ViewModel

The ViewModels are responsible for __exposing the data objects from the model to the view.__ The ViewModels handle most of the view's display logic. The view can "access" this display logic by __a binding mechanism.__
