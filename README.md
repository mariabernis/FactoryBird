# FactoryBird

Installation
---------

###CocoaPods

♥ [CocoaPods](http://cocoapods.org/).

``` pod 'FactoryBird', '~> 0.0.1' ```

<br/>



Sounds like FactoryGirl
---------

That's because FactoryBird is built with ruby's [factory_girl](https://github.com/thoughtbot/factory_girl) capabilities in mind. 

It is mostly inspired by [Foundry](https://github.com/smyrgl/Foundry) but it has some additional __flexibility__: 

*    Can build a default test object or pass a dictionary with some properties that will override the default ones. 
*    Can also build array of factory objects and override some properties for all objects or just for some, all in one single method. 
*    It is decoupled from the faker library, so you can use whatever faker pod you like when implementing FactoryBirdObject protocol in your model classes. I'm using [Gizou](https://github.com/smyrgl/Gizou). 
*    Works with subclasses of NSObjects (ie. for a given object, you can set a property of any of it's superclasses in the factory).
*    Can subclass both NSObject and NSManagedObject factories to have several handy configurations for the same object (no matter that the entity is not in the xcdatamodel when using Core Data).    

## Wat?
FactoryBird is a fixture for creating fake test objects in objective-c. It allows to easily configure and create objects with fake data for testing purposes.    
<br/>


Using factories
---------

#### Build an object:

``` objective-c
Task *task = [Task build];
```

#### Build an object overriding or adding some property:

``` objective-c
Task *resolvedTask = [Task buildUsing:@{@"resolved":@YES}];
```
	
#### Build bunch of objects in a row

``` objective-c
NSArray *tasks = [Task buildTimes:@20];
```

#### Same for managed objects, just pass a valid context

``` objective-c
User *user = [User buildWithContext:context];
User *maria = [User buildWithContext:context using:@{@"name":@"Maria"}];
```

Setup and creating factories
---------
Coming soon... 
