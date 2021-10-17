import g4p_controls.*;
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import java.awt.*;

SQLite db;
ArrayList<bruger> mineBruger = new ArrayList<bruger>();
String[] nyBrugerText = {"Ny Bruger"};
String[] nyString_2;
GDropList dropList2;
bruger NyBruger = new bruger();

public void setup() {
  size(1000, 500, JAVA2D);
  createGUI();

  mineBruger.add(NyBruger);
  textfield1.setText(NyBruger.get_name());
  textfield2.setText(NyBruger.get_email());
}

void draw() {
}

void updateData(int selectedUser) {
  db = new SQLite( this, "mydatabase.sqlite");

  if (db.connect()) {
    db.query("SELECT ID, Name, Email FROM table_1;");
    while (db.next()) {
      int tempID =db.getInt("ID");
      boolean isInList =false;

      for (int i = 1; i < mineBruger.size(); i++) {
        if (mineBruger.get(i).get_id() ==tempID) {
          isInList = true;
          bruger tempUser = new bruger(tempID, db.getString("Name"), db.getString("Email"));
          mineBruger.set(i, tempUser);
          break;
        }
      }
      if (isInList == false) {
        mineBruger.add(new bruger(tempID, db.getString("Name"), db.getString("Email")));
      }
    }

    nyString_2 = new String[100];
    nyString_2[0] = nyBrugerText[0];

    for (int i= 1; i < mineBruger.size(); i++) {
      nyString_2[i+1] = mineBruger.get(i).get_name();
    }
    dropList1.setItems(nyString_2, selectedUser);
    textfield1.setText(mineBruger.get(selectedUser).get_name());
    textfield2.setText(mineBruger.get(selectedUser).get_email());
  }
}

void newSaveData(int selectedUser) {
  db = new SQLite( this, "mydatabase.sqlite");
  String tempNavn = textfield1.getText();
  String tempEmail = textfield2.getText();
  if (db.connect()) {
    if (selectedUser == 0) {
      db.execute("Insert into Table_1(Name, Email) Values ('"+ tempNavn + "','" + tempEmail + "');");
    } else {
      bruger tempUser = mineBruger.get(selectedUser);
      int brugerID = tempUser.get_id();
      String tempString = "Update table_1 set Name = '" + tempNavn + "', Email = '" + tempEmail + "' Where ID = " + brugerID + ";";

      db.execute(tempString);
    }
  }
  db.close();
}
