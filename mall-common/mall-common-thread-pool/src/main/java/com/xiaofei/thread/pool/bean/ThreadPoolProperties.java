package com.xiaofei.thread.pool.bean;

import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.concurrent.*;

/**
 * User: 李飞
 * Date: 2021/12/24
 * Time: 11:40
 */
@ConfigurationProperties("thread.pool")
public class ThreadPoolProperties {
    //核心线程数（一直存在，除非调用allowCoreThreadTimeOut）；线程池创建好以后就准备就绪的线程数量，就等待来接收异步任务去执行
    private Integer corePoolSize = 20;

    //最大线程数量；控制资源，【如果指定为200，就算提交了100000个异步任务，也只能一次执行200个异步任务】
    private Integer maximumPoolSize = 200;

    //线程存活时间。释放空闲的线程（maximumPoolSize-corePoolSize），只要线程的空闲时间大于指定的线程存活时间，就释放线程。但是不会释放corePoolSize中的线程
    private Long keepAliveTime = 10L;

    //用于指定keepAliveTime的时间单位
    private TimeUnit unit = TimeUnit.SECONDS;

    //阻塞队列，如果一次性任务有很多，就回家那个目前多的任务放在队列里面，只要有空闲的线程了，就会从队列中取出新的任务继续执行
    private BlockingQueue<Runnable> workQueue = new LinkedBlockingDeque<>(100000);

    //线程的创建工厂
    private ThreadFactory threadFactory = Executors.defaultThreadFactory();

    //处理策略。如果队列满了，按照我们指定的拒绝策略执行任务
    private RejectedExecutionHandler handler = new ThreadPoolExecutor.AbortPolicy();

    public Integer getCorePoolSize() {
        return corePoolSize;
    }

    public void setCorePoolSize(Integer corePoolSize) {
        this.corePoolSize = corePoolSize;
    }

    public Integer getMaximumPoolSize() {
        return maximumPoolSize;
    }

    public void setMaximumPoolSize(Integer maximumPoolSize) {
        this.maximumPoolSize = maximumPoolSize;
    }

    public Long getKeepAliveTime() {
        return keepAliveTime;
    }

    public void setKeepAliveTime(Long keepAliveTime) {
        this.keepAliveTime = keepAliveTime;
    }

    public TimeUnit getUnit() {
        return unit;
    }

    public void setUnit(TimeUnit unit) {
        this.unit = unit;
    }

    public BlockingQueue<Runnable> getWorkQueue() {
        return workQueue;
    }

    public void setWorkQueue(BlockingQueue<Runnable> workQueue) {
        this.workQueue = workQueue;
    }

    public ThreadFactory getThreadFactory() {
        return threadFactory;
    }

    public void setThreadFactory(ThreadFactory threadFactory) {
        this.threadFactory = threadFactory;
    }

    public RejectedExecutionHandler getHandler() {
        return handler;
    }

    public void setHandler(RejectedExecutionHandler handler) {
        this.handler = handler;
    }
}
