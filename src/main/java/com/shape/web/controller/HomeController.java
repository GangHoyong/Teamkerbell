package com.shape.web.controller;

import com.shape.web.VO.MeetingMember;
import com.shape.web.VO.MemberGraph;
import com.shape.web.entity.*;
import com.shape.web.repository.*;
import com.shape.web.service.ProjectService;
import com.shape.web.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
    //메뉴 컨트롤러
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    UserRepository userRepository;
    @Autowired
    ProjectRepository projectRepository;
    @Autowired
    AlarmRepository alarmRepository;
    @Autowired
    TodolistRepository todolistRepository;
    @Autowired
    ScheduleRepository scheduleRepository;
    @Autowired
    FileDBRepository fileDBRepository;
    @Autowired
    MinuteRepository minuteRepository;
    @Autowired
    LogRepository logRepository;

    /**
     * Simply selects the home view to render by returning its name.
     */


    @RequestMapping(value = "/", method = RequestMethod.GET)    //시작부
    public ModelAndView Home(Authentication authentication) {
        ModelAndView mv = null;
        if (authentication == null) {
            mv = new ModelAndView("/login");
            mv.addObject("tempUser", new User());
        } else
            mv = new ModelAndView("redirect:/dashboard");
        return mv;
    }

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String goDashboard(Authentication authentication) {

        return "redirect:/dashboard/" + authentication.getName();

    }

    @RequestMapping(value = "/userInfo/{userId}", method = RequestMethod.GET)
    public ModelAndView UserInfo(@PathVariable("userId") String userId) {
        User user = userRepository.findById(userId);    //유저 아이디로 유저레코드 검색
        List<Project> lpj = projectRepository.findByUsers(user); // 프로젝트 리스트를 반환

        ModelAndView mv = new ModelAndView("/userInfo");    //ModelAndView : 컨트롤러의 처리 결과를 보여줄 뷰와 뷰에 전달할 값을 저장
        mv.addObject("user", user);
        mv.addObject("projects", lpj);
        return mv;
    }


    @RequestMapping(value = "/dashboard/{userId}", method = RequestMethod.GET)
    public ModelAndView Dashboard(@PathVariable("userId") String userId, HttpSession session) {

        User user = (User) session.getAttribute("user");
        List<Project> lpj = projectRepository.findByUsers(user); // 프로젝트 리스트를 반환
        List<Alarm> tlla = alarmRepository.findByUserOrderByDateDesc(user, new PageRequest(0, 15)); // 타임라인 리스트를 반환
        List<Todolist> lt = todolistRepository.findByUser(user); // 투두리스트 리스트를 반환
        List<Schedule> ls = scheduleRepository.findByProject_Users(user); // 스케쥴 리스트를 반환
        List<Alarm> la = alarmRepository.findByUserAndContentidAndIsshowOrderByDateDesc(user, 0, true); // 알람 리스트를 반환

        ModelAndView mv = new ModelAndView("/dashboard");
        mv.addObject("user", user);
        mv.addObject("timeline", tlla);
        mv.addObject("alarm", la);
        mv.addObject("projects", lpj);
        mv.addObject("todolist", lt);
        mv.addObject("schedules", ls);
        return mv;
    }

    @RequestMapping(value = "/chat/{projectIdx}", method = RequestMethod.GET)
    public ModelAndView Chat(@PathVariable("projectIdx") Integer projectIdx, HttpSession session) {
        ModelAndView mv = null;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String time = formatter.format(new Date());
        User user = (User) session.getAttribute("user");
        mv = new ModelAndView("redirect:/");
        Project project = projectRepository.findOne(projectIdx); // 프로젝트 객체 반환
        List<Project> lpj = projectRepository.findByUsers(user); // 프로젝트 리스트 반환
        if (!lpj.contains(project)) { // 자기 자신의 프로젝트가 아닐경우
            return mv;
        }
        List<Todolist> lt = todolistRepository.findByProject(project); // 투두리스트 리스트를 반환
        List<Alarm> la = alarmRepository.findByUserAndContentidAndIsshowOrderByDateDesc(user, 0, true); // 알람 리스트를 반환
        List<User> lu = userRepository.findByProjects(project); // 유저 리스트 반환
        //List<FileDB> lfd = fileDBRepository.groupbytest(project); // 파일 받아오기

        if (project.isProcessed()) {
            List<Minute> lm = minuteRepository.findByProject(project); // 회의록 객체 반환
            List<FileDB> img = fileDBRepository.findByProjectAndTypeOrderByCreatedatDesc(project, "img"); // 파일디비 리스트중 이미지 리스트 반환
            project.setMinute(" "); //회의록 초기화
            lm = lm.stream().filter(m -> {
                        if (time.equals(m.getDate().toString())) {
                            project.setMinute(m.getContent());
                            logger.info(m.getContent() + "test");
                            return false;
                        }
                        return true;
                    }
            )
                    .sorted()
                    .collect(Collectors.toList());


            String foldername = FileUtil.getFoldername(projectIdx, null);
            File file = new File(foldername);
            if (!file.exists())
                if (file.mkdirs()) {
                    logger.info("folder created " + file);
                }
            mv = new ModelAndView("/project");
            mv.addObject("projects", lpj);
            mv.addObject("users", lu);
            mv.addObject("user", user);
            mv.addObject("alarm", la);
            mv.addObject("minutes", lm);
            mv.addObject("project", project);
            mv.addObject("img", img);
            mv.addObject("todolist", lt);
        } else { // 위 ProjectRoom, 아래 Documentation
            //ProjectService pjs = new ProjectService();
            /*List<MeetingMember> lm = pjs.getMeetingMember(project); // 멤버 참석현황 반환
            List<MemberGraph> lg = pjs.getMemberGraph(project); // 멤버 참석율 반환
            List<String> username = new ArrayList<>();*/

              /*  List<Integer> participant = new ArrayList<>();
                List<Integer> percentage = new ArrayList<>();
                for (MemberGraph temp : lg) { // 그래프 값 분리
                    username.add("\"" + temp.getName() + "\"");
                    if (temp.getParticipate() != null)
                        participant.add(temp.getParticipate().intValue()); //참가율
                    else
                        participant.add(0);
                    if (temp.getPercentage() != null)
                        percentage.add(temp.getPercentage().intValue()); //달성율
                    else
                        percentage.add(0);
                }*/


            mv.addObject("user", user);
            mv.addObject("projects", lpj);
            mv.addObject("project", project);
            mv.addObject("users", lu);
            mv.addObject("alarm", la);
            mv.addObject("todolist", lt);
            // mv.addObject("meetingmember", lm);
            // mv.addObject("files", lfd);
            //mv.addObject("usersname", username);
            //mv.addObject("participant", participant);
            //mv.addObject("percentage", percentage);
        } // Documentation 끝
        return mv;

    }


    @RequestMapping(value = "/projectmanager", method = RequestMethod.GET)
    public ModelAndView manager(HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Project> lpj = projectRepository.findByUsers(user, new PageRequest(0, 5)); // 프로젝트 리스트 객체 10개 반환
        ModelAndView mv = new ModelAndView("/EditPJ");
        mv.addObject("user", user);
        mv.addObject("projects", lpj);
        return mv;
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public ModelAndView admin(HttpSession session) {
        List<Log> logs = logRepository.findAll();

        ModelAndView mv = new ModelAndView("/admin");
        // mv.addObject("logs",logs);
        return mv;
    }

}
