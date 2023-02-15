void main() {
  print("Hi 1");
  Future.delayed(Duration(seconds: 5), () {
    print("Finished waiting");
  });

  print("Hi 2");  
}
