import 'package:my_app/Repositiriy.dart';

class ViewModel {
  final Repo myRepo;

  const ViewModel(this.myRepo);

  List<Map<String, myData>> getData() {
    return myRepo.myDataList;
  }

  List<BtnState> getTitleData() {
    return myRepo.titleData;
  }
}
