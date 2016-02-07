package com.shape.web.VO;

import java.util.Date;

/**
 * Created by seongahjo on 2016. 2. 7..
 */
public class MeetingMember {
    private Date date;
    private String participant;
    private String nonparticipant;
    private String place;
    private String content;

    public MeetingMember(Date date, String participant, String nonparticipant, String place, String content) {
        this.date = date;
        this.participant = participant;
        this.nonparticipant = nonparticipant;
        this.place = place;
        this.content = content;
    }
}
