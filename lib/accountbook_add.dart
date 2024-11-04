import 'package:flutter/material.dart';

class AccountbookAdd extends StatefulWidget {
  const AccountbookAdd({super.key});

  @override
  _AccountbookAddState createState() => _AccountbookAddState();
}

class _AccountbookAddState extends State<AccountbookAdd> {
  final TextEditingController _dateTimeController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    // 날짜 선택
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null) return; // 선택 취소 시

    // 시간 선택
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return; // 선택 취소 시

    // 선택된 날짜와 시간을 결합하여 TextField에 표시
    final DateTime selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _dateTimeController.text =
          '${selectedDateTime.year}-${selectedDateTime.month.toString().padLeft(2, '0')}-${selectedDateTime.day.toString().padLeft(2, '0')} '
          '${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            '지출',
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
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text("수입"),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text("지출"),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade200),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text("이체"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 날짜와 시간을 선택하는 TextField 추가

              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 18),
                  const Text('테스트'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _dateTimeController,
                      readOnly: true,
                      onTap: () => _selectDateTime(context), // 날짜 및 시간 선택기 실행
                      decoration: const InputDecoration(
                        hintText: '날짜와 시간을 선택하세요',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey), // 기본 밑줄 색상
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue), // 포커스 시 밑줄 색상
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
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
