package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import DAO.BoardDAO;
import DTO.Board;

@WebServlet("/")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardDAO dao;
    private ServletContext ctx;
	
	//init() 메소드는 최초 1회만 실행되기 때문에 객체를 하나 생성해서 전체적으로 공유할 수 있다.
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		
		//init은 서블릿 객체 생성 시 딱 한 번만 실행하므로 객체를 한 번만 생성해 공유할 수 있다.
		dao = new BoardDAO();
		ctx = getServletContext();	//웹프로젝트당 하나의 서블릿 콘텍스트 생성. (웹어플리케이션의 자원 관리, app이 종료될 때 소멸)
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); //request 객체에 저장된 한글 깨짐 방지
		doPro(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doPro(request,response);
	}
	
	//doPro는 라우팅의 역할을 한다. 라우팅: url 경로의 길을 찾아주는역할
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String context = request.getContextPath();
		String command = request.getServletPath();
		String site = null;
		
		//경로 라우팅(경로를 찾아줌)
		switch(command) {
			case "/list" : 
				site = getList(request);
				break;
			case "/view" :
				site = getView(request);
				break;
			case "/write" :		//글쓰기 화면을 보여줌
				site = "write.jsp";
				break;
			case "/insert" :	//insert 기능
				site = insertBoard(request);
				break;
			case "/edit" :	//수정 화면을 보여줌
				site = getViewForEdit(request);
				break;
			case "/update" :
				site = updateBoard(request);
				break;
			case "/delete" :
				site = deleteBoard(request);
				break;
		}
		
		/*
		 -둘 다 페이지를 이동한다.
		 redirect와 forward의 차이
		 
		 1)redirect: URL 변화 O, 객체의 재사용 X
		  > DB에 변화가 생기는 요청에 사용(글쓰기, 회원가입...) insert, update, delete 조심..
		 
		 2)forward: URL 변화 X(보안 용이), 객체의 재사용 O 
		  >단순 조회(리스트 보기, 검색 등) select..
		  
		  forward를 글쓰기, 회원가입 등에 사용한 상태에서 새로고침을 하게 되면 중복 등록, 삭제가 될 수 있다.
		  
		 *객체의 재사용? request, response 객체를 생각하면 됨 !
		 */
		
		if(site.startsWith("redirect:/")) {	//redirect (페이지 이동)
			String rview = site.substring("redirect:/".length()); //redirect:/문자열만큼 잘라준다.
			System.out.println("substring" + rview);
			
			response.sendRedirect(rview);
		} else { //forward (페이지 이동)
			ctx.getRequestDispatcher("/" + site).forward(request, response);
		}
		
	}
	
	public String getList(HttpServletRequest request) {
		List<Board> list;
		
		//DAO에서 getList() 메소드에서 exception이 발생하면 여기로 오고, try-catch로 처리를 해줘야 한다.
		try {
			list = dao.getList();
			request.setAttribute("boardList", list);
		} catch (Exception e) {
			e.printStackTrace();
			//에러가 발생하면 콘솔에 로그가 찍힌다.
			ctx.log("게시판 목록 생성 과정에서 문제 발생");
			//사용자에게 에러 발생을 알려줌. error라는 키로 게시판 목록이~ 문자열을 저장
			request.setAttribute("error", "게시판 목록이 정상적으로 처리되지 않았습니다!");
			return getList(request);
		}
		return "index.jsp";
	}
	
	public String getView(HttpServletRequest request) {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		try {
			dao.updateView(board_no);	//조회수 증가
			Board b = dao.getView(board_no);
			request.setAttribute("board", b);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("게시글 조회 과정에서 문제 발생");
			request.setAttribute("error", "게시글을 정상적으로 가져오지 못했습니다!");
		}
		return "view.jsp";
	}

	public String insertBoard(HttpServletRequest request) {
		//request.getParameter("user_id");
		//request.getParameter("title");
		//request.getParameter("content");
		//원래는 위와 같이 작성해야 하는데, 라이브러리 사용해서 편하게 풀어낼 수 있음
		
		Board b = new Board();
		
		/*
		 * 아래의 beanutils가 이 일을 대신 해준당
		b.setUser_id(request.getParameter("user_id"));
		b.setTitle(request.getParameter("title"));
		b.setContent(request.getParameter("content"));
		*/
		
		try {
			BeanUtils.populate(b, request.getParameterMap());
			dao.insertBoard(b);
			
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("게시글 등록 과정에서 문제 발생");
			//에러 메세지를 get 방식으로 보냄
			try {
				String encodename = URLEncoder.encode("게시물이 정상적으로 등록되지 않았습니다!", "UTF-8");
				return "redirect:/list?error=" + encodename;
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
		return "redirect:/list";
	}
	
	public String getViewForEdit(HttpServletRequest request) {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		try {
			Board b = dao.getViewForEdit(board_no);
			request.setAttribute("board", b);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("게시글 조회 과정에서 문제 발생");
			request.setAttribute("error", "게시글을 정상적으로 가져오지 못했습니다!");
		}
		return "edit.jsp";
	}
	
	public String updateBoard(HttpServletRequest request) {
		Board b = new Board();
		try {
			BeanUtils.populate(b, request.getParameterMap());
			dao.updateBoard(b);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("게시글 수정 과정에서 문제 발생");
			//에러 메세지를 get 방식으로 보냄
			try {
				String encodeName = URLEncoder.encode("게시물이 정상적으로 수정되지 않았습니다!", "UTF-8");
				return "redirect:/view?board_no=" + b.getBoard_no() + "&error=" + encodeName;
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
		return "redirect:/view?board_no=" + b.getBoard_no();
	}

	public String deleteBoard(HttpServletRequest request) {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		try {
			dao.deleteBoard(board_no);
		} catch(Exception e) {
			e.printStackTrace();
			ctx.log("게시글 삭제 과정에서 문제 발생");
			String encodeName;
			try {
				encodeName = URLEncoder.encode("게시물이 정상적으로 삭제되지 않았습니다!", "UTF-8");
				return "redirect:/list?error=" + encodeName;
			} catch(Exception e1) {
				e1.printStackTrace();
			}
		}
		return "redirect:/list";
	}
}
