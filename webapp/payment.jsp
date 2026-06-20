<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Saara Data pichle page se receive karo
    String fName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String enroll = request.getParameter("enrollmentNo");
    String course = request.getParameter("course");
    String addr = request.getParameter("address");
    String pass = request.getParameter("password");
    String selectedAmt = request.getParameter("amount"); // Preview se 'amount' naam se aa raha hai
    String selectedSem = request.getParameter("targetSemester");
    String feeType = request.getParameter("feeType");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Realistic Payment Portal | Student Portal</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .payment-wrapper { max-width: 650px; margin: 30px auto; }
        .payment-tab { background: #4CAF50; color: white; padding: 15px; border-radius: 10px 10px 0 0; text-align: center; font-size: 20px; font-weight: bold; }
        .main-card { background: white; padding: 25px; border-radius: 0 0 10px 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .tc-box { background: #fffde7; border: 1px solid #fff59d; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; }
        .method-container { display: flex; gap: 15px; margin-top: 15px; }
        .method-btn { flex: 1; padding: 12px; border: 2px solid #eee; border-radius: 8px; cursor: pointer; text-align: center; font-weight: bold; transition: 0.3s; }
        .method-btn:hover { border-color: #4CAF50; background: #f1f8e9; }
        .alert-box { display: none; background: #ffebee; color: #c62828; padding: 15px; border-radius: 8px; margin-top: 20px; }
        #qrDisplayArea { display: none; text-align: center; margin-top: 20px; padding: 20px; border: 1px dashed #4CAF50; border-radius: 10px; }
        .qr-frame { width: 200px; height: 200px; margin: 10px auto; border: 5px solid #fff; box-shadow: 0 0 10px #ccc; }
        .btn-confirm { width: 100%; padding: 15px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 18px; font-weight: bold; margin-top: 15px; }
    </style>
</head>
<body> 

<div class="payment-wrapper">
    <div class="payment-tab">💳 Student Payment Portal</div>
    <div class="main-card">
        
        <% if(enroll != null) { %>
            <div style="background: #e3f2fd; padding: 10px; border-radius: 5px; margin-bottom: 15px; color: #1565c0; font-weight: bold;">
                Student: <%= fName %> (<%= enroll %>)
            </div>
        <% } %>

        <div class="tc-box">
            <h4>Shartein aur Niyam (T&C)</h4>
            <ul>
                <li>Kripya payment ke baad screen-shot zaroor lein.</li>
                <li>Manual Verification mein 24 ghante lag sakte hain.</li>
            </ul>
        </div>

        <div class="input-group">
            <label style="font-weight: bold;">Payable Amount (₹):</label>
            <input type="number" id="userAmount" value="<%= (selectedAmt != null) ? selectedAmt : "" %>"  style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 5px; background: #f9f9f9;">
        </div>

        <p style="font-weight: bold; margin-top: 20px;">Choose Method:</p>
        <div class="method-container">
            <div class="method-btn" onclick="showBankError()">Bank Transfer</div>
            <div class="method-btn" onclick="showUPI()">UPI / QR Code</div>
        </div>

        <div id="bankError" class="alert-box">⚠️ Bank Servers Down. Use UPI.</div>

        <div id="qrDisplayArea">
            <p style="color: #2e7d32; font-weight: bold;">Scan & Pay ₹<span id="finalAmt"><%= (selectedAmt != null) ? selectedAmt : "0" %></span></p>
            <img src="${pageContext.request.contextPath}/images/qr-image.jpeg" alt="QR Code" class="qr-frame">
            
            <form action="ConfirmPaymentServlet" method="post" style="text-align: left; margin-top: 20px;">
                <input type="hidden" name="fullName" value="<%= fName %>">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="hidden" name="phone" value="<%= phone %>">
                <input type="hidden" name="enrollmentNo" value="<%= enroll %>">
                <input type="hidden" name="course" value="<%= course %>">
                <input type="hidden" name="address" value="<%= addr %>">
                <input type="hidden" name="password" value="<%= pass %>">
                <input type="hidden" name="amount" value="<%= selectedAmt %>">

                <label style="font-weight: bold;">Transaction ID / UTR Number:</label>
                <input type="text" name="txnID" placeholder="Enter 12-digit UTR" required style="width: 100%; padding: 12px; margin-top: 8px; border: 1px solid #ddd; border-radius: 5px;">

                <button type="submit" class="btn-confirm">✅ Maine Pay kar diya hai</button>
            </form>
        </div>
    </div>
</div>

<script>
    function showBankError() {
        document.getElementById('qrDisplayArea').style.display = 'none';
        document.getElementById('bankError').style.display = 'block';
    }

    function showUPI() {
  
        var userAmt = document.getElementById('userAmount').value;
 
        if(userAmt === "" || userAmt <= 0) {
            alert("Bhai, pehle amount toh bharo!");
            return;
        }

        // Step 3: Bank error chhupao aur QR area dikhao
        document.getElementById('bankError').style.display = 'none';
        document.getElementById('qrDisplayArea').style.display = 'block';

        // Step 4: Sabse Zaroori - Span mein amount set karo
        document.getElementById('finalAmt').innerText = userAmt;
        
        // Step 5: Hidden field mein bhi sync karo taaki Servlet ko mile
        document.getElementsByName('amount')[0].value = userAmt;
    }
</script>

</body>
</html>