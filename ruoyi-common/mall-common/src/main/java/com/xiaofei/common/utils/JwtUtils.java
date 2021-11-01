package com.xiaofei.common.utils;

import io.jsonwebtoken.*;
import org.apache.commons.lang3.StringUtils;

/**
 * JWT生成工具
 */
public class JwtUtils {

    //过期时间
    private static final long tokenExpiration = 24 * 60 * 60 * 1000;

    //签名秘钥，可以随便设置，用于防伪作用
    private static final String tokenSignKey = "9ie#yjOv9RdIh3Lz";

    /**
     * 生成已一个token
     * @param userId 用户id
     * @param username 用户名
     * @return 返回保存了用户信息的token
     */
    public static String createToken(Long userId, String username) {
        return Jwts.builder()

                .setHeaderParam("type","JWT")

                .setSubject("XIAOFEI-MALL-USER-LOGIN")//token的名称，随便填写

                //设置过期时间，这里不在生成的时候设置过期时间了，直接使用redis设置过期时间
                //.setExpiration(new Date(System.currentTimeMillis() + tokenExpiration))

                .claim("userId", userId)
                .claim("userName", username)

                .signWith(SignatureAlgorithm.HS512, tokenSignKey)//设置签名哈希

                .compressWith(CompressionCodecs.GZIP)

                .compact();
    }

    //根据token字符串得到用户id
    public static Long getUserId(String token) {
        if (StringUtils.isEmpty(token)) {
            return null;
        }

        Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
        Claims claims = claimsJws.getBody();
        Integer userId = (Integer) claims.get("userId");
        return userId.longValue();
    }

    //根据token字符串得到用户名称
    public static String getUserName(String token) {
        if (org.apache.commons.lang3.StringUtils.isEmpty(token)) {
            return "";
        }

        Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
        Claims claims = claimsJws.getBody();
        return (String) claims.get("userName");
    }

    public static void main(String[] args) {
        String token = JwtUtils.createToken(999L, "小飞");
        System.out.println("Bearer eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIiLCJ6aXAiOiJHWklQIn0.H4sIAAAAAAAAAKtWKi5NUrJSivB09Hdz9dT1dfTx0Q0Ndg3S9fF39_RT0lEqLU4t8kxRsjKCMP0Sc1OB6g0tDYwNzC1MjE2UagHqOCYXRAAAAA.Ujfc4_KqohwIV5yiIla1t72gLg5rtA3JCBkpdDckFxGzbo81ytjqlqdlQu1Bb5ZprQyKqwuSerPaJ-8U3Qr_rA");
        System.out.println(JwtUtils.getUserId("Bearer eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIiLCJ6aXAiOiJHWklQIn0.H4sIAAAAAAAAAKtWKi5NUrJSivB09Hdz9dT1dfTx0Q0Ndg3S9fF39_RT0lEqLU4t8kxRsjKCMP0Sc1OB6g0tDYwNzC1MjE2UagHqOCYXRAAAAA.Ujfc4_KqohwIV5yiIla1t72gLg5rtA3JCBkpdDckFxGzbo81ytjqlqdlQu1Bb5ZprQyKqwuSerPaJ-8U3Qr_rA"));
        System.out.println(JwtUtils.getUserName("Bearer eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIiLCJ6aXAiOiJHWklQIn0.H4sIAAAAAAAAAKtWKi5NUrJSivB09Hdz9dT1dfTx0Q0Ndg3S9fF39_RT0lEqLU4t8kxRsjKCMP0Sc1OB6g0tDYwNzC1MjE2UagHqOCYXRAAAAA.Ujfc4_KqohwIV5yiIla1t72gLg5rtA3JCBkpdDckFxGzbo81ytjqlqdlQu1Bb5ZprQyKqwuSerPaJ-8U3Qr_rA"));
    }
}

