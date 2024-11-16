import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const causes = [
    'Animal Rights',
    'Environment',
    // 'Health',
    // 'Education',
    // 'Human Rights',
    // 'Poverty',
    // 'Disaster Relief',
    // 'Community Development',
    // 'Arts & Culture',
    // 'Sports & Recreation',
    // 'Other',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int numOfRows = causes.length;
    double itemHeight = ((MediaQuery.of(context).size.width - 40) / 2) / 3;
    double gridHeight =
        (itemHeight * (numOfRows / 2)) + (5 * ((numOfRows / 2) - 1)) + 20;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF92DA8A), Color(0xEFFFF9ED)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    }),
                actions: [
                  IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context.pop();
                      }),
                ],
              ),
              // Profile Header Section
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.emoji_events_rounded,
                                color: Colors.yellow.shade800,
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF92DA8A),
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 26),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Nobel Tibebe',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xFF92DA8A), width: 1.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.alarm,
                                            color: Color(0xFF92DA8A),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('37'),
                                          Text('Volunteer'),
                                          Text("Hours")
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.local_fire_department,
                                            color: Color(0xFF92DA8A),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text('12'),
                                              Text('Weekly'),
                                              Text("Streak")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.sticky_note_2,
                                            color: Color(0xFF92DA8A),
                                            size: 30,
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('3'),
                                              Text('Certificates'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.back_hand,
                            color: Colors.grey.shade700,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Causes",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: gridHeight,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
                        childAspectRatio: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            causes.length > numOfRows
                                ? numOfRows
                                : causes.length, (index) {
                          final colors = [
                            Colors.orange.shade800,
                            Colors.cyan.shade700,
                            Colors.brown.shade300,
                            Colors.indigo.shade200,
                            Colors.blueGrey.shade400,
                            Colors.amber.shade700,
                            Colors.purple.shade300,
                          ];
                          final icons = [
                            // ImageIcon(
                            //     AssetImage("assets/images/icons/volunteer.png")),
                            Icons.elderly,
                            Icons.child_friendly_rounded,
                            Icons.pets,
                          ];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding:
                                        WidgetStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            colors[index % colors.length]),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Icon(
                                          icons[index % icons.length],
                                          color: Colors.white,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${causes[index][0].toUpperCase()}${causes[index].substring(1).toLowerCase()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            const AssetImage("assets/images/icons/volunteer.png"),
                            size: 17,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Past Campains",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.cyan.shade700,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                            ),
                            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("October 4"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Community Gardening",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Love and Care Ethiopia"),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.arrow_circle_right, color: Colors.cyan.shade700,),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.grey.shade700,),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Favorite Organizations",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Column(
                          children: [
                            Row(
                              children:[
                                SizedBox(
                                  width: 25,
                                ),
                                Icon(
                                Icons.check_circle_outline_rounded,
                                color: Color(0xFF92DA8A),
                              ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Meriam Beza Library"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children:[
                                SizedBox(
                                  width: 25,
                                ),
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Color(0xFF92DA8A),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Love and Care Ethiopia"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children:[
                                SizedBox(
                                  width: 25,
                                ),
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Color(0xFF92DA8A),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Meriam Beza Library"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    )); //   Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.settings),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
