import 'package:flutter/material.dart';

void main() => runApp(const RoohMashwarApp());

class RoohMashwarApp extends StatelessWidget {
  const RoohMashwarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'روح مشوار',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF7619)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final pickup = TextEditingController();
  final dropoff = TextEditingController();
  final receiver = TextEditingController();
  final phone = TextEditingController();

  void newOrder() {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 18, right: 18, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('طلب توصيل جديد',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            TextField(controller: pickup, textDirection: TextDirection.rtl,
              decoration: const InputDecoration(labelText: 'عنوان الاستلام', prefixIcon: Icon(Icons.location_on_outlined))),
            TextField(controller: dropoff, textDirection: TextDirection.rtl,
              decoration: const InputDecoration(labelText: 'عنوان التسليم', prefixIcon: Icon(Icons.flag_outlined))),
            TextField(controller: receiver, textDirection: TextDirection.rtl,
              decoration: const InputDecoration(labelText: 'اسم المستلم')),
            TextField(controller: phone, keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'رقم الهاتف')),
            const SizedBox(height: 12),
            const Text('السعر التقديري: 35 جنيه', textAlign: TextAlign.right,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFFFF7619))),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إنشاء الطلب التجريبي بنجاح ✅')));
              },
              child: const Text('تأكيد الطلب'),
            )
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF10202D),
          foregroundColor: Colors.white,
          title: const Text('روح مشوار 🛵',
            style: TextStyle(fontWeight: FontWeight.w900)),
          centerTitle: false,
        ),
        body: IndexedStack(index: tab, children: [
          _home(), _orders(), _account()
        ]),
        floatingActionButton: tab == 0 ? FloatingActionButton.extended(
          backgroundColor: const Color(0xFFFF7619), foregroundColor: Colors.white,
          onPressed: newOrder, icon: const Icon(Icons.add),
          label: const Text('طلب توصيل'),
        ) : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (v) => setState(() => tab = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.local_shipping_outlined), selectedIcon: Icon(Icons.local_shipping), label: 'طلباتي'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      )
    );
  }

  Widget _home() => ListView(padding: const EdgeInsets.all(16), children: [
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF7619), Color(0xFFFFA45B)]),
        borderRadius: BorderRadius.circular(22)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('وصّل أي حاجة بسرعة ⚡',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('اطلب مشوارك وخليك متابع الطلب لحظة بلحظة.',
          style: TextStyle(color: Colors.white)),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFF10202D)),
          onPressed: newOrder, child: const Text('ابدأ مشوار جديد')),
      ]),
    ),
    const SizedBox(height: 14),
    Card(child: ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFFFFEEE3),
        child: const Icon(Icons.inventory_2_outlined, color: Color(0xFFFF7619))),
      title: const Text('توصيل طلب', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Text('مستندات، أغراض، طلبات وأكثر'),
      trailing: const Icon(Icons.chevron_left),
    )),
    Card(child: ListTile(
      title: const Text('آخر طلب #2568', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Text('السائق في الطريق • متوقع الوصول 12 دقيقة'),
      trailing: const Icon(Icons.location_searching, color: Color(0xFFFF7619)),
    )),
  ]);

  Widget _orders() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('طلباتي', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    Card(child: ListTile(
      title: const Text('#2568'),
      subtitle: const Text('جاري التوصيل'),
      trailing: const Chip(label: Text('في الطريق')),
    )),
    Card(child: ListTile(
      title: const Text('#2511'),
      subtitle: const Text('تم التسليم'),
      trailing: const Chip(label: Text('مكتمل')),
    )),
  ]);

  Widget _account() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('حسابي', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    const Card(child: ListTile(
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text('سامي يوسف', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('01012345678'),
    )),
    Card(child: Column(children: const [
      ListTile(leading: Icon(Icons.location_on_outlined), title: Text('العناوين المحفوظة')),
      Divider(height: 1),
      ListTile(leading: Icon(Icons.notifications_none), title: Text('الإشعارات')),
      Divider(height: 1),
      ListTile(leading: Icon(Icons.support_agent), title: Text('الدعم والمساعدة')),
    ])),
  ]);
}
