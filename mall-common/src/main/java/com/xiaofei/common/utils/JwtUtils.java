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

    //根据参数生成token
    public static String createToken(Long userId, String userName) {
        return Jwts.builder()
                .setSubject("YYGH-USER")
                //设置过期时间，这里不在生成的时候设置过期时间了，直接使用redis设置过期时间
                //.setExpiration(new Date(System.currentTimeMillis() + tokenExpiration))
                .claim("userId", userId)
                .claim("userName", userName)
                .signWith(SignatureAlgorithm.HS512, tokenSignKey)
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
        String token = JwtUtils.createToken(1L, "lucy");
        System.out.println(token);
        System.out.println(JwtUtils.getUserId(token));
        System.out.println(JwtUtils.getUserName(token));
    }
}

