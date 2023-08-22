import 'package:flutter/material.dart';
import 'api/handler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

// locals
import 'pdf_page.dart';
import 'caching.dart';

void main() {
  runApp(const MyApp());
}

// Store data in list on first call
List<dynamic> allModules = [];
List<dynamic> allSubModules = [];
List<dynamic> allNotes = [];
final apiService = ApiService('https://ea13-41-90-65-106.ngrok-free.app');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 26, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title: ' 👩🏿‍⚕️ Nursing Notes-KRCHN 👨🏿‍⚕️'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // instatiate API class

  Future<List<dynamic>> fetchData(String title) async {
    // try fetch data from cache first
    // ignore: non_constant_identifier_names
    try {
      String CourseModules = "Modules-$title";
      final cachedData = await getCachedData(CourseModules);
      // check if cache is not empty and return that
      if (cachedData.isNotEmpty) {
        //print("-----------------Returned from cached data--------------------");
        return cachedData;
      } else {
        // call API > CACHE DATA
        final List<dynamic> responseData =
            await apiService.getLessons('api/college_app/v1/all_modules/32');
        await cacheData(CourseModules, responseData);
        final cachedNewData = await getCachedData(CourseModules);
        //print("-----------------Cached data and returned from api--------------------");
        return cachedNewData;
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            // Image set to background of the body
            image: DecorationImage(image: ExactAssetImage("assets/background.png",scale: 1.5), fit: BoxFit.cover),
          ),
          child: FutureBuilder(
            future: fetchData(widget.title), //get data from out API
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // if we are still waiting for data show loading bat
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      "No data available internet 🌩️ or try loading again! else email munyalamea@gmail.com"),
                );
              } else {
                // data has been fetched successfully
                allModules = snapshot.data;
                if (allModules.isEmpty) {
                  return const Center(
                    child: Text(
                        "🥵 Seems there's No data available. We are working to update more data."),
                  );
                }
                // else build up our list view
                return ListView.builder(
                  itemCount: allModules.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allModules[index]["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              // Text(data[index]["title"]),// ~here add description
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    String courseTitle =
                                        allModules[index]["title"];
                                    // Call your API with the courseTitle and fetch appropriate data
                                    // You can use this courseTitle to make the API request
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CourseDetailsPage(
                                                  title: courseTitle,
                                                  dip_id: allModules[index]
                                                          ["diploma_id"]
                                                      .toString(),
                                                  mod_id: allModules[index]
                                                          ["id"]
                                                      .toString()),
                                        ));
                                  },
                                  child: const Text("View Modules🤔"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}

class CourseDetailsPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const CourseDetailsPage(
      {super.key,
      required this.title,
      required this.dip_id,
      required this.mod_id});

  final String title;
  // ignore: non_constant_identifier_names
  final String dip_id;
  // ignore: non_constant_identifier_names
  final String mod_id;

  @override
  State<CourseDetailsPage> createState() =>
      // ignore: no_logic_in_create_state
      _CourseDetailsPage();
  // _CourseDetailsPage(courseTitle: title, dip_id: dip_id, mod_id: mod_id);
}

class _CourseDetailsPage extends State<CourseDetailsPage> {
  // make an api call
  // final apiService = ApiService('https://df34-41-90-66-51.ngrok-free.app');

  Future<List<dynamic>> fetchData(String title) async {
    // try fetch data from cache first
    // ignore: non_constant_identifier_names
    String CourseDetails = "CourseDetails-$title";
    final cachedData = await getCachedData(CourseDetails);
    //print("----------- awaited cached data ${cachedData} ---------------------");
    // check if cache is not empty and return that
    if (cachedData.isNotEmpty) {
      //print("-----------------Returned from cached data--------------------");
      return cachedData;
    } else {
      // call API > CACHE DATA
      final List<dynamic> responseData = await apiService.getLessons(
        "api/college_app/v1/sub_modules/with_module/${widget.dip_id}/${widget.mod_id}");
      await cacheData(CourseDetails, responseData);
      final cachedNewData = await getCachedData(CourseDetails);
      //print("-----------------Cached data and returned from api--------------------");
      return cachedNewData;
    }
  }

  _CourseDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchData(widget.title), // Your async function to fetch data
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading data"), // Display an error message
            );
          } else {
            // Data has been fetched successfully
            allSubModules = snapshot.data;

            if (allSubModules.isEmpty) {
              return const Center(
                child: Center(
                  child: Text(
                      "No data available. We are working to update more data."),
                ),
              );
            }
            return Center(
                child: ListView.builder(
              itemCount: allSubModules.length,
              itemBuilder: (BuildContext context, int index) {
                // Your existing list item code
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allSubModules[index]["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        // Text(data[index]["title"]),// ~here add description
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              //print(allSubModules);
                              String subModuletitle =
                                  allSubModules[index]["title"];
                              String subModuleDipID =
                                  allSubModules[index]["diploma_id"].toString();
                              String subModuleModID =
                                  allSubModules[index]["module_id"].toString();
                              String subModuleSubModID =
                                  allSubModules[index]["id"].toString();
                              // You can use this courseTitle to make the API request
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseNotesPage(
                                        title: subModuletitle,
                                        dip_id: subModuleDipID,
                                        mod_id: subModuleModID,
                                        sub_mod_id: subModuleSubModID),
                                  ));
                            },
                            child: const Text("View-Notes📝"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
          }
        },
      ),
    );
  }
}

class CourseNotesPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const CourseNotesPage(
      {super.key,
      required this.title,
      required this.dip_id,
      required this.mod_id,
      required this.sub_mod_id});

  final String title;
  // ignore: non_constant_identifier_names
  final String dip_id;
  // ignore: non_constant_identifier_names
  final String mod_id;
  // ignore: non_constant_identifier_names
  final String sub_mod_id;

  @override
  State<CourseNotesPage> createState() =>
      // ignore: no_logic_in_create_state
      _CourseNotesPage();
}

class _CourseNotesPage extends State<CourseNotesPage> {
  Future<List<dynamic>> fetchData(String title) async {
    // try fetch data from cache first
    // ignore: non_constant_identifier_names
    String CourseNotes = "CourseNotes-$title";
    final cachedData = await getCachedData(CourseNotes);
    //print("----------- awaited cached data ${cachedData} ---------------------");
    // check if cache is not empty and return that
    if (cachedData.isNotEmpty) {
      //print("-----------------Returned from cached data--------------------");
      return cachedData;
    } else {
      // call API > CACHE DATA
      final List<dynamic> responseData = await apiService.getLessons(
          "api/college_app/v1/sub_modules/notes/${widget.dip_id}/${widget.mod_id}/${widget.sub_mod_id}");
      await cacheData(CourseNotes, responseData);
      final cachedNewData = await getCachedData(CourseNotes);
      //print( "-----------------Cached data and returned from api--------------------");
      return cachedNewData;
    }
  }

  _CourseNotesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchData(widget.title),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading data"), // Display an error message
            );
          } else {
            // Data has been fetched successfully
            allNotes = snapshot.data;

            if (allNotes.isEmpty) {
              return const Center(
                child: Center(
                  child: Text(
                      "No data available. We are working to update more data."),
                ),
              );
            }

            // Build the main component
            return Center(
              child: ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (BuildContext context, index) {
                  // Your existing list item code
                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allNotes[index]["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              // Text(data[index]["title"]),// ~here add description
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // take data~ path and name
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfViewerPage(
                                                      filePath: allNotes[index]
                                                          ["notes_pdf"],
                                                      fileName: allNotes[index]
                                                          ["title"])));
                                    },
                                    child: const Text("Read📖"),
                                  )),
                            ],
                          )));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
