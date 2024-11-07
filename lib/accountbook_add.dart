import 'package:flutter/material.dart';

class AccountbookAdd extends StatefulWidget {
  const AccountbookAdd({super.key});

  @override
  _AccountbookAddState createState() => _AccountbookAddState();
}

class _AccountbookAddState extends State<AccountbookAdd> {
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime selectDateTime = DateTime.now(); // 사용자가 선택한 날짜와 시간을 저장

  final List<bool> _isSelected = [false, false, false];

  String title = "";

  // 선택 버튼 찾기
  void _selectButton(int index) {
    setState(() {
      for (var i = 0; i < _isSelected.length; i++) {
        // **참(true)**일 때는 현재 인덱스(i)가 클릭된 버튼의 인덱스(index)와 같음
        // **거짓(false)**일 때는 클릭된 버튼이 아니므로 _isSelected[i]를 false로 설정하여 선택되지 않은 상태
        _isSelected[i] = i == index;
      }

      // 선택된 버튼에 따라 AppBar 타이틀 변경
      if (_isSelected[0]) {
        title = "수입";
      } else if (_isSelected[1]) {
        title = "지출";
      } else if (_isSelected[2]) {
        title = "이체";
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 초기 상태에 현재 날짜와 시간을 지정
    _dateTimeController.text = formatDateTimeWithDayAndMeridiem(selectDateTime);

    _selectButton(1);
  }

  // 날짜와 시간을 "YYYY-MM-DD (요일) 오전/오후 HH:mm" 형식으로 포맷하는 함수
  String formatDateTimeWithDayAndMeridiem(DateTime dateTime) {
    const List<String> koreanWeekdays = ['월', '화', '수', '목', '금', '토', '일'];

    // 요일 설정
    String dayOfWeek = koreanWeekdays[dateTime.weekday - 1];

    // 오전/오후 구분 및 12시간 포맷 설정
    String meridiem = dateTime.hour < 12 ? '오전' : '오후';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;

    // 날짜와 요일, 시간 문자열 포맷
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ($dayOfWeek) '
        '$meridiem $hour:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // 날짜 선택기 호출
    final DateTime? date = await showDatePicker(
      context: context,

      /// 팝업이 열릴 때 기본적으로 보여줄 날짜
      initialDate: selectDateTime,

      /// 사용자가 선택할 수 있는 날짜의 시작 범위
      firstDate: DateTime(1990),

      /// 사용자가 선택할 수 있는 날짜의 끝 범위
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    // 시간 선택기 호출
    final TimeOfDay? time = await showTimePicker(
      context: context,

      /// 팝업이 열릴 때 기본적으로 보여줄 시간
      initialTime:
          TimeOfDay(hour: selectDateTime.hour, minute: selectDateTime.minute),
    );
    if (time == null) return;

    /// 선택된 날짜와 시간을 결합하여 표시
    setState(() {
      selectDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      /// 새로운 날짜 및 시간 포맷된 문자열로 변환 후 적용
      _dateTimeController.text =
          formatDateTimeWithDayAndMeridiem(selectDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            title,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 이전 화면으로 이동
              Navigator.of(context).pop();
            },
          ),
          actions: const [
            Icon(
              Icons.star_outline,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.mic_none_outlined,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 파랑 파랑 파랑
                  TextButton(
                    onPressed: () => _selectButton(0),
                    style: ButtonStyle(
                      foregroundColor: _isSelected[0]
                          ? WidgetStateProperty.all(Colors.blue.shade300)
                          : WidgetStateProperty.all(Colors.grey.shade600),
                      backgroundColor: _isSelected[0]
                          ? WidgetStateProperty.all(Colors.white)
                          : WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: _isSelected[0]
                                ? Colors.blue.shade300
                                : Colors.grey,
                          ),
                        ),
                      ),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text("수입"),
                  ),
                  // 주황 주황 주황
                  TextButton(
                    onPressed: () => _selectButton(1),
                    style: ButtonStyle(
                      foregroundColor: _isSelected[1]
                          ? WidgetStateProperty.all(Colors.orange.shade900)
                          : WidgetStateProperty.all(Colors.grey.shade600),
                      backgroundColor: _isSelected[1]
                          ? WidgetStateProperty.all(Colors.white)
                          : WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: _isSelected[1]
                                ? Colors.orange.shade900
                                : Colors.grey,
                          ),
                        ),
                      ),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text("지출"),
                  ),
                  // 검정 겅정 검정
                  TextButton(
                    onPressed: () => _selectButton(2),
                    style: ButtonStyle(
                      foregroundColor: _isSelected[2]
                          ? WidgetStateProperty.all(Colors.black)
                          : WidgetStateProperty.all(Colors.grey.shade600),
                      backgroundColor: _isSelected[2]
                          ? WidgetStateProperty.all(Colors.white)
                          : WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: _isSelected[2] ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text("이체"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    const Text('날짜'),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 17),
                        child: TextField(
                          controller: _dateTimeController,

                          /// 읽기 전용 (사용자 직접 입력 불가)
                          readOnly: true,

                          /// 날짜 및 시간 선택기 실행
                          onTap: () => _selectDateTime(context),
                          decoration: const InputDecoration(
                            // hintText: '날짜와 시간을 선택하세요',

                            // TextField가 선택되지 않았을 때 나타나는 밑줄 스타일
                            // UnderlineInputBorder로 설정하여 밑줄만 표시
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey), // 기본 밑줄 색상
                            ),

                            /// TextField가 선택되었을 때 나타나는 밑줄 스타일
                            /// UnderlineInputBorder를 사용해 밑줄을 표시
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue), // 포커스 시 밑줄 색상
                            ),
                            //suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '금액',
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '분류',
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '자산',
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '내용',
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              /// 빈 바
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
              const SizedBox(
                height: 10,
              ),

              /// 메모
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '메모',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              // 저장
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.orange.shade900),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          '저장하기',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          '계속',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
