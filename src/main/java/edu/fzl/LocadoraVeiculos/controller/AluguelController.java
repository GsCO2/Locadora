package edu.fzl.LocadoraVeiculos.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import edu.fzl.LocadoraVeiculos.model.Aluguel;
import edu.fzl.LocadoraVeiculos.model.AluguelDto;
import edu.fzl.LocadoraVeiculos.model.Locatario;
import edu.fzl.LocadoraVeiculos.service.AluguelService;
import edu.fzl.LocadoraVeiculos.service.CarroService;
import edu.fzl.LocadoraVeiculos.service.LocatarioService;

@Controller
public class AluguelController {

	@Autowired
	private AluguelService aService;
	@Autowired
	private CarroService cService;
	@Autowired
	private LocatarioService lService;

	@RequestMapping(value = "/aluguel", method = RequestMethod.GET)
	public ModelAndView aluguelGet(@RequestParam Map<String, String> params, ModelMap model) {
		return new ModelAndView("aluguel");
	}

	@RequestMapping(value = "/aluguel", method = RequestMethod.POST)
	public ModelAndView aluguelPost(@RequestParam Map<String, String> params, ModelMap model) {
		String placa = params.get("placa");
		String cpf = params.get("cpf");

		model.addAttribute("placa", placa);

		if (cpf == null || cpf.isEmpty()) {
			return new ModelAndView("aluguel", model);
		}

		try {
			Locatario locatario = lService.buscarPorCpf(cpf);
			model.addAttribute("cpf", cpf);
			if (locatario == null) {
				return new ModelAndView("locatario", model);
			} else {
				model.addAttribute("locatario", locatario);
				model.addAttribute("carro", cService.buscar(placa));
				return new ModelAndView("confirmar", model);
			}

		} catch (Exception e) {
			model.addAttribute("erro", "Erro: CPF inválido.");
			cpf = null;
			return new ModelAndView("aluguel", model);
		}
	}

	@RequestMapping(value = "/aluguel/finalizar", method = RequestMethod.POST)
	public ModelAndView finalizarPost(@RequestParam Map<String, String> params, ModelMap model) {
		String placa = params.get("placa");
		String cpf = params.get("cpf");
		String dataRetirada = params.get("dataRetirada");
		String qtdDias = params.get("qtdDias");
		Locatario l = new Locatario();
		try {
			Aluguel aluguel = new Aluguel();
			aluguel.setCarro(cService.buscar(placa));
			l = lService.buscarPorCpf(cpf);
			aluguel.setLocatario(l);
			if(dataRetirada != null && !dataRetirada.isEmpty()) {
				LocalDate data = LocalDate.parse(dataRetirada);
				if (data.isBefore(LocalDate.now())) {
			        throw new IllegalArgumentException("A data de retirada não pode ser anterior a hoje.");
			    }
				 aluguel.setDataRetirada(data);
			}
			if(qtdDias != null && !qtdDias.isEmpty()){
				int dias = Integer.parseInt(qtdDias);
				if(dias < 1) {
					throw new IllegalArgumentException("A quantidade de dias deve ser maior do que zero.");
				}
				aluguel.setQtdDias(dias);
			}
			aluguel.setTanqueCheio(true);
			aService.registrarLocacao(aluguel);
			int id = aluguel.getId();
			return new ModelAndView("redirect:/aluguel/sucesso?idLocacao=" + id);

		} catch (Exception e) {
			model.addAttribute("erro", "Erro:" + e.getMessage());
			model.addAttribute("locatario", l);
			model.addAttribute("carro", cService.buscar(placa));
			return new ModelAndView("confirmar", model);
		}
	}
	
	@RequestMapping(value = "/aluguel/sucesso", method = RequestMethod.GET)
	public ModelAndView sucessoGet(@RequestParam int idLocacao, ModelMap model) {
	    model.addAttribute("idLocacao", idLocacao);
	    return new ModelAndView("sucesso");
	}
	
	@RequestMapping(value = "/locacoes", method = RequestMethod.GET)
	public ModelAndView locacoesGet(
	        @RequestParam(required = false, defaultValue = "") String status,
	        ModelMap model) {

	    List<AluguelDto> locacoes;

	    if (status.isEmpty()) {
	        locacoes = aService.listarLocacoes(null); 
	    } else {
	        locacoes = aService.listarLocacoes(status); 
	    }

	    model.addAttribute("locacoes", locacoes);
	    model.addAttribute("statusSelecionado", status);
	    return new ModelAndView("locacoes");
	}
}