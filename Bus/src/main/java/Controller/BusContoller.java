package Controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;

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
				site = signUp(request);
				break;
//			case "/reserve" :
//				site = insertInfo(request);
//				break;
		}
		ctx.getRequestDispatcher("/" + site).forward(request, response);
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
	
	public String signUp(HttpServletRequest request) {
		Passenger passenger = new Passenger();
		
		try {
			BeanUtils.populate(passenger, request.getParameterMap());
			dao.signUp(passenger);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
