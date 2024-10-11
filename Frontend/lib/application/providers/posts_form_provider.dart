import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostFormState {
  final String name;
  final String description;
  final String contact;
  final bool isValid;

  PostFormState({
    this.name = '',
    this.description = '',
    this.contact = '',
    this.isValid = false,
  });

  PostFormState copyWith({
    String? name,
    String? description,
    String? contact,
    bool? isValid,
  }) {
    return PostFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      isValid: isValid ?? this.isValid,
    );
  }
}

class PostFormNotifier extends StateNotifier<PostFormState> {
  PostFormNotifier() : super(PostFormState());

  void updateName(String name) {
    state = state.copyWith(name: name, isValid: _validate());
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description, isValid: _validate());
  }

  void updateContact(String contact) {
    state = state.copyWith(contact: contact, isValid: _validate());
  }

  bool _validate() {
    return state.name.isNotEmpty &&
        state.description.isNotEmpty &&
        state.contact.isNotEmpty;
  }

  void clear() {
    state = PostFormState();
  }
}

final postFormProvider =
    StateNotifierProvider<PostFormNotifier, PostFormState>((ref) {
  return PostFormNotifier();
});
