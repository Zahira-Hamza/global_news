// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../api/Data_Sources/Remote/remote_data_source.dart' as _i982;
import '../../api/Data_Sources/Remote/remote_data_source_impl.dart' as _i675;
import '../../api/dio_standers/dio_module.dart' as _i119;
import '../../api/web_services.dart' as _i1069;
import '../../data/Repositories_impl/news_repository_impl.dart' as _i180;
import '../../domain/Repositories_interface/news_repository.dart' as _i341;
import '../../features/presentation/News/Bloc/news_bloc.dart' as _i166;
import '../../features/presentation/Sources/Bloc/category_sources_bloc.dart'
    as _i385;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.singleton<_i361.BaseOptions>(() => dioModule.provideBaseOptions());
    gh.singleton<_i528.PrettyDioLogger>(() => dioModule.provideLogger());
    gh.singleton<_i361.Dio>(() => dioModule.provideDio(
          gh<_i361.BaseOptions>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.singleton<_i1069.WebServices>(
        () => dioModule.provideWebServices(gh<_i361.Dio>()));
    gh.factory<_i982.RemoteDataSource>(
        () => _i675.RemoteDataSourceImpl(gh<_i1069.WebServices>()));
    gh.factory<_i341.NewsRepository>(
        () => _i180.NewsRepositoryImpl(gh<_i982.RemoteDataSource>()));
    gh.factory<_i166.NewsBloc>(
        () => _i166.NewsBloc(gh<_i341.NewsRepository>()));
    gh.factory<_i385.CategorySourcesBloc>(
        () => _i385.CategorySourcesBloc(gh<_i341.NewsRepository>()));
    return this;
  }
}

class _$DioModule extends _i119.DioModule {}
