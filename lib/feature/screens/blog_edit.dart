import 'dart:io';
import 'package:blog_app/product/constants/colors_items.dart';
import 'package:blog_app/product/constants/icon_items.dart';
import 'package:blog_app/product/constants/language_items.dart';
import 'package:blog_app/product/constants/number_items.dart';
import 'package:blog_app/product/models/blog_model.dart';
import 'package:blog_app/product/services/blog_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class BlogEditScreen extends ConsumerStatefulWidget {
  final BlogModel? blog; // Blog düzenleme için mevcut blogu alalım

  const BlogEditScreen({super.key, this.blog});

  @override
  ConsumerState<BlogEditScreen> createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends ConsumerState<BlogEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String blogTitle = "";
  String blogContent = "";
  String author = "";
  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.blog != null) {
      blogTitle = widget.blog!.title;
      blogContent = widget.blog!.content;
      author = widget.blog!.author;
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Blogu oluştur
        await ref.read(blogNotifierProvider.notifier).createBlog(
              title: blogTitle,
              content: blogContent,
              author: author,
              selectedImage: selectedImage,
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blog başarıyla eklendi!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.toString()}')),
        );
      }
    }
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsItems.homeBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: Text(widget.blog == null ? 'Yeni Blog Ekle' : 'Blog Düzenle'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                TextFieldStyle(
                  labelName: LanguageItems.blogTitle,
                  textFieldIcon: IconItems.titleIcon,
                  textLength: NumberItems.titleLength,
                  maxTextLines: NumberItems.maxTitleLines,
                  onSaved: (newValue) {
                    blogTitle = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LanguageItems.titleAlert;
                    }
                    return null;
                  },
                ),
                TextFieldStyle(
                  labelName: LanguageItems.blogContents,
                  textFieldIcon: IconItems.contentsIcon,
                  textLength: NumberItems.contentsLength,
                  maxTextLines: NumberItems.maxContentsLines,
                  onSaved: (newValue) {
                    blogContent = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LanguageItems.subtitleAlert;
                    }
                    return null;
                  },
                ),
                TextFieldStyle(
                  labelName: LanguageItems.blogAuthor,
                  textFieldIcon: IconItems.authorIcon,
                  textLength: NumberItems.authorLength,
                  maxTextLines: NumberItems.maxAuthorLines,
                  onSaved: (newValue) {
                    author = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LanguageItems.authorAlert;
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text(LanguageItems.addImage),
                ),
                if (selectedImage != null) Image.file(File(selectedImage!.path)),
                TextButton(onPressed: _submit, child: const Text(LanguageItems.send))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldStyle extends StatelessWidget {
  TextFieldStyle({
    super.key,
    required this.labelName,
    required this.textFieldIcon,
    required this.textLength,
    required this.maxTextLines,
    required this.onSaved,
    required this.validator,
  });

  final String labelName;
  final FocusNode _focusNode = FocusNode();
  final Icon textFieldIcon;
  final int textLength;
  final int maxTextLines;
  final dynamic onSaved;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      maxLines: maxTextLines,
      autofocus: true,
      focusNode: _focusNode,
      textInputAction: TextInputAction.next,
      maxLength: textLength,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: textFieldIcon,
        labelText: labelName,
      ),
    );
  }
}
