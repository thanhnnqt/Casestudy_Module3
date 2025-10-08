<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 10/7/2025
  Time: 6:06 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cập nhật khách hàng</title>
    <c:import url="/views/layout/library.jsp"/>
    <!-- Thêm Bootstrap Icons (nếu chưa có trong library.jsp) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .update-form {
            max-width: 500px;
            margin: 50px auto;
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            cursor: pointer;
            color: #6c757d;
        }

        .toggle-password:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>
<div class="container update-form">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <html>
    <head>
        <title>Cập nhật khách hàng</title>
        <c:import url="/views/layout/library.jsp"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
            }

            .update-form {
                max-width: 500px;
                margin: 50px auto;
            }

            .password-wrapper {
                position: relative;
            }

            .toggle-password {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                border: none;
                background: transparent;
                cursor: pointer;
                color: #6c757d;
            }

            .toggle-password:hover {
                color: #0d6efd;
            }
        </style>
    </head>
    <body>
    <div class="container update-form">

        <%
            String toastMessage = (String) session.getAttribute("toastMessage");
            String toastType = (String) session.getAttribute("toastType");
            session.removeAttribute("toastMessage");
            session.removeAttribute("toastType");
        %>

        <% if (toastMessage != null) { %>
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1055;">
            <div id="liveToast" class="toast text-bg-<%= toastType != null ? toastType : "primary" %> border-0"
                 role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body"><%= toastMessage %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                            aria-label="Đóng"></button>
                </div>
            </div>
        </div>
        <% } %>


        <div class="card shadow-sm border-0">
            <div class="card-body">
                <h4 class="card-title text-center mb-4">Cập nhật thông tin của bạn</h4>

                <form action="/update" method="post">
                    <input type="hidden" name="customerId" value="${customer.customerId}">
                    <input type="hidden" name="accountId" value="${customer.accountId}">
                    <input type="hidden" name="role" value="${account.role}">
                    <input type="hidden" name="username" value="${account.username}">

                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" name="fullName" class="form-control" value="${customer.fullName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số CCCD</label>
                        <input type="text" name="citizenNumber" class="form-control" value="${customer.citizenNumber}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" name="phoneNumber" class="form-control" value="${customer.phoneNumber}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" name="address" class="form-control" value="${customer.address}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="${customer.email}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ngày sinh</label>
                        <input id="input-dob" type="date" name="dob" class="form-control" value="${customer.dob}">
                        <label class="text-danger" id="validateAge">
                            <c:if test="${not empty errorMessageAge}">
                                <c:out value="${errorMessageAge}"/>
                            </c:if>
                        </label>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <div class="password-wrapper">
                            <input id="password" type="password" name="password" class="form-control"
                                   value="${account.passwordHash}" required>
                            <button type="button" class="toggle-password" id="togglePwd" aria-label="Hiện mật khẩu">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>

                        <label class="text-danger" id="validateLable">
                            <c:if test="${not empty errorMessage}">
                                <c:out value="${errorMessage}"/>
                            </c:if>
                        </label>

                    </div>

                    <div class="d-grid">
                        <button class="btn btn-primary">Lưu thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script>
        const togglePwd = document.getElementById('togglePwd');
        const pwdInput = document.getElementById('password');
        const icon = togglePwd.querySelector('i');

        togglePwd.addEventListener('click', () => {
            const show = pwdInput.type === 'password';
            pwdInput.type = show ? 'text' : 'password';
            icon.classList.toggle('bi-eye');
            icon.classList.toggle('bi-eye-slash');
            togglePwd.setAttribute('aria-label', show ? 'Ẩn mật khẩu' : 'Hiện mật khẩu');
        });

        const passwordInput = document.querySelector("#password");
        const validateLable = document.querySelector("#validateLable");
        passwordInput.addEventListener("input", function (e) {
            validateLable.classList.add("d-none");
        });

        document.querySelector("#input-dob").addEventListener("input", function () {
            document.querySelector("#validateAge").classList.add("d-none");
        })
    </script>
    </body>
    </html>
