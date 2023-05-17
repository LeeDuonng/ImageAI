import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
              text: 'Giới thiệu dự án ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Arial',
              ),
              children: [
                TextSpan(
                  text: 'ImageAI',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Arial',
                  ),
                ),
              ]),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mô tả',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'ImageAI là một ứng dụng được tạo ra bằng Flutter framework, đây là một công cụ mới sử dụng trí tuệ nhân tạo để tạo ra những tác phẩm nghệ thuật ấn tượng từ những đoạn văn bản. Ngoài ra, ImageAI còn có khả năng tạo ra những biến thể của hình ảnh hiện có. Để thực hiện điều này, ứng dụng sử dụng API brain_fusion để tạo ra những hình ảnh được phác thảo một cách rất thực tế. Với ImageAI, người dùng có thể dễ dàng tạo ra các tác phẩm nghệ thuật số độc đáo và sáng tạo mà không cần có kỹ năng vẽ hay thiết kế chuyên nghiệp.',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tính năng',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '- Tạo Hình ảnh từ Văn bản. \n - Phản hồi không giới hạn. \n - Tải xuống hình ảnh \n - Chế độ sáng tối. \n - Chế độ màu chủ đề. \n - Nhẹ & Thân thiện với Người dùng.',                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cách thức hoạt động',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "1. Đảm bảo rằng bạn nhập một lời mô tả chi tiết hơn. Vì đây là một API mới, nó sẽ mất thời gian để tạo ra những hình ảnh chất lượng cao với một lời mô tả ít chi tiết hơn. Vì vậy, hãy đảm bảo rằng bạn mô tả hình ảnh một cách chính xác để đạt được kết quả mong muốn. \n \n 2. Hãy thử chọn các kiểu dáng khi tạo hình ảnh của bạn. Hãy kiểm tra các kiểu dáng khác nhau và xem hình ảnh đầu ra trông như thế nào.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "🌟",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Arial',
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Thông tin liên hệ',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final Uri url =
                    Uri.parse('https://www.facebook.com/T0nyTeoo/');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Đường dẫn lỗi $url');
                    }
                  },
                  child: const Text(
                    'Facebook',
                    style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url =
                    Uri.parse('http://zaloapp.com/qr/p/1i82hhrytii7');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Đường dẫn lỗi $url');
                    }
                  },
                  child: const Text(
                    'Zalo',
                    style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(
          "Nhóm 11",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
