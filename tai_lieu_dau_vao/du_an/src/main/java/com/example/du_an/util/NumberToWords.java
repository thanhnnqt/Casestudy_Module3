package com.example.du_an.util;

import java.math.BigDecimal;

public class NumberToWords {
    private static final String[] CHU_SO =
            {"không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"};
    private static final String[] DON_VI =
            {"", "nghìn", "triệu", "tỷ"};

    public static String convert(BigDecimal number) {
        if (number == null) return "";
        long n = number.longValue();
        if (n == 0) return "Không đồng";

        String s = "";
        int unitIndex = 0;

        while (n > 0) {
            int chunk = (int) (n % 1000);
            if (chunk != 0) {
                String chunkText = readThreeDigits(chunk);
                if (!s.isEmpty()) {
                    s = chunkText + " " + DON_VI[unitIndex] + " " + s;
                } else {
                    s = chunkText + " " + DON_VI[unitIndex];
                }
            }
            n /= 1000;
            unitIndex++;
        }

        s = s.trim();
        s = Character.toUpperCase(s.charAt(0)) + s.substring(1) + " đồng";
        return s;
    }

    private static String readThreeDigits(int number) {
        int hundreds = number / 100;
        int tens = (number % 100) / 10;
        int units = number % 10;

        String result = "";
        if (hundreds > 0) {
            result += CHU_SO[hundreds] + " trăm";
        } else if (tens > 0 || units > 0) {
            result += "không trăm";
        }

        if (tens > 1) {
            result += " " + CHU_SO[tens] + " mươi";
            if (units == 1) result += " mốt";
            else if (units == 5) result += " lăm";
            else if (units > 0) result += " " + CHU_SO[units];
        } else if (tens == 1) {
            result += " mười";
            if (units == 1) result += " một";
            else if (units == 5) result += " lăm";
            else if (units > 0) result += " " + CHU_SO[units];
        } else if (tens == 0 && units > 0) {
            if (!result.isEmpty()) result += " linh";
            if (units == 5) result += " năm";
            else result += " " + CHU_SO[units];
        }

        return result.trim();
    }
}
