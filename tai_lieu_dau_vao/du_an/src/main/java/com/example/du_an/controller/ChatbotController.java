package com.example.du_an.controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import okhttp3.*;

@WebServlet("/chatbot")
public class ChatbotController extends HttpServlet {

    private static final String API_KEY = "sk-proj-HYMbA_aSEGfMJNqMJQl-1mnhXyiSD0Yr6z3pLZaYwvRc898C1HXCbXa9cQrql" +
            "cBfn6HSFQXhlxT3BlbkFJ1LPHkc-27dJ1pZ6M8LXqlf8K42MLRKgZvEwkfHX-TrKndm9prpfA3XEhaUpTtKmXxlgLSv2bYA";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        BufferedReader reader = req.getReader();
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) json.append(line);

        JSONObject input = new JSONObject(json.toString());
        String userMessage = input.getString("message");

        // Gọi OpenAI API
        OkHttpClient client = new OkHttpClient();
        MediaType mediaType = MediaType.parse("application/json");
        String payload = "{ \"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\":\"user\",\"content\":\"" + userMessage + "\"}] }";

        Request request = new Request.Builder()
                .url("https://api.openai.com/v1/chat/completions")
                .post(RequestBody.create(payload, mediaType))
                .addHeader("Content-Type", "application/json")
                .addHeader("Authorization", "Bearer " + API_KEY)
                .build();

        Response response = client.newCall(request).execute();
        String result = response.body().string();

        JSONObject jsonResponse = new JSONObject(result);
        String reply = jsonResponse.getJSONArray("choices")
                .getJSONObject(0)
                .getJSONObject("message")
                .getString("content");

        resp.setContentType("application/json");
        resp.getWriter().write(new JSONObject().put("reply", reply).toString());
    }
}
