package com.xiaofei.common.product.constant;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 14:14
 */
public class ProductConstant {

    /**
     * 商品状态码
     */
    public enum StatusEnum {
        NEW_SPU(0, "新建"),
        NEW_UP(1, "商品上架"),
        NEW_DOWN(2, "商品下架");

        private int code;
        private String msg;

        StatusEnum(int code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        public int getCode() {
            return code;
        }

        public void setCode(int code) {
            this.code = code;
        }

        public String getMsg() {
            return msg;
        }

        public void setMsg(String msg) {
            this.msg = msg;
        }
    }

    /**
     * 属性状态，基本属性和销售属性
     */
    public enum AttrEnum {
        ATTR_TYPE_BASE(1, "基本属性"),
        ATTR_TYPE_SALE(0, "销售属性");

        private int code;
        private String msg;

        AttrEnum(int code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }
}
