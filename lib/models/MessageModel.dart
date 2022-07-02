class MessageModel
{
  String? text;
  String? dateTime;
  String? receiverId;
  String? senderId;


  MessageModel({
    this.text,
    this.dateTime,
    this.receiverId,
    this.senderId,
  });

  MessageModel.fromJson(Map<String,dynamic>?json)
  {
    text = json?['text'];
    dateTime = json?['dateTime'];
    receiverId = json?['receiverId'];
    senderId = json?['senderId'];
  }

  Map<String,dynamic>toMap()
  {
    return
      {
        'text' : text,
        'dateTime' : dateTime,
        'receiverId' : receiverId,
        'senderId' : senderId,
      };
  }

}