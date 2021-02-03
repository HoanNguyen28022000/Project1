package com.hoan.Controller.ajax.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Model.Statistical;
import com.sun.org.glassfish.external.statistics.Statistic;

/**
 * Servlet implementation class StatisticalActions
 */
public class StatisticalActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Statistical statistical= new Statistical();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String action = (String) request.getParameter("action");
		
		if (action.equals("getStatisticalYear")) {
			int year = Integer.parseInt(request.getParameter("year"));
			
			JSONArray statisticalYear = new JSONArray();
			
			for (int i=0; i<12; i++) {
				JSONObject obj= new JSONObject();
				obj.put("month", i+1);
				obj.put("In", statistical.getTotalIn(year, i+1));
				obj.put("Out", statistical.getTotalOut(year, i+1));
				
				statisticalYear.add(obj);
			}
			
			out.print(statisticalYear.toJSONString());
			out.flush();
		}
	}

}
