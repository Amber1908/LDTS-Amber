using System;

namespace LDTS.Models
{
    public class AlertSetting
    {
        public int ALID { get; set; }
        /// <summary>
        /// 提醒文字
        /// </summary>
        public string ALTitle { get; set; }
        /// <summary>
        /// 提醒類型 1:Year 2:Season 3:Month 4:Week
        /// </summary>
        public int ALType { get; set; }
        /// <summary>
        /// 提醒條件
        /// </summary>
        public string ALFactor { get; set; }
        /// <summary>
        /// 關聯表單
        /// </summary>
        public string ALForm { get; set; }
        /// <summary>
        /// 啟用狀態 1:啟用 2:停用
        /// </summary>
        public int Status { get; set; }
        /// <summary>
        /// 建立時間
        /// </summary>
        public DateTime CreateDate { get; set; }
        /// <summary>
        /// 建立者
        /// </summary>
        public string CreateMan { get; set; }
    }
}