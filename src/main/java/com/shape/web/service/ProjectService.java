package com.shape.web.service;

import com.shape.web.VO.MeetingMember;
import com.shape.web.entity.*;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class ProjectService {
    @Resource
    private SessionFactory sessionFactory;

    public Project add(String name, int leaderidx, String minutes) {
        Project project = new Project(name, leaderidx, minutes);
        Session session = sessionFactory.openSession();
        session.save(project);
        session.flush();
        session.close();
        return project;
    }

    public Project get(Integer id) {
        Session session = sessionFactory.openSession();
        Project pj = (Project) session.get(Project.class, id);
        session.close();
        return pj;
    }

    public Project save(Project project) {
        Session session = sessionFactory.openSession();
        session.merge(project);
        session.flush();
        session.close();
        return project;
    }

    public List<Minute> getMinutes(Project project) {
        Session session = sessionFactory.openSession();
        List<Minute> lm = session.createCriteria(Minute.class)
                .createAlias("project", "project")
                .add(Restrictions.eq("project.projectidx", project.getProjectidx()))
                .add(Restrictions.ne("date",new Date()))
                .addOrder(Order.desc("date"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
        session.close();
        return lm;
    }

    public List<Schedule> getSchedules(Integer projectIdx) {
        Session session = sessionFactory.openSession();
        List<Schedule> ls = session.createCriteria(Schedule.class)
                .createAlias("project", "project")
                //.add(Restrictions.ge("enddate",new Date()))
                .add(Restrictions.eq("project.projectidx", projectIdx))
                .addOrder(Order.asc("state"))
                .addOrder(Order.asc("startdate"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
        session.close();
        return ls;
    }
    public List<Todolist> getTodolists(Integer projectIdx){
        Session session = sessionFactory.openSession();
        List<Todolist> lt = session.createCriteria(Todolist.class)
                .createAlias("project", "project")
                .add(Restrictions.eq("project.projectidx", projectIdx))
                .addOrder(Order.asc("todolistidx"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
        session.close();
        return lt;
    }
    public List<FileDB> getImgs(Project project) {
        Session session = sessionFactory.openSession();
        List<FileDB> lfd = session.createCriteria(FileDB.class)
                .createAlias("project", "project")
                .add(Restrictions.eq("project.projectidx", project.getProjectidx()))
                .add(Restrictions.eq("type", "img"))
                .addOrder(Order.desc("date"))
                .list();
        session.close();
        return lfd;
    }

    public List<FileDB> getFiles(Project project) {
        Session session = sessionFactory.openSession();
        List<FileDB> lfd = session.createCriteria(FileDB.class)
                .createAlias("project", "project")
                .add(Restrictions.eq("project.projectidx", project.getProjectidx()))
                .addOrder(Order.desc("date"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
        session.close();
        return lfd;
    }

    public List<User> getUsers(Project project) {
        Session session = sessionFactory.openSession();
        List<User> lu = session.createCriteria(User.class)
                .createAlias("projects","projects")
                .add(Restrictions.eq("projects.projectidx",project.getProjectidx()))
                .addOrder(Order.asc("useridx"))
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
                .list();
        session.close();
        return lu;
    }
    public List<MeetingMember> getMeetingMember(Project project){
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("SELECT new com.shape.web.VO.MeetingMember(data.Date as date, data.participants as participant, (SELECT group_Concat(u.name) FROM Schedule s  JOIN Appointment ap on s.SCHEDULEIDX = ap.SCHEDULEIDX RIGHT JOIN User u on ap.USERIDX = u.USERIDX WHERE ap.STATE=2 and s.STATE >=2 and ap.Date=data.DATE Group By ap.date) as nonparticipant, data.place as place, data.content as content) FROM (SELECT ap.DATE Date,group_concat(u.name) as participants,s.PLACE,s.content FROM Schedule s  JOIN Appointment ap on s.SCHEDULEIDX = ap.SCHEDULEIDX RIGHT JOIN User u on ap.USERIDX = u.USERIDX WHERE ap.STATE=3 and s.STATE >=2 Group By ap.DATE,s.SCHEDULEIDX) as data");
        //query.setParameter("useridx", userIdx, StandardBasicTypes.INTEGER);
        List<MeetingMember> members= query.list();
        return members;
    }
    @SuppressWarnings("unchecked")
    public List<Project> getAll() {
        Session session = sessionFactory.openSession();
        List<Project> lp = (List<Project>) session.createCriteria(Project.class).list();
        session.close();
        return lp;
    }

    public void delete(Integer id) {
        Session session = sessionFactory.openSession();
        Project project = (Project)session.get(Project.class,id);
        session.delete(project);
        session.flush();
        session.close();
    }
}
