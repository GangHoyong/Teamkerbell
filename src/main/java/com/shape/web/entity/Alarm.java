package com.shape.web.entity;

import org.hibernate.annotations.Type;

import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "Alarm")
public class Alarm {

    @Id
    @GeneratedValue
    @Column(name = "ALARMIDX")
    private Integer alarmidx;


    @Column(name="CONTENTID")
    private Integer contentid;

    @Column(name = "FILENAME")
    private String filename;

    @Column(name = "FILEURL")
    private String fileurl;

    @Column(name = "DATE")
    private Date date;

    @Column(name = "ISSHOW")
    private boolean isshow=true ;

    @ManyToOne
    @JoinColumn(name = "PROJECTIDX")
    private Project project;

    @ManyToOne
    @JoinColumn(name = "USERIDX")
    private User user;

    @ManyToOne
    @JoinColumn(name = "ACTORIDX")
    private User actor;


    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {

        this.project = project;
    }

    public User getActor() {
        return actor;
    }

    public void setActor(User actor) {
        this.actor = actor;
    }

    public Integer getAlarmidx() {
        return alarmidx;
    }

    public void setAlarmidx(Integer alarmidx) {
        this.alarmidx = alarmidx;
    }

    public Integer getContentid() {
        return contentid;
    }

    public void setContentid(Integer contentid) {
        this.contentid = contentid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
         this.user = user;
    }

    public String getFileurl() {
        return fileurl;
    }

    public void setFileurl(String fileurl) {
        this.fileurl = fileurl;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isshow() {
        return isshow;
    }

    public void setIsshow(boolean isshow) {
        this.isshow = isshow;
    }

    public Alarm(Integer contentid, String filename, String fileurl, Date date) {
        this.contentid = contentid;
        this.filename = filename;
        this.fileurl = fileurl;
        this.date = date;
    }

    public Alarm() {
    }


}
