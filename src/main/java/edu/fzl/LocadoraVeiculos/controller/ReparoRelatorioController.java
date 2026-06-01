package edu.fzl.LocadoraVeiculos.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class ReparoRelatorioController {
	
	@Autowired
	private DataSource ds;
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "relatorioReparos", method = RequestMethod.GET)
	public ResponseEntity relatorioReparosGet() {
	    String erro = "";

	    Map<String, Object> reportParams = new HashMap<>();

	    Connection conn = DataSourceUtils.getConnection(ds);

	    byte[] bytes = null;
	    InputStreamResource resources = null;
	    HttpStatus status = null;
	    HttpHeaders header = new HttpHeaders();

	    try {
	        String path = "classpath:reports/veiculosEmReparo.jasper";
	        File arquivo = ResourceUtils.getFile(path);
	        JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
	        bytes = JasperRunManager.runReportToPdf(report, reportParams, conn);
	    } catch (Exception e) {
	        erro = e.getMessage();
	        e.printStackTrace();
	        status = HttpStatus.BAD_REQUEST;
	    } finally {
	        if (erro.equals("")) {
	            ByteArrayInputStream stream = new ByteArrayInputStream(bytes);
	            resources = new InputStreamResource(stream);
	            status = HttpStatus.OK;
	            header.setContentLength(bytes.length);
	            header.setContentType(MediaType.APPLICATION_PDF);
	        }
	    }

	    return new ResponseEntity(resources, header, status);
	}
}
