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
import DTO.Inquiry;
import DTO.Modify;
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
			case "/home" :
				site = "index.jsp";
				break;
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
			case "/reserve" :
				site = doRev(request, response);
				break;
			case "/inquiry" :
				site = "inquiry.jsp";
				break;
			case "/inquirSelect" :
				site = inquirCheck(request, response);
				break;
			case "/inquirDetail" :
				site = inquirDetail(request);
				break;
			case "/modify" :
				site = getModify(request);
				break;
			case "/sbmModify" :
				site = subModify(request, response);
				break;
			case "/delete" :
				site = subDelete(request, response);
				break;
		}
		if(site.startsWith("redirect:/")) {	//redirect (페이지 이동)
			String rview = site.substring("redirect:/".length()); //redirect:/문자열만큼 잘라준다.
			System.out.println("substring" + rview);
			response.sendRedirect(rview);
		} else if (site.startsWith("null")) { 
			System.out.println("startwith: null");
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
	
	//회원가입 아이디 중복체크 및 등록
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
	
	//예약 등록
	public String doRev(HttpServletRequest request, HttpServletResponse response) {
		String bus_no = request.getParameter("bus_no");
		System.out.println("지금 뭐니? : " +bus_no);
		Reservation rev = new Reservation();
		
		try {
			BeanUtils.populate(rev, request.getParameterMap());
			String reserve = dao.reserve(rev);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			System.out.println(rev.getId());
			if (reserve.equals("1")) {
				dao.insertRev(rev);
				out.println("<script>");
				out.println("alert('예약이 완료되었습니다!');");
				out.println("const url = location.origin;");
				out.println("location.href = url + '/Bus/inquirDetail?id="+rev.getId()+"';");
				out.println("</script>");
				out.flush();
			} else {
				out.println("<script>");
				out.println("alert('존재하지 않는 아이디입니다!');");
				out.println("const url = location.origin;");
				out.println("location.href = url + '/Bus/reservation?bus_no="+bus_no+"';");
				out.println("</script>");
				out.flush();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "null";
	}
	
	//예약조회 페이지 - 아이디 조회
	public String inquirCheck(HttpServletRequest request, HttpServletResponse response) {
		Reservation rev = new Reservation();
		
		try {
			BeanUtils.populate(rev, request.getParameterMap());
			String inCheck = dao.inquirCheck(rev);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if (inCheck.equals("1")) {
				return "inquirDetail?id=" + rev.getId();
			} else {
				out.println("<script>");
				out.println("alert('존재하지 않는 아이디입니다!');");
				out.println("const url = location.origin;");
				out.println("location.href = url + '/Bus/inquiry';");
				out.println("</script>");
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "null";
	}
	
	public String inquirDetail(HttpServletRequest request) {
		String id = request.getParameter("id");
		ArrayList<Inquiry> inqList;
		
		try {
			inqList = dao.inquirDetail(id);
			request.setAttribute("inqList", inqList);
			request.setAttribute("id", id);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("예약 조회 과정에서 문제 발생");
			request.setAttribute("error", "예약 조회가 정상적으로 처리되지 않았습니다!");
		}
		return "inquiryDetail.jsp";
	}
	
	public String getModify(HttpServletRequest request) {
		String reserveNo = request.getParameter("r_no");
		Modify modi;
		ArrayList<Bus> blist;
		
		try {
			modi = dao.modify(reserveNo);
			blist = dao.getView();
			request.setAttribute("blist", blist);
			request.setAttribute("modi", modi);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "modify.jsp";
	}
	
	public String subModify(HttpServletRequest request, HttpServletResponse response) {
		Reservation reserv = new Reservation();
		
		try {
			BeanUtils.populate(reserv, request.getParameterMap());
			dao.subModify(reserv);
			
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			
//			out.println("<script>");
//			out.println("alert('예약이 변경되었습니다.');");
//			out.println("</script>");
//			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "inquirDetail?id=" + reserv.getId();
	}
	
	public String subDelete(HttpServletRequest request, HttpServletResponse response) {
		Reservation reserv = new Reservation();
		
		try {
			BeanUtils.populate(reserv, request.getParameterMap());
			dao.subDelete(reserv);
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			
//			out.println("<script>");
//			out.println("alert('예약이 취소되었습니다!');");
//			out.println("const url = location.origin;");
//			out.println("location.href = url + '/Bus/inquirDetail?id="+reserv.getId()+"';");
//			out.println("</script>");
//			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(reserv.getId());
		return "inquirDetail?id=" + reserv.getId();
	}
}
