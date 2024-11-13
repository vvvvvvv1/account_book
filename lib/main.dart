import 'package:account_book/accountbook_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

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
          /// 보여주려는 페이지 index
          index: currentIndex,

          /// 보여줄 수 있는 모든 페이지 위젯 리스트
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
          //showSelectedLabels: false,          // 선택된 항목 label 숨기기
          //showUnselectedLabels: false,        // 선택되지 않은 항목 label 숨기기
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

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  DateTime MainSelectDateTime = DateTime.now();
  DateTime MainSelectFirstDay =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime MainSelelctLastDay =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  /// 연도와 월 업데이트 (화살표 아이콘 클릭)
  void _updateYearMonth(int monthChange) {
    setState(() {
      MainSelectDateTime = DateTime(
          MainSelectDateTime.year, MainSelectDateTime.month + monthChange);

      // 해당 달의 1일 표출
      MainSelectFirstDay = DateTime(
          MainSelectFirstDay.year, MainSelectFirstDay.month + monthChange, 1);

      // 해당 달의 마지막일 표출
      MainSelelctLastDay = DateTime(MainSelelctLastDay.year,
          MainSelelctLastDay.month + monthChange + 1, 0);
    });
  }

  //#region _selectDate 메서드
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: MainSelectDateTime,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null && picked != MainSelectDateTime) {
  //     setState(() {
  //       MainSelectDateTime = picked;
  //     });
  //   }
  // }
  //#endregion

  /// showDatePicker를 사용하여 년월 선택 및 선택 날짜 변수에 저장
  Future<void> _selectYearMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectDateTime, // 다이얼로그 열릴 때 기본 선택된 날짜
      firstDate: DateTime(2000), // 사용자가 선택할 수 있는 가장 이른 날짜
      lastDate: DateTime(2100), // 사용자가 선택할 수 있는 가장 마지막 날짜
      initialDatePickerMode: DatePickerMode.year, // 다이얼로그가 열릴 때 연도 선택 모드로 시작
      helpText: "년월 선택", // 다이얼로그 상단에 표시되는 텍스트
    );
    if (picked != null) {
      setState(() {
        MainSelectDateTime = DateTime(picked.year, picked.month); // 선택한 년, 월 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'), // 한국어 로케일 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // 한국어 등 로케일을 지원
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // 한국어 지원
        Locale('en', 'US'), // 영어 지원 (옵션)
      ],
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          /// AppBar
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                IconButton(
                  onPressed: () => _updateYearMonth(-1),
                  icon: const Icon(Icons.arrow_back),
                ),
                GestureDetector(
                  onTap: () =>
                      _selectYearMonth(context), // 텍스트 클릭 시 DatePicker 열기
                  child: Text(
                    "${MainSelectDateTime.year}년 ${MainSelectDateTime.month}월",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () => _updateYearMonth(1),
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
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
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("수입"),
                            Text("지출"),
                            Text("합계"),
                          ],
                        ),
                        const Row(
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
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
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
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("수입"),
                            Text("지출"),
                            Text("합계"),
                          ],
                        ),
                        const Row(
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
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TableCalendar(
                        daysOfWeekHeight: 20,
                        daysOfWeekStyle: const DaysOfWeekStyle(),
                        locale: 'ko_KR',
                        headerVisible: false,
                        focusedDay: MainSelectDateTime,
                        firstDay: DateTime.utc(1900, 1, 1),
                        lastDay: DateTime.utc(2100, 1, 1),
                        calendarStyle: const CalendarStyle(
                          cellMargin: EdgeInsets.all(8),
                          defaultTextStyle: TextStyle(
                            fontSize: 10,
                          ),
                          todayTextStyle: TextStyle(
                            fontSize: 10,
                          ),
                          tableBorder: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.grey,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              /// 세번째 탭
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("수입"),
                            Text("지출"),
                            Text("합계"),
                          ],
                        ),
                        const Row(
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
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text(
                          "월별",
                        ),
                      ),
                    ),
                  )
                ],
              ),

              /// 네번째 탭
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("수입"),
                            Text("지출"),
                            Text("합계"),
                          ],
                        ),
                        const Row(
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
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 30,
                                ),
                              ),
                              const Icon(Icons.add_card_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '예산',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.grey.shade200,
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '예산설정',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 30,
                                ),
                              ),
                              const Icon(Icons.attach_money_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '자산',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${MainSelectDateTime.year.toString().substring(2)}.${MainSelectDateTime.month}.${MainSelectFirstDay.day} ~ ${MainSelectDateTime.year.toString().substring(2)}.${MainSelectDateTime.month}.${MainSelelctLastDay.day}',
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
