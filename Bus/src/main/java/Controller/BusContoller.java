package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import DAO.BusDAO;
import DTO.Bus;
import DTO.Passenger;
import DTO.Reservation;

@WebServlet("/")
public class BusContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BusDAO dao;
	private ServletContext ctx;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		
		dao = new BusDAO();
		ctx = getServletContext();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doPro(request, response);
	}
	
	protected void doPro (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String context = request.getContextPath();
		String command = request.getServletPath();
		String site = null;
		
		switch(command) {
			case "/view" :
				site = getView(request);
				break;
			case "/reservation" :
				site = doReservation(request);
				break;
			case "/sign" :
				site = "sign.jsp";
				break;
			case "/signUp" :
				site = check(request, response);
				break;
//			case "/reserve" :
//				site = doRev(request);
		}
		if(site.startsWith("redirect:/")) {	//redirect (페이지 이동)
			String rview = site.substring("redirect:/".length()); //redirect:/문자열만큼 잘라준다.
			System.out.println("substring" + rview);
			response.sendRedirect(rview);
		} else if (site.startsWith("null")) { 
			System.out.println("null");
		} else { //forward (페이지 이동)
			ctx.getRequestDispatcher("/" + site).forward(request, response);
		}	
	}
	
	public String getView(HttpServletRequest request) {
		ArrayList<Bus> busTime;
		
		try {
			busTime = dao.getView();
			request.setAttribute("busTime", busTime);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("시간표 조회 과정에서 문제 발생");
			request.setAttribute("error", "시간표 조회가 정상적으로 처리되지 않았습니다!");
		}
		return "view.jsp";
	}
	
	public String doReservation(HttpServletRequest request) {
		Bus bus;
		
		String bus_no = request.getParameter("bus_no");
		System.out.println(bus_no);
		
		try {
			bus = dao.getBus(bus_no);
			request.setAttribute("bus", bus);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "reservation.jsp";
	}
	
	public String check(HttpServletRequest request, HttpServletResponse response) {
		Passenger passenger = new Passenger();

		try {
			BeanUtils.populate(passenger, request.getParameterMap());
			String test = dao.check(passenger);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if (test.equals("1")) {
				out.println("<script>");
				out.println("alert('중복된 아이디입니다!');");
				out.println("const url = location.origin;");
				out.println("location.href = url + '/Bus/sign';");
				out.println("</script>");
				out.flush();
			} else {
				dao.signUp(passenger);
				
				request.setAttribute("passenger", passenger);
				out.println("<script>");
				out.println("alert('회원가입이 완료되었습니다!');");
				out.println("const url = location.origin;");
				out.println("location.href = url + '/Bus/view';");
				out.println("</script>");
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "null";
	}
	
//	public String doRev(HttpServletRequest request) {
//		Reservation rev;
//		
//	}
}
