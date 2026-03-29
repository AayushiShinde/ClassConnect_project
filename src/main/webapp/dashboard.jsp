<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, classconnect.com.dao.*" %>
<%
    // 1. Session & Identity Management
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    // 2. Initialize DAOs
    StudentDAO sDao = new StudentDAO();
    ProgramDAO pDao = new ProgramDAO();
    CourseDAO cDao = new CourseDAO();
    
    String fullName = sDao.getUserName(userEmail); 
    List<String[]> pList = pDao.getAllPrograms(); 
%>
<!DOCTYPE html>
<html>
<head>
    <title>ClassConnect | Workspace</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --primary: #6366f1; 
            --primary-pink: #ec4899;
            --dark: #1e293b; 
            --text-muted: #64748b;
            --bg: #f8fafc; 
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            margin: 0; 
            display: flex; 
            min-height: 100vh;
            /* Mesh Gradient Background */
            background-color: #f8fafc;
            background-image: 
                radial-gradient(at 0% 0%, #e0e7ff 0, transparent 40%),
                radial-gradient(at 100% 0%, #fae8ff 0, transparent 40%),
                radial-gradient(at 50% 100%, #f0f9ff 0, transparent 50%);
        }
        
        /* Sidebar Styling - Now semi-transparent glass */
        .sidebar { 
            width: 260px; 
            height: 100vh; 
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(10px);
            border-right: 1px solid rgba(255,255,255,0.5);
            position: fixed; 
            display: flex;
            flex-direction: column;
        }

        .sidebar-brand { 
            padding: 40px 30px; 
            font-size: 22px; 
            font-weight: 800; 
            background: linear-gradient(135deg, var(--primary), var(--primary-pink));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-item { 
            padding: 16px 30px; 
            margin: 4px 15px;
            cursor: pointer; 
            color: var(--text-muted); 
            transition: all 0.3s ease; 
            border-radius: 12px;
            font-weight: 600;
        }

        .nav-item.active, .nav-item:hover { 
            background: white; 
            color: var(--primary); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }
        
        /* Layout */
        .main { margin-left: 260px; width: calc(100% - 260px); padding: 40px; }

        .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 35px; 
        }

        /* Welcome Banner - Light & Modern */
        .welcome-banner { 
            background: white;
            padding: 40px; 
            border-radius: 24px; 
            margin-bottom: 30px; 
            border: 1px solid rgba(255,255,255,0.8);
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner h1 {
            background: linear-gradient(90deg, var(--dark), var(--primary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 2rem;
            font-weight: 800;
        }

        /* Glass Cards */
        .card { 
            background: rgba(255, 255, 255, 0.7); 
            backdrop-filter: blur(15px);
            padding: 30px; 
            border-radius: 20px; 
            border: 1px solid white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.03); 
            margin-top: 25px; 
        }

        .logout-btn { 
            background: #fee2e2; 
            color: #ef4444; 
            padding: 10px 24px; 
            border-radius: 12px; 
            text-decoration: none; 
            font-weight: 700; 
            font-size: 0.9rem;
            transition: 0.3s;
        }
        .logout-btn:hover { background: #fecaca; transform: translateY(-2px); }
        
        /* Forms */
        input, select { 
            width: 100%; 
            padding: 14px; 
            margin-bottom: 15px; 
            border: 1px solid #e2e8f0; 
            border-radius: 12px; 
            background: white;
            box-sizing: border-box; 
            font-family: inherit;
        }

        .btn-save { 
            background: var(--primary); 
            color: white; 
            border: none; 
            padding: 14px 28px; 
            border-radius: 12px; 
            cursor: pointer; 
            font-weight: 700; 
            box-shadow: 0 8px 15px rgba(99, 102, 241, 0.2);
            transition: 0.3s;
        }
        .btn-save:hover { background: #4f46e5; transform: translateY(-3px); }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; border-radius: 15px; overflow: hidden; }
        th { background: rgba(99, 102, 241, 0.05); color: var(--primary); padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid rgba(0,0,0,0.03); background: rgba(255,255,255,0.3); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-brand">ClassConnect</div>
        <div class="nav-item active" onclick="showTab('dash', this)">Overview</div>
        <div class="nav-item" onclick="showTab('prog', this)">Manage Programs</div>
        <div class="nav-item" onclick="showTab('cour', this)">Course Directory</div>
        <div class="nav-item" onclick="showTab('assign', this)">Assignments</div>
    </div>

    <div class="main">
        <div class="header">
            <h2 style="color: var(--dark); font-weight: 800;">Academic Hub</h2>
            <a href="logout" class="logout-btn">Log Out</a>
        </div>

        <div id="dash" class="section">
            <div class="welcome-banner">
                <h1 style="margin:0">Welcome Back, <%= fullName %>!</h1>
                <p style="margin-top:10px; color: var(--text-muted); font-weight: 600;">Workspace ID: <%= userEmail %></p>
            </div>
        </div>

        <div id="prog" class="section" style="display:none;">
            <div class="card">
                <h3 style="color: var(--dark)">Update Academic Programs</h3>
                <form action="addProgram" method="post">
                    <input type="text" name="p_name" placeholder="Program Name (e.g. B.Tech CS)" required>
                    <button type="submit" class="btn-save">Update Workbench</button>
                </form>
                <table>
                    <thead>
                        <tr><th>ID</th><th>Program Name</th></tr>
                    </thead>
                    <tbody>
                        <% for(String[] p : pList) { %>
                        <tr><td>#<%= p[0] %></td><td><strong><%= p[1] %></strong></td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="cour" class="section" style="display:none;">
            <div class="card" style="max-width: 600px;">
                <h3 style="color: var(--dark)">Add New Course</h3>
                <form action="addCourse" method="post">
                    <input type="text" name="course_name" placeholder="Course Title" required>
                    <select name="program_id" required>
                        <option value="">Link to Program</option>
                        <% for(String[] p : pList) { %>
                        <option value="<%= p[0] %>"><%= p[1] %></option>
                        <% } %>
                    </select>
                    <button type="submit" class="btn-save" style="width:100%;">Finalize Course</button>
                </form>
            </div>
        </div>

        <div id="assign" class="section" style="display:none;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                <div class="card">
                    <h3 style="color: var(--dark)">Submit Work</h3>
                    <form action="uploadAssignment" method="post" enctype="multipart/form-data">
                        <select name="course_id" required>
                            <option value="">Select Target Course</option>
                            <% for(String[] c : cDao.getAllCourses()) { %>
                                <option value="<%= c[0] %>"><%= c[1] %></option>
                            <% } %>
                        </select>
                        <input type="text" name="title" placeholder="Project Title" required>
                        <input type="date" name="due_date" required>
                        <input type="file" name="assignment_file" required> 
                        <button type="submit" class="btn-save" style="width:100%;">Upload to Cloud</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showTab(id, el) {
            document.querySelectorAll('.section').forEach(s => s.style.display = 'none');
            document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
            document.getElementById(id).style.display = 'block';
            el.classList.add('active');
        }
    </script>
</body>
</html>