# FactoryBird

FactoryBird is an objective-c library to easily create a set of fake models fixture for unit testing. It allows to easily configure and create objects with fake data that you can use in your tests to have an isolated know state.    


Sounds like FactoryGirl
---------

That's because objective-c's FactoryBird is built with ruby's [factory_girl](https://github.com/thoughtbot/factory_girl) capabilities in mind. 

It is mostly inspired by [Foundry](https://github.com/smyrgl/Foundry) but it has some additional __flexibility__: 

*    You can call `build` to build a default test object or call `buildUsing:` passing a dictionary with some properties that will override the default ones. 
*    You can build an _array_ of objects and also override some properties for all objects or just for some, all in one single method. 
*    It is decoupled from the faker library/logic. You can use whatever faker pod you like when implementing `FactoryBirdObject` protocol. I'm using [Gizou](https://github.com/smyrgl/Gizou). 
*    Works with subclasses' inherited properties; ie. for a given object, you can set a property of any of it's superclasses.
*    Allows subclassing both NSObject and NSManagedObject factories to have several handy configurations for the same object. No matter that the entity is not in the xcdatamodel when using Core Data :tada:.  
<br/>
 

Installation
---------

♥ [CocoaPods](http://cocoapods.org/).

``` pod 'FactoryBird', '~> 0.0.1' ```
<br/><br/>

Setting up your testing environment
---------
1. Add FactoryBird to your tests targets, all of them where you want to use it. For eg. __Unit and Snapshot tests__.

2. CLEAN TIP: create a separate `Factories/` folder at the same level of your tests' targets folders that will hold objects' factories:

```
	Tests/
		Factories/
		UnitTests/
		SnapshotTests/
```
If using Core Data, it's nice to have NSManagedObjects separated from regular NSObjects: 

```
	Tests/
		Factories/
			CoreData/
			Ponsos/
		UnitTests/
		SnapshotTests/
```
<br/>

Defining factories
---------
Defining a factory for an object is just making its class conform to the `<FactoryBirdObject>` protocol. 

```objective-c
#import "FactoryBird.h"

@interface Task <FactoryBirdObject>
```

There is only one method to implement:

```objective-c
+ (NSDictionary *)factoryAttributes
```
Here you create the dictionary with the key-value pairs of attributes you want for the fake object.

```objective-c
+ (NSDictionary *)factoryAttributes
{
	return @{ @"title" 	     : @"Title for testing",
		      @"dueOn"     	 : [NSDate dateWithTimeIntervalSince1970:1425314661],
              @"resolved"	 : @NO,
              @"taskID"     : @1,
              @"description": @"Lorem ipsum dolor est"
              };
}
```
Keys can be any `property` of the class or any of its superclasses. In the case of NSManagedObjects, both `attributes` and `relationships`(since they are `properties`). 

#### Creating separate categories in the Tests targets

When you need a factory for a model, you can make the model class conform to the `<FactoryBirdObject>` protocol directly. 

However, you can also leave the class unchanged and add a new category to the tests target/s, inside the `Factories/` folder. This way, you keep your model code clean and the factory methods will only be available inside the tests' target where they really belong :wink:.  

```
	Tests/
		Factories/
			Task+FactoryBird.h
			Task+FactoryBird.m
		UnitTests/
		SnapshotTests/
```

`Task+FactoryBird.h` header file:

```objective-c
#import "FactoryBird.h"

@interface Task (FactoryBird) <FactoryBirdObject>

@end
```

Using factories
---------
Once you've defined the factory, creating fresh fixtures in your tests is very simple. 

##### Build an object:

``` objective-c
Task *task = [Task build];
```

##### Build an object overriding or adding some property:
```objective-c
Task *resolvedTask = [Task buildUsing:@{@"resolved":@YES}];
```
The dictionary you pass in will add the properties to the `Task` object if the factory doesn't define them or override them if it does. 
	
##### Build bunch of objects in a row

```objective-c
NSArray *tasks = [Task buildTimes:20];
```

##### Build bunch of objects passing specific properties

```objective-c
NSArray *tasksWithProjects = [Task buildTimes:20 using:^NSDictionary *(NSUInteger idx) {
        return @{@"project": [Project build]};
    }];
```

#### Same for managed objects, just pass a valid context

```objective-c
User *user = [User buildWithContext:context];
User *maria = [User buildWithContext:context using:@{@"name":@"Maria"}];
```
