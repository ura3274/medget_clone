class myData {
  final int id;
  final String title;
  final String image;

  const myData({required this.id, required this.title, required this.image});
}

class BtnState {
  int id;
  String title;
  bool isChecked;

  BtnState({required this.id, required this.title, this.isChecked = false});
}

class Repo {
  final myDataList = [
    {
      "Популярные фильмы": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные сериалы": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные мультсериалы":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные боевики": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные сериалы HBO":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
    },
    {
      "Новинки фильмов": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные фильмы": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Лучшее кино 80-90х": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Лучшие фильмы нулевых":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Фильмы 2010-2020": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Фильмы по рейтингу пользователей":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh")
    },
    {
      "Новинки сериалов": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные сериалы": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные сериалы Netflix":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Популярные сериалы Fox":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Сериалы по рейтингу пользователей":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh")
    },
    {
      "Популярные мультсериалы":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Мультфильмы Pixar": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Мультфильмы Disney": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
      "Мультфильмы по рейтингу пользователей":
          myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh")
    },
    {
      "Total": myData(id: 0, title: "hhhhhhhh", image: "hhhhhhhh"),
    }
  ];

  final titleData = <BtnState>[
    BtnState(id: 0, title: "Все"),
    BtnState(id: 1, title: "Фильмы"),
    BtnState(id: 2, title: "Сериалы"),
    BtnState(id: 3, title: "Мультфильмы"),
    BtnState(id: 4, title: "Игры"),
  ];
}
