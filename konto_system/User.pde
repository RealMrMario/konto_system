class bruger {
  private int _id= -1;
  private String _name = "tilføj navn";
  private String _email = "tilføj email";


  bruger()
  {
  }
  bruger(int ID, String Name, String Email)
  {
    _id = ID;
    _name = Name;
    _email = Email;
  }
  void set_id(int ID) {
    _id = ID;
  }
  void set_name(String Name) {
    _name = Name;
  }
  void set_email(String Email) {

    _email = Email;
  }
  int get_id() {
    return _id;
  }
  String get_name() {
    return _name;
  }
  String get_email() {
    return _email;
  }
}
