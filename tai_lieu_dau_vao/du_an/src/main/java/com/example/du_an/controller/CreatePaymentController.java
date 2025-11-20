package com.example.du_an.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "PaymentController", urlPatterns = {"/create_payment"})
public class CreatePaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());

        // 1) Nhận số tiền từ form (VND), VNPAY yêu cầu nhân 100
        String amountParam = request.getParameter("amount");
        long amountVnd = 0;
        try {
            amountVnd = Long.parseLong(amountParam);
        } catch (Exception ignored) {}
        if (amountVnd <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền không hợp lệ");
            return;
        }
        String vnp_Amount = String.valueOf(amountVnd * 100);

        // 2) Các tham số bắt buộc
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_TmnCode = VNPConfig.vnp_TmnCode;
        String vnp_ReturnUrl = VNPConfig.vnp_ReturnUrl;
        String vnp_TxnRef = generateTxnRef(); // duy nhất cho mỗi giao dịch
        String vnp_OrderInfo = "Thanh toan don hang " + vnp_TxnRef;
        String vnp_OrderType = "other";
        String vnp_Locale = "vn";
        String vnp_IpAddr = getClientIpAddr(request);
        String vnp_CurrCode = "VND";

        // 3) Ngày tạo và hết hạn
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());

        // 4) Build parameter map
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", vnp_Amount);
        vnp_Params.put("vnp_CurrCode", vnp_CurrCode);
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", vnp_OrderType);
        vnp_Params.put("vnp_Locale", vnp_Locale);
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        // Optional: vnp_BankCode
        // vnp_Params.put("vnp_BankCode", "NCB");

        // 5) Sắp xếp, encode và tạo chuỗi ký
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        try {
            for (int i = 0; i < fieldNames.size(); i++) {
                String fieldName = fieldNames.get(i);
                String fieldValue = vnp_Params.get(fieldName);
                if (fieldValue != null && fieldValue.length() > 0) {
                    // encode value theo UTF-8
                    String encodedName = URLEncoder.encode(fieldName, StandardCharsets.UTF_8);
                    String encodedValue = URLEncoder.encode(fieldValue, StandardCharsets.UTF_8);

                    // hashData dùng giá trị đã URL-encode
                    hashData.append(encodedName).append('=').append(encodedValue);
                    query.append(encodedName).append('=').append(encodedValue);

                    if (i < fieldNames.size() - 1) {
                        hashData.append('&');
                        query.append('&');
                    }
                }
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi build tham số");
            return;
        }

        // 6) Ký HMAC SHA512
        String secureHash = hmacSHA512(VNPConfig.vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        String paymentUrl = VNPConfig.vnp_PayUrl + "?" + query;

        // TODO: Lưu tạm thông tin đơn/txnRef vào DB của bạn trước khi redirect (nếu cần)

        // 7) Redirect sang VNPAY
        response.sendRedirect(paymentUrl);
    }

    private static String generateTxnRef() {
        // Đảm bảo duy nhất (có thể kết hợp DB id + timestamp)
        return String.valueOf(System.currentTimeMillis());
    }

    private static String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // Trường hợp nhiều IP qua proxy
            int idx = ip.indexOf(',');
            return idx != -1 ? ip.substring(0, idx).trim() : ip.trim();
        }
        ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    private static String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hash = new StringBuilder();
            for (byte b : bytes) {
                hash.append(String.format("%02x", b));
            }
            return hash.toString();
        } catch (Exception e) {
            return "";
        }
    }
}