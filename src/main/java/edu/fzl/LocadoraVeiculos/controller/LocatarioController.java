package edu.fzl.LocadoraVeiculos.controller;

import java.time.LocalDate;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import edu.fzl.LocadoraVeiculos.model.Locatario;
import edu.fzl.LocadoraVeiculos.service.CarroService;
import edu.fzl.LocadoraVeiculos.service.LocatarioService;

@Controller
public class LocatarioController {

	@Autowired
	private LocatarioService service;
	@Autowired
	private CarroService cService;

	@RequestMapping(name = "locatario", value = "/locatario", method = RequestMethod.GET)
	public ModelAndView locatarioGet(@RequestParam Map<String, String> params, ModelMap model) {
		Locatario l = new Locatario();
		model.addAttribute("locatario", l);
		return new ModelAndView("locatario");
	}

	@RequestMapping(name = "locatario", value = "/locatario", method = RequestMethod.POST)
	public ModelAndView locatarioPost(@RequestParam Map<String, String> params, ModelMap model) {

		String cmd = params.get("acao");
		String cpf = params.get("cpf");
		String nome = params.get("nome");
		String cnh = params.get("numeroHabilitacao");
		String dtNasc = params.get("dataNascimento");
		String logradouro = params.get("logradouro");
		String numero = params.get("numero");
		String cep = params.get("cep");
		String cidade = params.get("cidade");
		String placa = params.get("placa");

		Locatario l = new Locatario();
		String erro = "";

		try {
			if (cmd.equalsIgnoreCase("Continuar")) {
				l.setCpf(cpf);
				
				if(nome != null && !nome.isEmpty()) {
					String[] partes = nome.trim().split("\\s+");
					boolean valido = partes.length >= 2;
					if(valido) {
						l.setNome(nome);
					} else {
						throw new Exception ("Nome Inválido.");
					}
				} else {
					throw new Exception ("Nome Inválido.");
				}
				
				if(cnh != null && !cnh.isEmpty() && cnh.matches("\\d{11}")) {
					l.setNumeroHabilitacao(cnh);
				} else {
					throw new Exception ("CNH Inválida.");
				}
				
				LocalDate hj = LocalDate.now();
				LocalDate limMax = hj.minusYears(18);   
				LocalDate limMin = hj.minusYears(100); 

				if (dtNasc != null && !dtNasc.isEmpty()) {
				    LocalDate data = LocalDate.parse(dtNasc);

				    if (data.isAfter(limMax)) {
				        throw new Exception("É necessário ser maior de 18 anos.");
				    }

				    if (data.isBefore(limMin)) {
				        throw new Exception("Data de nascimento inválida.");
				    }

				    l.setDataNascimento(data);

				} else {
				    throw new Exception("Data de nascimento obrigatória.");
				}
				
				if(logradouro != null && !logradouro.isEmpty() && logradouro.length() > 2) {
					l.setLogradouro(logradouro);
				} else {
					throw new Exception("Logradouro inválido.");
				}
				
				if(numero != null && !numero.isEmpty() && Integer.parseInt(numero) >= 0) {
					l.setNumero(Integer.parseInt(numero));
				} else {
					throw new Exception("Numero inválido.");
				}
				
				if(cep != null && !cep.isEmpty() && cep.matches("\\d{8}")) {
					l.setCep(cep);
				} else {
					throw new Exception("CEP inválido");
				}
				
				if(cidade != null && !cidade.isEmpty() && cidade.length() > 2) {
					l.setCidade(cidade);
				} else {
					throw new Exception("Cidade inválida");
				}
				
				service.salvar(l);
				model.addAttribute("locatario", l);
	            model.addAttribute("carro", cService.buscar(placa));
				return new ModelAndView("confirmar", model);
			}
		} catch (Exception e) {
			erro = e.getMessage();
			erro = "Erro: " + e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("locatario", l);
			model.addAttribute("placa", placa);
		}

		return new ModelAndView("locatario");
	}
	
	@RequestMapping(value = "/usuarios", method = RequestMethod.GET)
	public ModelAndView clientesGet(ModelMap model) {
	    model.addAttribute("clientes", service.listarTodos());
	    return new ModelAndView("usuarios");
	}
}