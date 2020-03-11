# ITWORX Education

![]() <br />
<br />
This demo for iOS developer vacancy in ITWORX Education.

### Used Architecture and patterns

- N-Tier Architecture <br/>
- MVVM + XCoordinator <br/>
- Coordinator <br/>
- Repository <br/>
- Factory

### Dependency Graph

The App originally consists of 3 tiers: <br />

**Presentation -** Responsible for representing data on screen and handle presentation logic, MVVM design pattern used in this layer. <br />
**Persistent -** Responsible for data saving and retrieving from/to data stores,and this is where repository pattern used wich contain both local and remote data sources. <br />
**Coordinator -** Its responsibility is to build modules with it's dependancies, and handl routing and navigation beween screens. <br/>

Every inner layer doesn't know anything about the outer layer. <br />

**(Protocols)** used everywhere to establish a pipeline from inner layers to outer layers, used for encapsulation and increse substitutability and this where protocol orientd comes in.


### Pods

RxSwift <br />
RxCocoa  <br />
Alamofire  <br />
Kingfisher  <br />
XCoordinator  <br />
SwiftMessages  <br />
RxCoreData  <br />
