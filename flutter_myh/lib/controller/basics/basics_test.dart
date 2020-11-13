class People {
  String name;
  play() {
    print('play');
  }
}

class Movie {
  void playMovie() {
    print('playMovie');
  }
}

class Car {
  void driveCar() {
    print('driveCar');
  }
}

class Cat {
  void eatFish() {
    print('猫吃鱼');
  }
}

class Dog {
  void running() {
    print('狗奔跑');
  }
}

// extends 单继承 with 混入其他class的方法 implements 接口实现，自己想抽离方法可以这样

class Student extends People with Cat, Dog implements Car, Movie {
  @override
  play() {
    eatFish();
    running();
    return super.play();
  }

  @override
  void driveCar() {}

  @override
  void playMovie() {}
}
