```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.WRITE_INTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_INTERNAL_STORAGE" />
</manifest>
```

```dart
BlocProvider(create: (_) => CounterBloc()),
BlocProvider(create: (_) => SwitchBloc()),
BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
```

> **_Dependency Injection_**

```dart
class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
  }

  void _cameraCapture(
      CameraCapture event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void _galleryPicker(
      GalleryPicker event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}
```

```dart
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> cameraCapture() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file;
  }

  Future<XFile?> pickImageFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file;
  }
}
```

```dart
class ImagePickerState extends Equatable {
  final XFile? file;

  const ImagePickerState({this.file});

  ImagePickerState copyWith({XFile? file}) {
    return ImagePickerState(file: file ?? this.file);
  }

  @override
  List<Object?> get props => [file];
}
```

```dart
@immutable
abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class CameraCapture extends ImagePickerEvent {}

class GalleryPicker extends ImagePickerEvent {}
```

```dart
body: Center(
    child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          return state.file == null
            ? InkWell(
                onTap: () { context.read<ImagePickerBloc>().add(CameraCapture());},
                child: const CircleAvatar(radius: 20,child: Icon(Icons.camera),),
            )
            : Image.file(File(state.file!.path.toString()), height: 200, width: 200,);
        }
    ),
)
```
