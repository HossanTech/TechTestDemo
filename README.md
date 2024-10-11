# App documentation.. 
This is the coding test to demonstrate the showcase about SwiftUI. In this coding , I have used publicy available API (https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people) which contains people data with properties like Name, Email , Last name etc. In this test , I have tried to cover following requirment as it stated into PDF (SOLID principles, Code Architecture, Modular, SwiftUI, Unit tests).

* **Tools:** For this demo , I have used Xcode 16.0 with swift version 6.0. For this example I targeted minimum deployemnt veriosn 16.0.

* **Architecture:** For this example, I have followed the MVVM (View - Model - ViewModel + Clean). The view contains only code which is related to view. The model contains code only for json code/decodable objects. The viewModel constains only code for which is related to business logic. The seperation of the code and logic  help to write require unit test / UI test case. The MVVM is the most recommend architecture design compare to tradition architecture design pattern. The MVVM architectural design pattern also help to write the clean code, which increase the simplicity, readability, testability of the code.  

* **SOLID principles:** I have followed the SOLID principles . I have given single responsibility of the each class and separate the interface and protocol of the each class to mkae sure the code is not tightly coupled. In addition , I have given seperate layer for handling json parsing (Repository layer).

* **Presentation Layer:** To design presentation layer, I have used the SwiftUI with Combine approach. The SwiftUI and combine is the most recommended way to desin the code and render the views. In UIkit , we have to depend on protocol delegate and class. Because of the inheritance , there were lots of unnecessarily code is added behind the scenes , which impact the performances of the app. We also needs to take care the memory leaks and write the constrains for views properties as well. But SwiftUI depeneds on values types (struct), for that reason there is no memory leaks , not needs to give the constrains for the view instead use modifiers and combine works on publisher and subscriber principal. This ensure the latest update of the view but it was not possible UIkit.

* **Concurrency and Performance:** In this coding test, I have used the async and await to handle te concurrency. The async and await is also known as structured concurrency. It is the most recommend way to hande the concurrency rather then using closure with completion block. The SwiftUI works on properties wrapper like @State, @Observed, @ObserbaleObjest which and combine which help to achieve the highest performance of the App.

* **Simplicity and Readability:** Because of the async and await and the Soild principles  the code is very easy to understand. The async and await is help to write the less code which increase the readability of the code. Also help us to write batter unit test.

 * **Unit testing , Snapshot Testing and  UITesting:** Each of the business logic has been testing by using XCTTesting frmaework with Test Driven Development approch. The shapshot teting is done by using snapshot testing packge by using SPM and result was recorded into directory. The UI testing especially the app title ony recorded. 

**Here is the screenshot when the app is lunched**
![Simulator Screenshot - iPhone 16 Pro - 2024-10-11 at 13 35 21](https://github.com/user-attachments/assets/f260c6e7-9c64-4bdc-85fd-e46316a47012)

Here is the details view when the list cell is selected.

![Simulator Screenshot - iPhone 16 Pro - 2024-10-11 at 13 35 34](https://github.com/user-attachments/assets/96ba4d0e-cc6a-48e2-82b3-09881a87a7c5)

Here is the seach functionality screen.

![Simulator Screenshot - iPhone 16 Pro - 2024-10-11 at 13 35 51](https://github.com/user-attachments/assets/145f03b6-a6db-47f7-ab2b-37f13501f249)

Here is the screenshot for different mode ..

![Simulator Screenshot - iPhone 16 Pro - 2024-10-11 at 13 36 15](https://github.com/user-attachments/assets/33087dc6-e762-4666-a669-c1ab7765c9bc)


