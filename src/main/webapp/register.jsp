<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | ClassConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-indigo: #6366f1;
            --primary-pink: #ec4899;
            --text-dark: #1e293b;
            --border-soft: rgba(226, 232, 240, 0.8);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Light Mesh Gradient */
            background-color: #f8fafc;
            background-image: 
                radial-gradient(at 0% 0%, #e0e7ff 0, transparent 40%),
                radial-gradient(at 100% 0%, #fae8ff 0, transparent 40%),
                radial-gradient(at 50% 100%, #f0f9ff 0, transparent 50%);
            overflow-x: hidden;
        }

        /* Glassmorphism Card */
        .register-container {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 3rem;
            border-radius: 35px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.04);
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(255, 255, 255, 0.7);
            transition: transform 0.3s ease;
        }

        .register-container:hover {
            transform: translateY(-5px);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            background: linear-gradient(135deg, var(--primary-indigo), var(--primary-pink));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
            margin-top: 8px;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 6px;
            margin-left: 4px;
            text-transform: uppercase;
            letter-spacing: 0.02em;
        }

        input, select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--border-soft);
            border-radius: 15px;
            font-size: 15px;
            box-sizing: border-box;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
            color: var(--text-dark);
            font-family: inherit;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary-indigo);
            background: white;
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.1);
        }

        /* Submit Button */
        .btn-register {
            width: 100%;
            background: var(--primary-indigo);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 18px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 15px;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.2);
        }

        .btn-register:hover {
            background: #4f46e5;
            transform: scale(1.02);
            box-shadow: 0 12px 25px rgba(99, 102, 241, 0.3);
        }

        /* Footer Links */
        .footer-text {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }

        .footer-text a {
            color: var(--primary-indigo);
            text-decoration: none;
            font-weight: 700;
        }

        .footer-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="header">
            <h1>ClassConnect</h1>
            <p>Join the future of academic collaboration</p>
        </div>

        <form action="register" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Aayushi Shinde" required>
            </div>

            <div class="form-group">
                <label id="idLabel">PRN Number</label>
                <input type="text" name="prn" placeholder="Enter ID/PRN" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="name@example.com" required>
            </div>

            <div class="form-group">
                <label>Create Password</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <div class="form-group">
                <label>Identify As</label>
                <select name="role" id="roleSelect" onchange="updateLabel()">
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                </select>
            </div>

            <button type="submit" class="btn-register">Create Account</button>
        </form>

        <div class="footer-text">
            Already a member? <a href="login.html">Login here</a>
        </div>
    </div>

    <script>
        function updateLabel() {
            const role = document.getElementById('roleSelect').value;
            const label = document.getElementById('idLabel');
            label.innerText = (role === 'student') ? 'PRN Number' : 'Teacher ID';
        }
    </script>
</body>
</html>