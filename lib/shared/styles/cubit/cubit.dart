import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';
import 'package:new_social_app/shared/styles/cubit/states.dart';


class ThemeCubit extends Cubit<ThemeStates>
{
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(ThemeChangeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(ThemeChangeModeState());
      });
    }
  }

}