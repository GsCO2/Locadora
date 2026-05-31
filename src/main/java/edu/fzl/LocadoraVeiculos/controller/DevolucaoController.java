package edu.fzl.LocadoraVeiculos.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.fzl.LocadoraVeiculos.model.Aluguel;
import edu.fzl.LocadoraVeiculos.repository.AluguelRepository;
import edu.fzl.LocadoraVeiculos.service.DevolucaoService;

@Controller
public class DevolucaoController {

	@Autowired
	private DevolucaoService dService;

	@Autowired
	private AluguelRepository aRepo;

	@RequestMapping(name = "devolucao", value = "/devolucao", method = RequestMethod.GET)
	public ModelAndView devolucaoGet(ModelMap model) {
		preencherAlugueisAtivos(model);
		return new ModelAndView("devolucao");
	}

	@RequestMapping(name = "devolucao", value = "/devolucao", method = RequestMethod.POST)
	public ModelAndView devolucaoPost(@RequestParam Map<String, String> params, ModelMap model) {
		String cmd = params.get("acao");
		String placa = params.get("placa_selecionada"); 
		String litrosStr = params.get("litrosFaltantes");
		boolean enviarOficina = (params.get("enviarOficina") != null);

		String saida = "";
		String erro = "";

		try {
			if ("Finalizar".equalsIgnoreCase(cmd)) {
				if (placa == null || placa.isEmpty()) {
					throw new Exception("Selecione um veiculo");
				}

				int litros = (litrosStr != null && !litrosStr.isEmpty()) ? Integer.parseInt(litrosStr) : 0;
				Double valorTotal = dService.finalizarDevolucao(placa, litros, enviarOficina);
				saida = "Devolução da placa " + placa + " concluido. Valor Total a Pagar: R$ " + String.format("%.2f", valorTotal);
				
				if (enviarOficina) {
					saida += "(Veiculo encaminhado para OFICINA)";
				}
			}
		} catch (Exception e) {
			erro = "Erro ao processar devolução: " + e.getMessage();
		} finally {
			preencherAlugueisAtivos(model);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("devolucao");
	}

	private void preencherAlugueisAtivos(ModelMap model) {
		List<Aluguel> ativos = aRepo.findByStatusAluguel("ATIVO");
		model.addAttribute("alugueisAtivos", ativos);
	}
}