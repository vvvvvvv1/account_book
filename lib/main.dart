import 'package:account_book/Class/Transaction.dart';
import 'package:account_book/accountbook_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  DateTime MainSelectDateTime = DateTime.now();

  /// 해당 년월 첫날 표출
  DateTime MainSelectFirstDay =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  /// 해당 년월 마지막날 표출
  DateTime MainSelelctLastDay =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  /// 해당년도 표출
  DateTime MainSelectYear = DateTime.now();

  late TabController _tabController;

  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();

    /// 특정 Tab 클릭 시 다른 AppBar 표출
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });

    transactions.add(Transaction(
      date: "01", // 날짜
      dayOfWeek: "일요일", // 요일
      category: "교통/차량", // 카테고리
      description: "테스트", // 설명
      time: "오후 3:16", // 시간
      bank: "신한은행", // 장소/은행
      income: 0, // 수입
      expense: 0, // 지출)
    ));
  }

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

  /// 연도와 월 업데이트 (화살표 아이콘 클릭)
  void _updateYear(int yearChange) {
    setState(() {
      MainSelectYear = DateTime(MainSelectYear.year + yearChange);
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

  /// showDatePicker를 사용하여 년월 선택 및 선택 날짜 변수에 저장 (년월 선택)
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

  /// showDatePicker를 사용하여 년월 선택 및 선택 날짜 변수에 저장 (년월 선택)
  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: MainSelectYear, // 다이얼로그 열릴 때 기본 선택된 날짜
      firstDate: DateTime(2000), // 사용자가 선택할 수 있는 가장 이른 날짜
      lastDate: DateTime(2100), // 사용자가 선택할 수 있는 가장 마지막 날짜
      initialDatePickerMode: DatePickerMode.year, // 다이얼로그가 열릴 때 연도 선택 모드로 시작
      helpText: "년도 선택", // 다이얼로그 상단에 표시되는 텍스트
    );
    if (picked != null) {
      setState(() {
        MainSelectYear = DateTime(picked.year); // 선택한 년, 월 저장
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
            title: _tabController.index == 2
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () => _updateYear(-1),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      GestureDetector(
                        onTap: () =>
                            _selectYear(context), // 텍스트 클릭 시 DatePicker 열기
                        child: Text(
                          "${MainSelectYear.year}년",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _updateYear(1),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  )
                : Row(
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
            bottom: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorColor: Colors.red,
                indicatorWeight: 4,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                // 선택된 탭 스타일
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // 선택되지 않은 탭 스타일
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
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
            controller: _tabController,
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
                    child: transactions.isEmpty
                        ? const Center(
                            child: Text('데이터 없음'),
                          )
                        : ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final trans = transactions[index];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  //borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          trans.date,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Text(
                                            trans.dayOfWeek,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${MainSelectDateTime.year}. ${MainSelectDateTime.month}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 150,
                                        ),
                                        Text(
                                          '${trans.income}원',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${trans.expense}원',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
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
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.car,
                                        ),
                                        Text(
                                          trans.category,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${trans.description}\n',
                                              ),
                                              TextSpan(
                                                text:
                                                    '${trans.time}  ${trans.bank}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${trans.income}원',
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
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
                      color: Colors.white,
                      child: ListView(
                        children: [
                          ExpansionTile(
                            showTrailingIcon: false,
                            title: const Text('12월'),
                            children: [
                              Container(
                                color: Colors.grey,
                                child: const ListTile(
                                  title: Text('12 ~ 12'),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                                  horizontal: 13,
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
                                  horizontal: 10,
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
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 23),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '전월대비 지출 (당월/전월)',
                                    ),
                                    Spacer(),
                                    Text(
                                      '0%',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '지출 (현금,은행)',
                                    ),
                                    Spacer(),
                                    Text(
                                      '0원',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '지출 (카드)',
                                    ),
                                    Spacer(),
                                    Text(
                                      '0원',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '이체 (현금,은행->)',
                                    ),
                                    Spacer(),
                                    Text(
                                      '0원',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                              SizedBox(
                                width: 450,
                                height: 40,
                                child: TextButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      print('Click');
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.fileExcel,
                                          color: Colors.lightGreen,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '메일로 엑셀파일 내보내기',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
