import 'dart:io' show Platform, File, Directory;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:ImageAI/screen/settings_page.dart';
import 'package:ImageAI/handlers/image_cubit.dart';
import 'package:path/path.dart' as xp;

import '../handlers/app_directory_cubit.dart';
import '../screen/strings.dart';
import '../screen/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageCubit _imageCubit;
  late AppDirectoryCubit _appDirectoryCubit;
  late Directory directory;
  final TextEditingController _textEditingController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<AIStyle, String> styleDisplayText = {
    AIStyle.noStyle: 'Bất kỳ',
    AIStyle.render3D: 'Hình 3D',
    AIStyle.anime: 'Anime',
    AIStyle.moreDetails: 'Chi tiết',
    AIStyle.cyberPunk: 'Tương lai',
    AIStyle.cartoon: 'Hoạt hình',
    AIStyle.picassoPainter: 'Màu sáp',
    AIStyle.oilPainting: 'Tranh dầu',
    AIStyle.digitalPainting: 'Kỹ thuật số',
    AIStyle.portraitPhoto: 'Chân dung',
    AIStyle.pencilDrawing: 'Vẽ chì',
  };

  Future<void> _saveImage(Uint8List canvas) async {
    final String path = _appDirectoryCubit.state.path;
    try {
      if (path != pathHint) {
        directory = Directory(path);
        final appDir = Directory('${directory.path}/$app');
        if (!(await appDir.exists())) {
          await appDir.create();
        }
        final image =
            'IMG-${DateTime.now().hour.toString()}-${DateTime.now().minute.toString()}-${DateTime.now().second.toString()}-${DateTime.now().millisecond.toString()}-ImageAI.png';
        final filePath = xp.join(appDir.path, image);
        final file = File(filePath);
        await file.writeAsBytes(canvas).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ảnh được tải về ở $filePath'),
              elevation: 10,
/*            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),*/
            ),
          );
        });
      } else {
        _choosePath();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Lưu : $e');
      }
      _choosePath();
    }
  }

  @override
  void initState() {
    super.initState();
    _imageCubit = ImageCubit();
    _appDirectoryCubit = context.read<AppDirectoryCubit>()..loadPath();
  }

  @override
  void dispose() {
    _imageCubit.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _imageCubit,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Icon(
                  Iconsax.setting_2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Iconsax.element_plus,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: 'Image',
              style: TextStyle(
                  //color: Colors.amber.shade900,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Arial'),
              children: [
                TextSpan(
                  text: 'AI',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Arial'),
                )
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 140,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextField(
                                    autofocus: false,
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                      hintText: "Hãy cho tôi biết ý tưởng của bạn",
                                      labelText: "Bạn đang nghĩ gì",
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _textEditingController.clear();
                                          });
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.clear,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      if (text.isEmpty) {
                                        setState(() {
                                          _textEditingController.clear();
                                        });
                                      }
                                    },
                                    onSubmitted: (query) {
                                      if (query.isNotEmpty) {
                                        if (FocusScope.of(context).hasFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        setState(() {
                                          _textEditingController.text = query;
                                        });
                                        _chooseStyle(
                                            _textEditingController.text);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),

                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        Color(0xFF8FC7E0),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_textEditingController
                                          .text.isNotEmpty) {
                                        FocusScope.of(context).unfocus();
                                        _chooseStyle(
                                            _textEditingController.text);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Text(
                                        'Vẽ',
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  autofocus: false,
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Hãy cho tôi biết ý tưởng của bạn",
                                    labelText: "Bạn đang nghĩ gì",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _textEditingController.clear();
                                        });
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.clear,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    if (text.isEmpty) {
                                      setState(() {
                                        _textEditingController.clear();
                                      });
                                    }
                                  },
                                  onSubmitted: (query) {
                                    if (query.isNotEmpty) {
                                      if (FocusScope.of(context).hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      setState(() {
                                        _textEditingController.text = query;
                                      });
                                      _chooseStyle(_textEditingController.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_textEditingController.text.isNotEmpty) {
                                    FocusScope.of(context).unfocus();
                                    _chooseStyle(_textEditingController.text);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(13),
                                  child: Icon(
                                    Icons.gesture,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                BlocBuilder<ImageCubit, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return Center(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(100),
                            child: Lottie.asset(
                              'assets/animations/loading.json',
                              frameRate: FrameRate(120),
                              repeat: true,
                              animate: true,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is ImageLoaded) {
                      final image = state.image;
                      if (Platform.isAndroid) {
                        if (MediaQuery.of(context).orientation ==
                            Orientation.portrait) {
                          return Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage('assets/images/Ai.webp'),
                                  image: MemoryImage(image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Lưu lại',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/a.png'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  focusColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  borderRadius: BorderRadius.circular(7),
                                  onTap: () async {
                                    await _saveImage(image);
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.24,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Lưu lại',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      } else {
                        if (MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/a.png'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  focusColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  borderRadius: BorderRadius.circular(7),
                                  onTap: () async {
                                    await _saveImage(image);
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.24,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Lưu lại',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage('assets/images/a.png'),
                                  image: MemoryImage(image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Lưu lại',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    }
                    if (state is ImageError) {
                      final error = state.error;
                      return Center(
                        child: Text(error),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseStyle(String query) async {
    showDialog<AIStyle>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Chọn kiểu ảnh bạn mong muốn:'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: styleDisplayText.entries.map((entry) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _imageCubit.generate(query, entry.key);
                      Navigator.pop(context);
                    },
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _choosePath() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn nơi lưu :'),
          content: const Text(
              'Bạn có chắc chọn đây là nơi lưu trữ ảnh'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }
}
