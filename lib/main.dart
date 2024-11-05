import 'package:account_book/accountbook_add.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
            FourthPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (newIndex) {
            print('selected newIndex : $newIndex');
            setState(() {
              currentIndex = newIndex;
            });
          },
          selectedItemColor: Colors.red, // 선택된 아이콘 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
          //showSelectedLabels: false, // 선택된 항목 label 숨기기
          //showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
          type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined), label: "가계부"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined), label: "통계"),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined), label: "자산"),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          /// AppBar
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "2020년 3월",
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star_border),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.list),
              ),
            ],

            /// TabBar
            bottom: const TabBar(
                isScrollable: false,
                indicatorColor: Colors.red,
                indicatorWeight: 4,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                // 선택된 탭 스타일
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // 선택되지 않은 탭 스타일
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(
                    text: "일일",
                  ),
                  Tab(
                    text: "달력",
                  ),
                  Tab(
                    text: "월별",
                  ),
                  Tab(
                    text: "결산",
                  ),
                  Tab(
                    text: "메모",
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              /// 첫번째 탭
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("수입"),
                            Text("지출"),
                            Text("합계"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Text("0"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text(
                          "일일",
                        ),
                      ),
                    ),
                  )
                ],
              ),

              /// 두번째 탭
              const Center(
                child: Text("달력"),
              ),

              /// 세번째 탭
              const Center(
                child: Text("월별"),
              ),

              /// 네번째 탭
              const Center(
                child: Text("결산"),
              ),

              /// 다섯번째 탭
              const Center(
                child: Text("메모"),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {},
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.red.shade400,
                  ),
                ),
                child: Icon(
                  Icons.assignment_add,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                backgroundColor: Colors.red.shade400,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountbookAdd(),
                    ),
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('테스트1'),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('테스트2'),
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('테스트3'),
        ),
      ),
    );
  }
}
