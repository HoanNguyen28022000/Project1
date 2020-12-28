package com.hoan.Controller.upload;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.hoan.Connection.ConnectSQLServer;

@WebServlet(name = "FileUploadServlet", urlPatterns = { "/Admin/Items/fileuploadservlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024
		* 100)
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ConnectSQLServer connection = new ConnectSQLServer();

		String itemID = (String) request.getParameter("itemID");
		String itemImg = (String) connection.getItem("itemID").get("itemImg");
		String itemDetail = (String) request.getParameter("itemDetail");
		String itemName = (String) request.getParameter("itemName");
		String itemType = (String) request.getParameter("itemType");
		String productionCompany = (String) request.getParameter("productionCompany");
		String madeIn = (String) request.getParameter("madeIn");
		String itemColor = (String) request.getParameter("itemColor");
		String dateOfMade = ((String) request.getParameter("dateOfMade"));
		String status = ((String) request.getParameter("status"));

//		String dateOfMade= "2020-12-08 12:20:00";

		Part filePart = request.getPart("file");
		if (filePart.getSubmittedFileName()!="") {
			String filename = filePart.getSubmittedFileName();
			System.out.println(filename);
			String filePath = "E:\\HOC TAP\\Lap Trinh\\JAVA\\WorkSpace\\com.spring-mvc-demo\\src\\main\\webapp\\resources\\images\\"
					+ filename;
			itemImg = "/com.spring-mvc-demo/resources/images/" + filename;

			File file = new File(filePath);
			file.delete();
			for (Part part : request.getParts()) {
				part.write(filePath);
			}

			connection.setItem(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn,
					itemColor, status);

			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} else {
			connection.setItem(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn,
					itemColor, status);
		}

		request.getRequestDispatcher("/Admin/Items").forward(request, response);

	}

}
