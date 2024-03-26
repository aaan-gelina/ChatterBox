<%!
public class Message{
    private int userId;
    private String content;

    public Message(int userId, String content){
        this.userId = userId;
        this.content = content;
    }

    public int getUserId(){
        return this.userId;
    }

    public String getContent(){
        return this.content;
    }

    public void setUserId(int userId){
        this.userId = userId;
    }

    public void setContent(String content){
        this.content = content;
    }
} %>