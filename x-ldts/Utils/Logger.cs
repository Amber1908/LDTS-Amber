using System;
using System.IO;
using System.Text;
using System.Threading;
using System.Web.Configuration;

namespace LDTS.Utils
{
    internal class Logger
    {
        #region 參數

        private struct Level
        {
            public const int FATAL = 1;
            public const int ERROR = 2;
            public const int WARN = 3;
            public const int INFO = 4;
            public const int DEBUG = 5;
        }

        private int level = 5;
        private string logpath = WebConfigurationManager.AppSettings["LOG_PATH"];
        private string logfile = @"C:\Logs\LDTS.log";
        private Encoding encoding = Encoding.GetEncoding("utf-8");
        private string CSName = "";
        private static Object thisLock;

        #endregion

        // 初始化
        public Logger(string ClassName = "")
        {
            switch (WebConfigurationManager.AppSettings["LOG_LEVEL"].ToUpper())
            {
                case "FATAL":
                    level = 1;
                    break;
                case "ERROR":
                    level = 2;
                    break;
                case "WARN":
                    level = 3;
                    break;
                case "INFO":
                    level = 4;
                    break;
                case "DEBUG":
                    level = 5;
                    break;
                default:
                    level = Level.DEBUG;
                    break;
            }

            logfile = string.Format("{0}\\iDoctorTools_{1:yyyyMMdd}.log", logpath, DateTime.Now);

            if (!Directory.Exists(logpath))
                Directory.CreateDirectory(logpath);

            thisLock = new Object();
            this.CSName = ClassName;
        }

        public void FATAL(string output)
        {
            if (Level.FATAL <= level)
            {
                lock (thisLock)
                {
                    File.AppendAllText(logfile, string.Format("{0:yyyy/MM/dd HH:mm:ss.fff} [Thread-{1}] [{2}] [FATAL]\r\n{3}\r\n\r\n", DateTime.Now, Thread.CurrentThread.ManagedThreadId, CSName, output), encoding);
                }
            }
        }

        public void ERROR(string output)
        {
            if (Level.ERROR <= level)
            {
                lock (thisLock)
                {
                    File.AppendAllText(logfile, string.Format("{0:yyyy/MM/dd HH:mm:ss.fff} [Thread-{1}] [{2}] [ERROR]\r\n{3}\r\n\r\n", DateTime.Now, Thread.CurrentThread.ManagedThreadId, CSName, output), encoding);
                }
            }
        }

        public void WARN(string output)
        {
            if (Level.WARN <= level)
            {
                lock (thisLock)
                {
                    File.AppendAllText(logfile, string.Format("{0:yyyy/MM/dd HH:mm:ss.fff} [Thread-{1}] [{2}] [WARN]\r\n{3}\r\n\r\n", DateTime.Now, Thread.CurrentThread.ManagedThreadId, CSName, output), encoding);
                }
            }
        }

        public void INFO(string output)
        {
            if (Level.INFO <= level)
            {
                lock (thisLock)
                {
                    File.AppendAllText(logfile, string.Format("{0:yyyy/MM/dd HH:mm:ss.fff} [Thread-{1}] [{2}] [INFO]\r\n{3}\r\n\r\n", DateTime.Now, Thread.CurrentThread.ManagedThreadId, CSName, output), encoding);
                }
            }
        }

        public void DEBUG(string output)
        {
            if (Level.DEBUG <= level)
            {
                lock (thisLock)
                {
                    File.AppendAllText(logfile, string.Format("{0:yyyy/MM/dd HH:mm:ss.fff} [Thread-{1}] [{2}] [DEBUG]\r\n{3}\r\n\r\n", DateTime.Now, Thread.CurrentThread.ManagedThreadId.ToString(), CSName, output), encoding);
                }
            }
        }
    }
}