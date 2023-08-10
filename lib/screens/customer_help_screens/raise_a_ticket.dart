import 'dart:io';

import 'package:doctor_app_new/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show basename;
import 'package:file_picker/file_picker.dart';

import '../../../model/error_model.dart';
import '../../../model/uvDesk_model/uvDesk_ticket_raise_model.dart';
import '../../../repository/uvDesk_repo/uvDesk_repository.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../repository/api_service.dart';
import '../../services/uvDesk_service/uvDesk_service.dart';
import '../../utils/doctor_details_storage.dart';
import '../dashboard_screens/dashboard_screen.dart';

class RaiseATicket extends StatefulWidget {
  final String? name;
  final String? email;
  const RaiseATicket({Key? key, this.name, this.email}) : super(key: key);

  @override
  State<RaiseATicket> createState() => _RaiseATicketState();
}

class _RaiseATicketState extends State<RaiseATicket> {
  final formKey = GlobalKey<FormState>();
  final _prefs = AppConfig().preferences;

  late UvDeskService uvDeskService;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    uvDeskService = UvDeskService(uvDeskRepo: repository);
    nameController = TextEditingController(text: widget.name.toString());
    emailController = TextEditingController(text: widget.email.toString());
    titleController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
        body: Column(
          children: [
            SizedBox(height: 3.h),
            IntrinsicWidth(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/noun-tickets-956207.png',
                    height: 3.h,
                    color: gBlackColor,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "Raise A Ticket",
                    textAlign: TextAlign.center,
                    style: ProfileScreenText().headingText(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.5.h),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
            Expanded(
              child: buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  buildForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 6.h,
                    margin:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    padding: EdgeInsets.only(
                        left: 5.w, top: 0.6.h, bottom: 0.5.h, right: 0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: gGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      readOnly: true,
                      cursorColor: gPrimaryColor,
                      style: LoginScreen().mainTextField(),
                      decoration: InputDecoration(
                        // suffixIcon: nameController.text.isEmpty
                        //     ? const SizedBox()
                        //     : InkWell(
                        //   onTap: () {
                        //     nameController.clear();
                        //   },
                        //   child: Icon(
                        //     Icons.close,
                        //     color: gTextColor,
                        //     size: 2.h,
                        //   ),
                        // ),
                        hintText: "",
                        border: InputBorder.none,
                        hintStyle: LoginScreen().mainTextField(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kNumberCirclePurple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: fontSize08,
                          color: gWhiteColor,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Stack(
                children: [
                  Container(
                    height: 6.h,
                    margin:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    padding: EdgeInsets.only(
                        left: 5.w, top: 0.6.h, bottom: 0.5.h, right: 0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: gGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      readOnly: true,
                      cursorColor: gPrimaryColor,
                      style: LoginScreen().mainTextField(),
                      decoration: InputDecoration(
                        // suffixIcon: emailController.text.isEmpty
                        //     ? const SizedBox()
                        //     : InkWell(
                        //   onTap: () {
                        //     emailController.clear();
                        //   },
                        //   child: Icon(
                        //     Icons.close,
                        //     color: gTextColor,
                        //     size: 2.h,
                        //   ),
                        // ),
                        hintText: "",
                        border: InputBorder.none,
                        hintStyle: LoginScreen().mainTextField(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kNumberCirclePurple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: fontSize08,
                          color: gWhiteColor,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Stack(
                children: [
                  Container(
                    height: 6.h,
                    margin:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    padding: EdgeInsets.only(
                        left: 5.w, top: 0.6.h, bottom: 0.5.h, right: 0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: gGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      cursorColor: gPrimaryColor,
                      style: LoginScreen().mainTextField(),
                      decoration: InputDecoration(
                        suffixIcon: titleController.text.isEmpty
                            ? const SizedBox()
                            : InkWell(
                          onTap: () {
                            titleController.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: gTextColor,
                            size: 2.h,
                          ),
                        ),
                        hintText: "",
                        border: InputBorder.none,
                        hintStyle: LoginScreen().mainTextField(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kNumberCirclePurple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: fontSize08,
                          color: gWhiteColor,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Stack(
                children: [
                  Container(
                    height: 15.h,
                    margin:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    padding: EdgeInsets.only(
                        left: 5.w, top: 1.h, bottom: 0.5.h, right: 0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: gGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      cursorColor: gPrimaryColor,
                      style: LoginScreen().mainTextField(),
                      decoration: InputDecoration(
                        suffixIcon: descriptionController.text.isEmpty
                            ? const SizedBox()
                            : InkWell(
                          onTap: () {
                            descriptionController.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: gTextColor,
                            size: 2.h,
                          ),
                        ),
                        hintText: "",
                        border: InputBorder.none,
                        helperStyle: LoginScreen().mainTextField(),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kNumberCircleAmber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: fontSize08,
                          color: gBlackColor,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 1.h
              ),
              Stack(
                children: [
                  Container(
                    // height: 20.h,
                    constraints: BoxConstraints(maxHeight: 35.h),
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(
                        horizontal: 0.w, vertical: 1.5.h),
                    padding: EdgeInsets.only(
                        left: 2.w, top: 2.h, bottom: 0.5.h, right: 2.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: gGreyColor.withOpacity(0.3),
                      ),
                    ),
                    child: fileFormatList.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showChooserSheet();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Add",
                              style: TextStyle(
                                fontSize: fontSize08,
                                color: gBlackColor,
                                fontFamily: kFontMedium,
                              ),
                            ),
                            Icon(
                              Icons.attach_file_outlined,
                              color: Colors.black,
                              size: 10.sp,
                            )
                          ],
                        ),
                      ),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      itemCount: fileFormatList.length,
                      itemBuilder: (_, fileIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(basename(
                                  fileFormatList[fileIndex].path)),
                              InkWell(
                                onTap: () {
                                  newList.removeWhere((element) =>
                                  element.filename ==
                                      fileFormatList[fileIndex].path);

                                  fileFormatList.removeAt(fileIndex);

                                  print(newList);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: kPrimaryColor,
                                  size: 2.h,
                                ),
                                // SvgPicture.asset(
                                //           "assets/images/DElete.svg",
                                //           color: kPrimaryColor,
                                //         ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, fileIndex) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: gGreyColor,
                            thickness: 1.2,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 6.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kNumberCircleAmber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Attachments",
                        style: TextStyle(
                          fontSize: fontSize08,
                          color: gTextColor,
                          fontFamily: kFontMedium,
                        ),
                      ),
                    ),
                  ),
                  if (fileFormatList.isNotEmpty)
                    Positioned(
                      right: 6.w,
                      child: GestureDetector(
                        onTap: () {
                          showChooserSheet();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kNumberCircleAmber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: fontSize08,
                                  color: gWhiteColor,
                                  fontFamily: kFontMedium,
                                ),
                              ),
                              Icon(
                                Icons.attach_file_outlined,
                                color: Colors.black,
                                size: 10.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(height: 4.h),
              IntrinsicWidth(
                child: GestureDetector(
                  onTap: () {
                    print("fileFormatList: ${fileFormatList.length}");
                    print("newList.length: ${newList.length}");

                    if (titleController.text.isEmpty) {
                      AppConfig().showSnackBar(context, "Please Mention Title",
                          isError: true);
                    } else if (descriptionController.text.isEmpty) {
                      AppConfig().showSnackBar(
                          context, "Please Mention Description",
                          isError: true);
                    } else {
                      ticketRaise();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h, horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: gSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: (isLoading)
                        ? buildThreeBounceIndicator(color: whiteTextColor)
                        : Center(
                      child: Text(
                        'Submit',
                        style: LoginScreen().buttonText(whiteTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showChooserSheet() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        enableDrag: false,
        builder: (ctx) {
          return Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      child: Text('Choose File Source'),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: gHintTextColor,
                              width: 3.0,
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              getImageFromCamera();
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_enhance_outlined,
                                  color: gMainColor,
                                ),
                                Text('Camera'),
                              ],
                            )),
                        Container(
                          width: 5,
                          height: 10,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: gHintTextColor,
                                  width: 1,
                                ),
                              )),
                        ),
                        TextButton(
                            onPressed: () {
                              pickFromFile();
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.insert_drive_file,
                                  color: gMainColor,
                                ),
                                Text('File'),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  getFileSize(File file) {
    var size = file.lengthSync();
    num mb = num.parse((size / (1024 * 1024)).toStringAsFixed(2));
    return mb;
  }

  List<MultipartFile> newList = <MultipartFile>[];
  List<File> fileFormatList = [];

  void pickFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      withReadStream: true,
      type: FileType.any,
      // allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      allowMultiple: true,
    );
    if (result == null) return;

    /// if allowMultiple: true
    List<File> _files = result.paths.map((path) => File(path!)).toList();

    _files.forEach((element) {
      print(element.path.split('.').last);
      if (element.path.split('.').last.toLowerCase().contains("pdf") ||
          element.path.split('.').last.toLowerCase().contains("png") ||
          element.path.split('.').last.toLowerCase().contains("jpg") ||
          element.path.split('.').last.toLowerCase().contains("jpeg")) {
        if (getFileSize(element) <= 12) {
          print("filesize: ${getFileSize(File(result.paths.first!))}Mb");
          print(element.path);
          addFilesToList(element);
          // addToMultipartList();
        } else {
          AppConfig()
              .showSnackBar(context, "File size must be <12Mb", isError: true);
        }
      } else {
        AppConfig().showSnackBar(context, "Please select png/jpg/Pdf files",
            isError: true);
      }
    });

    /// single file select for this  allowMultiple should be false allowMultiple: false
    // if (result.files.first.extension!.contains("pdf") ||
    //     result.files.first.extension!.contains("png") ||
    //     result.files.first.extension!.contains("jpg") ||
    //     result.files.first.extension!.contains("jpeg")) {
    //   if (getFileSize(File(result.paths.first!)) <= 12) {
    //     print("filesize: ${getFileSize(File(result.paths.first!))}Mb");
    //     files.add(result.files.first);
    //     // addFilesToList(File(result.paths.first!));
    //     if (type != null) {
    //       if (reportsObject.isNotEmpty) {
    //         reportsObject.forEach((element) {
    //           if (element.id.toString().contains(type)) {
    //             element.path.add(result.paths.first!);
    //           }
    //         });
    //       }
    //       if (type == "others") {
    //         otherFilesObject.add(result.paths.first ?? '');
    //       }
    //       print("otherFilesObject: $otherFilesObject");
    //     }
    //   }
    //   else {
    //     AppConfig()
    //         .showSnackbar(context, "File size must be <12Mb", isError: true);
    //   }
    // }
    // else {
    //   AppConfig().showSnackbar(context, "Please select png/jpg/Pdf files",
    //       isError: true);
    // }
    setState(() {});
  }

  addFilesToList(File file) async {
    print(
        "contains: ${fileFormatList.any((element) => element.path == file.path)}");

    if (!fileFormatList.any((element) => element.path == file.path)) {
      fileFormatList.add(file);
    }
    setState(() {});
  }

  addToMultipartList() async {
    print("addToMultipartList");
    newList.clear();

    // for (int i = 0; i < fileFormatList.length; i++) {
    //   var length = await fileFormatList[i].length();
    //   print("cleard: $i");
    //   print("newList for: ${newList.length} ${fileFormatList.length}");
    //   var stream =
    //   http.ByteStream(DelegatingStream.typed(fileFormatList[i].openRead()));
    //   var multipartFile = http.MultipartFile("attachments[]", stream, length,
    //       filename: fileFormatList[i].path);
    //   newList.add(multipartFile);
    //   print("newList after: ${newList.length}");
    // }

    print("fileFormatList: ${fileFormatList.length}");

    print("newList: ${newList.length}");
  }

  File? _image;

  Future getImageFromCamera({String? type}) async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 40);

    setState(() {
      _image = File(image!.path);
      if (getFileSize(_image!) <= 12) {
        print("filesize: ${getFileSize(_image!)}Mb");

        addFilesToList(_image!);
      } else {
        print("filesize: ${getFileSize(_image!)}Mb");

        AppConfig()
            .showSnackBar(context, "File size must be <12Mb", isError: true);
      }
    });
    print("captured image: ${_image} ${_image!.path}");
  }

  isExists(File file) {
    fileFormatList.map((element) {
      if (element.absolute.path == file.absolute.path) {
        print("found :: path exists file: ${file.path} ele: ${element.path}");
        return true;
      } else {
        print(
            "found :: path not exists file: ${file.path} ele: ${element.path}");
        return false;
      }
    });
  }

  final UvDeskRepo repository = UvDeskRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  ticketRaise() async {
    setState(() {
      isLoading = true;
    });

    Map data = {
      //'type': "${TicketStatusType.open.index+1}",
      'name': nameController.text,
      'from': emailController.text,
      'message': descriptionController.text,
      'subject': titleController.text,
      'actAsType': "agent",
      'actAsEmail': _prefs!.getString(DoctorDetailsStorage.doctorDetailsEmail),
      'agent_id': _prefs!.getString(DoctorDetailsStorage.doctorDetailsUvId),
    };

    print("---------Ticket Raise---------");

    final result = await uvDeskService.uvDaskTicketRaiseService(data,
        attachments: fileFormatList.isNotEmpty ? fileFormatList : null);

    if (result.runtimeType == UvDeskTicketRaiseModel) {
      UvDeskTicketRaiseModel model = result as UvDeskTicketRaiseModel;
      setState(() {
        isLoading = false;
      });
      AppConfig().showSnackBar(context, model.message!, isError: false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: true);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
  }
}
