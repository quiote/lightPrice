class Station {
  //station is a client, it contains a web socket pointing to the server and also contains blocks of displays
  ArrayList<Block> blocks  = new ArrayList<Block>();
  //XML book;
  StringDict book =new StringDict();
  String bookString="";
  Station() {
    instanceSocket();
  }
  void updateBook() {
    stationSocket.sendMessage("giveIt2MeBaby");
    println("Petition sent.");
  }




  //void setBook(XML input) {
  //  book=input;
  //  digestXML(book);
  //}



  //XML getBook() {
  //  return book;
  //}

  void setBook(XML input) {
    XML[] values = input.getChildren("value");//the book contains values; these are saved as an xml object array

    for (int i = 0; i < values.length; i++) {
      //every value has a type and a figure
      XML typeObj=values[i].getChild("type");//this xml object has the interesting content
      XML figureObj=values[i].getChild("figure");//this xml object has the interesting content

      String type=typeObj.getContent();
      String figure=figureObj.getContent();
      println("XML current type: "+type+" . Value: "+figure);
      s0.book.set(type, figure);
      println("Dictionary: "+s0.book.get(type));
    }
  }

  void updateBlocks() {
    for (int i=0; i<blocks.size(); i++) {
      //i is the blocks index
      for (int j=0; j<blocks.get(i).displays.size(); j++) {
        //j is the displays index
        String currType=blocks.get(i).displays.get(j).getType();
        println("Block "+i+" display "+j+" has type "+currType);
      }
    }
  }

  void createStation() {
    XML configFile;
    //station = loadXML("stationConfig00.xml");
    configFile = loadXML("stationConfig01.xml");

    XML[] blocks = configFile.getChildren("block");
    //println("Total blocks in station:  "+blocks.length);

    //s0=new Station();
    println("Station Instancing START");

    for (int i=0; i<blocks.length; i++) {

      XML[] displays = blocks[i].getChildren("display");
      //println("Block "+i+ "  has  "+displays.length+"  displays.");

      s0.blocks.add(new Block(i, 0));
      //println("Station has"+s0.blocks.size()+"blocks.");
      for (int j=0; j<displays.length; j++) {
        XML pos = displays[j].getChild("position");
        XML typ = displays[j].getChild("type");
        //println(pos.getContent());
        String temPos=pos.getContent();
        String temTyp=typ.getContent();
        s0.blocks.get(i).displays.add(new Display(int(temPos), temTyp));
        //println("Display "+j+" has position "+int(temPos)+" and type "+typ.getContent());
      }
    }
    //println();

    println("Station Instancing END -----");
    println(  s0.blocks.get(0).displays.get(2).getType());//this is a test! Objects are real!!! (obviously, inside array limits)
    //  println();
  }

  void setDictionary() {
    book.set("A", "11.11");
    book.set("B", "33.33");
  }
}
