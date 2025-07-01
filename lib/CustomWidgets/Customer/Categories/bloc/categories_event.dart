part of 'categories_bloc.dart';

abstract class CategoriesEvent {}

class CategoriesSelectEvent extends CategoriesEvent {
  final int index;
  CategoriesSelectEvent(this.index);
}

class CategoriesSubSelectEvent extends CategoriesEvent {
  final int subIndex;
  CategoriesSubSelectEvent(this.subIndex);
}
