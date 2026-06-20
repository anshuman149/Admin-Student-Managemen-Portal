<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

    <div class="main">
        <div class="sidebar">
            <button class="sidebar-item">Student</button>
            <div class="dropdown">
            
<button class="dropdown-item" onclick="location.href='profile.jsp'">Profile</button>
<button class="dropdown-item" onclick="location.href='attendance.jsp'">Attendance</button>
                
                <button class="dropdown-item" onclick="location.href='marks.jsp'">Marks</button>
            </div>
            <button class="sidebar-item">Examination</button>
            <div class="dropdown">
                <button class="dropdown-item"onclick="location.href='hallticket.jsp'">Hall ticket</button>
                <button class="dropdown-item"onclick="location.href='results.jsp'">Results</button>
            </div>
            <button class="sidebar-item">Payment</button>
            <div class="dropdown">
               <button class="dropdown-item" onclick="location.href='payments.jsp'">Payment History</button>

<button class="dropdown-item" onclick="location.href='re-register.jsp'">Make Payment</button>
            </div>
            <button class="sidebar-item"onclick="location.href='certificate.jsp'">My Certificates</button> 
            <button class="sidebar-item" style="background:#c0392b; margin-top:20px;"onclick="location.href='logout.jsp'">Logout</button>
        </div>
    </div>
    <script>
        // Dropdown toggle logic fixed
        document.querySelectorAll('.sidebar-item').forEach(button => {
            button.addEventListener('click', () => {
                const dropdown = button.nextElementSibling;
                if (dropdown && dropdown.classList.contains('dropdown')) {
                    // Toggle display
                    if (dropdown.style.display === 'block') {
                        dropdown.style.display = 'none';
                    } else {
                        dropdown.style.display = 'block';
                    }
                }
            });
        });
    </script>  
</body>
</html>