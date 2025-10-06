package com.example.du_an.util;


import com.example.du_an.service.ReminderService;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.Timer;
import java.util.TimerTask;

@WebListener
public class SchedulerListener implements ServletContextListener {
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🔔 SchedulerListener started...");
        timer = new Timer(true);
        ReminderService service = new ReminderService();

        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                System.out.println("⏰ Running reminder job...");
                service.sendDueDateReminders();
            }
        }, 0, 60*1000); // mỗi 24h
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) timer.cancel();
        System.out.println("🛑 SchedulerListener stopped.");
    }
}
