
<%@ page language="java"
	import="java.sql.*,java.util.*,Employee.Employee"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form onsubmit="index.jsp">
		<label>Name:<input type="text" id="name"></label><br> <br>
		<label>Empno:<input type="text" id="eno"></label><br> <br>
		<label>Salary:<input type="text" id="sal"></label><br> <br>
		<label>Job:<input type="text" id="job"></label><br> <br>
		<label>Department:<input type="text" id="dept"></label><br>
		<br> <input type="submit" name="name" value="First">
		<input type="submit" name="name" value="Prev">
		<input type="submit" name="name" value="Next">
		<input type="submit" name="name" value="Last"><br>
		<input type="submit" name="name" value="Delete">
	</form>
		<%
		try {
			HttpSession ses = request.getSession();
			if (ses.getAttribute("pos") == null) {
				ses.setAttribute("pos", 0);
			}
			ArrayList<Employee> ar = null;
			Connection c = null;
			Statement s = null;
			ResultSet rs = null;
			String name="", eno="", sal="", job="", dept="";
			String btn = (String) request.getParameter("name");
			if (btn == null) {
				Class.forName("org.postgresql.Driver");
				c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres?user=postgres&password=Bhara@1234");
				s = c.createStatement();
				rs = s.executeQuery("select * from Emp");
				ar = new ArrayList<>();
				while (rs.next()) {
			ar.add(new Employee(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
				}
				ses.setAttribute("data", ar);
				
				
			} else if (btn.equals("First")) {
				ArrayList<Employee> ad = (ArrayList<Employee>) ses.getAttribute("data");
				Employee e = ad.get(0);
				name = e.getEname();
				eno = e.getEno();
				sal = e.getSal();
				job = e.getJob();
				dept = e.getDept();
				ses.setAttribute("pos", 0);
				System.out.println(name+dept);

			}
		else if (btn.equals("Last")) {
			ArrayList<Employee> ad = (ArrayList<Employee>) ses.getAttribute("data");
			int i=ad.size();
			Employee e = ad.get(i-1);
			name = e.getEname();
			eno = e.getEno();
			sal = e.getSal();
			job = e.getJob();
			dept = e.getDept();
			ses.setAttribute("pos", i-1);
			System.out.println(name+dept);

		}
		else if (btn.equals("Next")) {
			ArrayList<Employee> ad = (ArrayList<Employee>) ses.getAttribute("data");
			int i=(int)ses.getAttribute("pos");
			Employee e = ad.get(i+1);
			name = e.getEname();
			eno = e.getEno();
			sal = e.getSal();
			job = e.getJob();
			dept = e.getDept();
			ses.setAttribute("pos", i+1);
			System.out.println(name+dept);

		}
		else if (btn.equals("Prev")) {
			ArrayList<Employee> ad = (ArrayList<Employee>) ses.getAttribute("data");
			int i=(int)ses.getAttribute("pos");
			Employee e = ad.get(i-1);
			name = e.getEname();
			eno = e.getEno();
			sal = e.getSal();
			job = e.getJob();
			dept = e.getDept();
			ses.setAttribute("pos", i-1);
			System.out.println(name+dept);

		}
		else if (btn.equals("Clear")) {
			name="";
			sal="";
			job="";
			eno="";
			dept="";
		}
		else if (btn.equals("Delete")) {
			ArrayList<Employee> ad = (ArrayList<Employee>) ses.getAttribute("data");
			int i=(int)ses.getAttribute("pos");
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres?user=postgres&password=Bhara@1234");
			PreparedStatement ps = c.prepareStatement("delete from Emp where eno=?");
			String w=request.getParameter("eno");
			System.out.println(w);
			ps.setString(1,w);
			ps.execute();
			ad.remove(i);
			ses.setAttribute("pos", i-1);
			ses.setAttribute("data", ad);

		}
		%>
		<script>
			var n1=document.getElementById("name");
			var n2=document.getElementById("eno");
			var n3=document.getElementById("sal");
			var n4=document.getElementById("job");
			var n5=document.getElementById("dept");
			n1.value =" <%=name%>";
			n2.value ="<%=eno%> ";
			n3.value ="<%=sal%>";
			n4.value ="<%=job%>";
			n5.value ="<%=dept%>";
		</script>


		<%
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
</body>
</html>