package com.xiaofei.es.constant;


import org.elasticsearch.search.sort.SortOrder;
import org.springframework.data.domain.Sort;

/**
 * mall-elasticsearch模块所需常量
 * User: 李飞
 * Date: 2021/8/11
 * Time: 0:19
 */
public class EsSearchConstant {

    /**
     * NativeSearchQueryBuilder的商品排序状态
     */
    public enum SortStatus {

        NORMAL_SORT(0, "skuId", "正常排序", SortOrder.ASC),
        PRICE_ASC(1, "skuPrice", "价格升序", SortOrder.ASC),
        PRICE_DESC(-1, "skuPrice", "价格降序", SortOrder.DESC),
        SALES_ASC(2, "saleCount", "销量升序", SortOrder.ASC),
        SALES_DESC(-2, "saleCount", "销量降序", SortOrder.DESC),
        COMMENT_ASC(3, "commentNum", "评论升序", SortOrder.ASC),
        COMMENT_DESC(-3, "commentNum", "评论降序", SortOrder.DESC),
        PUT_ON_ASC(4, "addTime", "上架时间升序", SortOrder.ASC),
        PUT_ON_DESC(-4, "addTime", "上架时间降序", SortOrder.DESC);

        /**
         * 判断传入的状态是什么，返回什么类型的枚举类
         */
        public static SortStatus getSortStatus(int status) {
            if (status == 1) {
                return PRICE_ASC;
            } else if (status == -1) {
                return PRICE_DESC;
            } else if (status == 2) {
                return SALES_ASC;
            } else if (status == -2) {
                return SALES_DESC;
            } else if (status == 3) {
                return COMMENT_ASC;
            } else if (status == -3) {
                return COMMENT_DESC;
            } else if (status == 4) {
                return PUT_ON_ASC;
            } else if (status == -4) {
                return PUT_ON_DESC;
            } else {
                return NORMAL_SORT;
            }
        }

        private final int status;
        private final String field;
        private final String msg;
        private final SortOrder sortOrder;

        SortStatus(int status, String field, String msg, SortOrder sortOrder) {
            this.status = status;
            this.field = field;
            this.msg = msg;
            this.sortOrder = sortOrder;
        }

        public SortOrder getSortOrder() {
            return sortOrder;
        }

        public String getField() {
            return field;
        }

        public int getStatus() {
            return status;
        }

        public String getMsg() {
            return msg;
        }
    }

    /**
     * criteriaQuery排序
     */
    public enum CriteriaSortStatus {
        NORMAL_SORT(0, "skuId", "正常排序", Sort.Direction.ASC),
        PRICE_ASC(1, "skuPrice", "价格升序", Sort.Direction.ASC),
        PRICE_DESC(-1, "skuPrice", "价格降序", Sort.Direction.DESC),
        SALES_ASC(2, "saleCount", "销量升序", Sort.Direction.ASC),
        SALES_DESC(-2, "saleCount", "销量降序", Sort.Direction.DESC),
        COMMENT_ASC(3, "commentNum", "评论升序", Sort.Direction.ASC),
        COMMENT_DESC(-3, "commentNum", "评论降序", Sort.Direction.DESC),
        PUT_ON_ASC(4, "addTime", "上架时间升序", Sort.Direction.ASC),
        PUT_ON_DESC(-4, "addTime", "上架时间降序", Sort.Direction.DESC);

        /**
         * 判断传入的状态是什么，返回什么类型的枚举类
         */
        public static CriteriaSortStatus getSortStatus(int status) {
            if (status == 1) {
                return PRICE_ASC;
            } else if (status == -1) {
                return PRICE_DESC;
            } else if (status == 2) {
                return SALES_ASC;
            } else if (status == -2) {
                return SALES_DESC;
            } else if (status == 3) {
                return COMMENT_ASC;
            } else if (status == -3) {
                return COMMENT_DESC;
            } else if (status == 4) {
                return PUT_ON_ASC;
            } else if (status == -4) {
                return PUT_ON_DESC;
            } else {
                return NORMAL_SORT;
            }
        }

        private final int status;
        private final String field;
        private final String msg;
        private final Sort.Direction sortOrder;

        CriteriaSortStatus(int status, String field, String msg, Sort.Direction sortOrder) {
            this.status = status;
            this.field = field;
            this.msg = msg;
            this.sortOrder = sortOrder;
        }

        public Sort.Direction getSortOrder() {
            return sortOrder;
        }

        public String getField() {
            return field;
        }

        public int getStatus() {
            return status;
        }

        public String getMsg() {
            return msg;
        }
    }
}
