part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class CategorySelectEvent extends HomeEvent {
  final int index;
  CategorySelectEvent(this.index);
}

final class SubCategorySelectEvent extends HomeEvent {
  final int subIndex;
  SubCategorySelectEvent(this.subIndex);
}
