<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, classconnect.com.dao.*" %>
<%
    // Security: Check if teacher is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard | ClassConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --primary: #6366f1; 
            --primary-pink: #ec4899;
            --dark-text: #1e293b; 
            --text-muted: #64748b;
            --bg: #f8fafc; 
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            margin: 0; 
            display: flex; 
            min-height: 100vh;
            /* Light Mesh Gradient Background */
            background-color: #f8fafc;
            background-image: 
                radial-gradient(at 0% 0%, #e0e7ff 0, transparent 40%),
                radial-gradient(at 100% 0%, #fae8ff 0, transparent 40%),
                radial-gradient(at 50% 100%, #f0f9ff 0, transparent 50%);
        }
        
        /* Glass Sidebar */
        .sidebar { 
            width: 260px; 
            height: 100vh; 
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(12px);
            border-right: 1px solid rgba(255, 255, 255, 0.5);
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
            letter-spacing: -0.04em;
        }

        .nav-item { 
            padding: 16px 30px; 
            margin: 4px 15px;
            cursor: pointer; 
            color: var(--primary); 
            background: white;
            border-radius: 12px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.1);
            border-left: 4px solid var(--primary);
        }
        
        /* Main Layout */
        .main { margin-left: 260px; width: calc(100% - 260px); padding: 40px; }

        .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 35px; 
        }

        .header h2 {
            font-weight: 800;
            color: var(--dark-text);
            margin: 0;
            letter-spacing: -0.02em;
        }

        /* Content Card */
        .card { 
            background: rgba(255, 255, 255, 0.7); 
            backdrop-filter: blur(15px);
            padding: 35px; 
            border-radius: 24px; 
            border: 1px solid white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03); 
        }

        .card h3 {
            margin-top: 0;
            font-weight: 800;
            color: var(--dark-text);
            font-size: 1.4rem;
        }

        .logout-btn { 
            background: #fee2e2; 
            color: #ef4444; 
            padding: 10px 24px; 
            border-radius: 12px; 
            text-decoration: none; 
            font-weight: 700; 
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .logout-btn:hover { 
            background: #fecaca; 
            transform: translateY(-2px); 
        }
        
        /* Table Styling */
        table { width: 100%; border-collapse: collapse; margin-top: 25px; border-radius: 15px; overflow: hidden; }
        
        th { 
            background: rgba(99, 102, 241, 0.05); 
            color: var(--primary); 
            padding: 18px; 
            text-align: left; 
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td { 
            padding: 18px; 
            border-bottom: 1px solid rgba(0, 0, 0, 0.03); 
            background: rgba(255, 255, 255, 0.4); 
            color: var(--dark-text);
            font-weight: 500;
        }

        .view-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 700;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(99, 102, 241, 0.1);
            transition: 0.3s;
        }

        .view-link:hover {
            background: var(--primary);
            color: white;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-brand">ClassConnect</div>
        <div class="nav-item">Review Submissions</div>
    </div>

    <div class="main">
        <div class="header">
            <h2>Teacher Academic Workspace</h2>
            <a href="logout" class="logout-btn">Logout</a>
        </div>

        <div class="card">
            <h3>Incoming Student Assignments</h3>
            <table>
                <thead>
                    <tr>
                        <th>Assignment Title</th>
                        <th>Course Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        AssignmentDAO aDao = new AssignmentDAO(); 
                        List<String[]> list = aDao.getAllSubmissions(); 
                        
                        if(list != null && !list.isEmpty()) {
                            for(String[] row : list) {
                    %>
                    <tr>
                        <td><%= row[0] %></td>
                        <td><%= row[1] %></td>
                        <td>
                            <a href="file:///<%= row[2] %>" target="_blank" class="view-link">View Submission</a>
                        </td>
                    </tr>
                    <%      } 
                        } else {
                    %>
                    <tr>
                        <td colspan="3" style="text-align: center; padding: 40px; color: var(--text-muted);">
                            No assignments submitted yet.
                        </td>
                    </tr>
                    <%  } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>