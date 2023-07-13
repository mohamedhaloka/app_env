![](https://www7.0zz0.com/2023/07/13/22/729644482.jpg)
# App Env
With App env you can now easily share global variables between Flutter and mobile operating systems Android and iOS.

![](https://s11.gifyu.com/images/SWuTu.gif)
## _Supported platforms_
- Android
- iOS
## _About_
Before the package appears, when you want to use the environment, you write all the variables in the `.env` file, and then write them again for both systems, either in strings.xml for the Android system, or in the xcconfig file to use xCode and for the iOS system.

This matter costs you a lot of time, but also you repeat more and more data, and therefore the error rate increases.

But rest assured that App env came to solve this problem with ease .. All you have to do is only 4 steps ..
- Add the package in your project.
- Run the package.
- Add your variables in the `.env` file.
- Rerun the package again.

And Boooom, now you will notice that the package has done everything, and you can share all the variables now without worrying about forgetting anything.
## _Usage_
As we mentioned previously, there are four simple steps that will enable you to share your variables with ease. We will explain them in detail below.

1- You have added the package to your project
< Package add code >
```yml
    app_env: current_version
```

2- You can run the package using the following command
```yml
    dart run app_env
```
3- You will notice that the package has added an `.env` file in the project at the same level as the lib folder.
![](https://www8.0zz0.com/2023/07/13/22/749140116.png)

And when you open the file, you will find a group of variables present as an illustration. You can delete them and add your own variables :D
![](https://www8.0zz0.com/2023/07/13/22/327861201.png)

4- Use the above command to run the package again.

It's over.. that's it.
### _Flutter Usage_
At the present time, the package does not provide the ability to read the `.env` file, but there are many ways to read the file, either through

- Use the Regex and write your own code to extract the key and the value.
- Or, you can easily use another package that reads the `.env` file, such as flutter_dotenv.
### _Android Usage_
After executing the previous steps, go to the following path `android/app/src/main/res/values/` You will notice that there is a strings.xml file.

When you open the file, you will find all the variables that you defined in the `.env` file, and the package added them automatically.

And every time you add a new variable or modify an existing file and run the package, it will automatically modify the strings.xml file.

![](https://www8.0zz0.com/2023/07/13/22/115791653.png)

Thus, you can use the variables in the strings.xml file in everything related to Android, whether it is an xml file, as well as java or Kotlin files.
### _iOS Usage_
After executing the previous steps, go to the following path `ios/Flutter/` You will notice that there is a AppEnvConfig.xcconfig file.

When you open the file, you will find all the variables that you defined in the `.env` file, and the package added them automatically.

All we have to do is create the AppEnvConfig.xcconfig file in the following path as shown in the image below.

To create the file, we must open the Xcode, add a new file, and as show in the photo below.
![](https://www8.0zz0.com/2023/07/13/22/732702959.png)
**You must follow two steps**
- the name of file must be AppEnvConfig.xcconfig
- the path of file must be ios/Flutter/AppEnvConfig.xcconfig

There remains a very simple matter for us so that you can use these variables with ease in iOS .. All you have to do is open Runner as shown in the picture ..

![](https://www8.0zz0.com/2023/07/13/22/701990839.png)
**The configuration file must be changed from here to the file that we created now**

Through Configurations, you will choose the AppEnvConfig.xcconfig file, and then you can now easily go to the Build Settings tab located in the Targets as shown in the picture.

![](https://www8.0zz0.com/2023/07/13/22/388312176.png)

And then search for User to access User-Defiend to find that all the variables that we added in the `.env` file are present and available now through xCode, and you can deal with them easily in iOS now.

## _Use Cases_
Here we will perform some experiments to answer some of the questions in your mind.

![](https://s12.gifyu.com/images/SWu3u.gif)
- What happens if I add a variable in the strings.xml file or in the AppEnvConfig.xcconfig file that is not in the .env file and run the package?

-- strings .xml: Nothing will happen, everything will be fine.. The package does not rewrite the file from the beginning, but only modifies it, and therefore it will modify the file and all your other variables will be fine.

-- AppEnvConfig.xcconfig: As for here, the package does not modify the file, but overrides it every time with all the data in the .env file only, and therefore any variables that are not in the `.env` file will be deleted.


![](https://s11.gifyu.com/images/SWu3Q.gif)
- What will happen if I change the value of a variable in strings.xml only without changing it in the `.env` file?

The package will write the value in .env and will not care about the value you wrote. :D

This section will be updated as more cases become available.
## _Discussion_
Use the [issue tracker](https://github.com/mohamedhaloka/app_env/issues) for bug reports and feature requests.
Pull requests are welcome.