package lucene.file.search.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuozhengsoft.pageoffice.OpenModeType;
import com.zhuozhengsoft.pageoffice.PDFCtrl;
import com.zhuozhengsoft.pageoffice.PageOfficeCtrl;
import lucene.file.search.model.FileModel;

public class FilePreviewServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final String CONTENT_TYPE = "text/html; charset=UTF-8";
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		//接收查询字符串
		String query = request.getParameter("filename");
		//编码格式转换
		//query = new String(query.getBytes("iso8859-1"), "UTF-8");
		String filename = URLDecoder.decode(request.getParameter("filename"),"UTF-8");		
		//String filename =new String(query.getBytes("iso8859-1"), "UTF-8");
		System.out.println(filename);
		String filePath = request.getServletContext().getRealPath("/files") + "\\" + filename;
		System.out.println(filePath);

		String suffix = filePath.substring(filePath.lastIndexOf(".") + 1);
		if(suffix.equals("doc")||suffix.equals("docx")) {
			openWord(filePath,request,response);
		}else if(suffix.equals("pdf")) {
			openPdf(filePath,request,response);
		}
		
			

	}
	
	private void openWord(String filePath,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
        //不用改
		poCtrl1.setServerPage(request.getContextPath() + "/poserver.zz");
		//隐藏Office工具条
		poCtrl1.setOfficeToolbars(false);
		//隐藏自定义工具栏
		poCtrl1.setCustomToolbar(false);
		//设置页面的显示标题
		poCtrl1.setCaption("标题");

		if (filePath != null) {
			poCtrl1.webOpen("file://" + filePath, OpenModeType.docReadOnly,"");	
			poCtrl1.setTagId("PageOfficeCtrl1");			
		}
		request.getRequestDispatcher("open.jsp").forward(request, response);
	}
	
	private void openPdf(String filePath,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		    PDFCtrl poCtrl1 = new PDFCtrl(request);
		    poCtrl1.setServerPage(request.getContextPath()+"/poserver.zz"); //此行必须

		// Create custom toolbar
		    poCtrl1.addCustomToolButton("打印", "Print()", 6);
		    poCtrl1.addCustomToolButton("隐藏/显示书签", "SetBookmarks()", 0);
		    poCtrl1.addCustomToolButton("-", "", 0);
		    poCtrl1.addCustomToolButton("实际大小", "SetPageReal()", 16);
		    poCtrl1.addCustomToolButton("适合页面", "SetPageFit()", 17);
		    poCtrl1.addCustomToolButton("适合宽度", "SetPageWidth()", 18);
		    poCtrl1.addCustomToolButton("-", "", 0);
		    poCtrl1.addCustomToolButton("首页", "FirstPage()", 8);
		    poCtrl1.addCustomToolButton("上一页", "PreviousPage()", 9);
		    poCtrl1.addCustomToolButton("下一页", "NextPage()", 10);
		    poCtrl1.addCustomToolButton("尾页", "LastPage()", 11);
		    poCtrl1.addCustomToolButton("-", "", 0);

		    if (filePath != null) {
			    poCtrl1.webOpen("file://" + filePath);
				poCtrl1.setTagId("PDFCtrl1");			
			}
			request.getRequestDispatcher("openPdf.jsp").forward(request, response);
	}
}
