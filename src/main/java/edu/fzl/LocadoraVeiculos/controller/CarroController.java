package edu.fzl.LocadoraVeiculos.controller;

import java.time.LocalDate;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import edu.fzl.LocadoraVeiculos.model.*;
import edu.fzl.LocadoraVeiculos.service.*;

@Controller
public class CarroController {

	@Autowired
	private CarroService cService;
	@Autowired
	private CategoriaService catService;

	@RequestMapping(value = "/carro", method = RequestMethod.GET)
	public ModelAndView carroGet(ModelMap model) {
		Carro car = new Carro();
		preencherListas(model);
		model.addAttribute("carro", car);
		return new ModelAndView("carro");
	}

	@RequestMapping(value = "/carro", method = RequestMethod.POST)
	public ModelAndView carroPost(@RequestParam Map<String, String> params, ModelMap model) {
		String cmd = params.get("acao");
		Carro c = new Carro();
		List<Carro> carros = cService.listar();
		String placa = params.get("placa");
		String marca = params.get("marca");
		String status = params.get("status");
		String modelo = params.get("modelo");
		String cor = params.get("cor");
		String ano = params.get("ano");
		String km = params.get("quilometragem");
		String categoria = params.get("id_categoria");
		String cambio = params.get("id_cambio");
		String combustivel = params.get("id_combustivel");
		String saida = "";
		String erro = "";
		Categoria cat = new Categoria();
		TipoCambio camb = new TipoCambio();
		TipoCombustivel comb = new TipoCombustivel();

		try {

			if (!cmd.equalsIgnoreCase("Listar")) {
				if (placa != null && !placa.isEmpty() && placa.length() == 7) {
					String[] placaSplitada = placa.split("");
					if (placaSplitada[0].matches("\\d+") || placaSplitada[1].matches("\\d+")
							|| placaSplitada[2].matches("\\d+")) {
						throw new Exception("Os três primeiros dígitos da placa devem ser letras.");
					}

					if (!placaSplitada[3].matches("\\d+") || !placaSplitada[5].matches("\\d+")
							|| !placaSplitada[6].matches("\\d+")) {
						throw new Exception("o quarto, sexto e sétimo dígitos devem ser números.");
					}
					c.setPlaca(placa);
				} else {
					throw new Exception("Placa inválida");
				}
			}
			
			if(cmd.equalsIgnoreCase("Inserir")) {
				Carro car = null;
				car = cService.buscar(c.getPlaca());
				if(car != null) {
					throw new Exception("Placa já existente no sistema.");
				}
			}
			
			if (cmd.equalsIgnoreCase("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {

				if (marca != null && !marca.isEmpty() && marca.matches("[A-Za-zÀ-ÿ ]+") && marca.length() >= 2
						&& marca.length() <= 30) {
					c.setMarca(params.get("marca"));
				} else {
					throw new Exception("Marca inválida.");
				}

				if (modelo != null && !modelo.isEmpty() && modelo.matches("[A-Za-zÀ-ÿ0-9 ]+") && modelo.length() >= 2
						&& modelo.length() < 30) {
					c.setModelo(params.get("modelo"));
				} else {
					throw new Exception("Modelo inválido.");
				}

				if (cor != null && !cor.isEmpty() && cor.matches("[A-Za-zÀ-ÿ ]+") && cor.length() > 3
						&& cor.length() < 20) {
					c.setCor(cor);
				} else {
					throw new Exception("Cor inválida.");
				}

				if (params.get("ano") != null && !params.get("ano").isEmpty() && ano.matches("\\d+")) {
					int anoInt = Integer.parseInt(params.get("ano"));
					if (anoInt < 2000) {
						throw new Exception("Ano tem que ser maior que 2000.");
					}

					if (anoInt > LocalDate.now().getYear()) {
						throw new Exception("Ano tem que ser menor ou igual o ano atual.");
					}

					c.setAno(anoInt);

				} else {
					throw new Exception("Ano inválido.");
				}

				if (km != null && !km.isEmpty() && km.matches("\\d+")) {
					int kms = Integer.parseInt(params.get("quilometragem"));
					if (kms < 0) {
						throw new Exception("Quilometragem tem que ser igual ou maior que 0");
					}

					c.setQuilometragem(kms);
				} else {
					throw new Exception("Quilometragem inválida.");
				}

				if (!status.equalsIgnoreCase("DISPONIVEL") && !status.equalsIgnoreCase("INDISPONIVEL")
						&& !status.equalsIgnoreCase("ALUGADO") && !status.equalsIgnoreCase("REPARO")) {
					throw new Exception("Status inválido.");
				}
				
				status = status.toUpperCase();
				c.setStatus(status);
				
				if (categoria != null && !categoria.isEmpty() && categoria.matches("\\d+")) {
					int catCod = Integer.parseInt(categoria);
					cat.setCodigo(catCod);
					c.setCategoria(cat);
				} else {
					throw new Exception("Categoria inválida");
				}

				if (cambio != null && !cambio.isEmpty() && cambio.matches("\\d+")) {
					int cambCod = Integer.parseInt(cambio);
					camb.setId(cambCod);
					c.setTipoCambio(camb);
				} else {
					throw new Exception("Cambio inválido");
				}

				if (combustivel != null && !combustivel.isEmpty() && combustivel.matches("\\d+")) {
					int combCod = Integer.parseInt(combustivel);
					comb.setId(combCod);
					c.setTipoCombustivel(comb);
				} else {
					throw new Exception("Combustível inválido");
				}

				cService.salvar(c);
				saida = "Veículo salvo com sucesso!";
			}

			if (cmd.equalsIgnoreCase("Excluir")) {
				cService.excluir(c.getPlaca());
				saida = "Veículo excluído!";
			} else if (cmd.equalsIgnoreCase("Buscar")) {
				c = cService.buscar(c.getPlaca());
				if (c == null) {
					erro = "Placa não encontrada";
					c = new Carro();
				}
			} else if(cmd.equalsIgnoreCase("Listar")) {
				carros = cService.listar();
			}


		} catch (Exception e) {
			erro = "Erro: " + e.getMessage();
		} finally {
			preencherListas(model);
			if (!cmd.equalsIgnoreCase("Buscar")) {
				c = new Carro();
			} 
			if(!cmd.equalsIgnoreCase("Listar")) {
				carros = null;
			}
			model.addAttribute("carros", carros);
			model.addAttribute("carro", c);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("carro");
	}
	
	@RequestMapping(value = "/carrosdisponiveis", method = RequestMethod.GET)
	public ModelAndView carrosDisponiveisGet(@RequestParam Map<String, String> params, ModelMap model) {
		List<CarrosDispDto> carros = null;
		List<Categoria> categorias = catService.listar();
		String idCategoria = params.get("idCategoria");
		if (idCategoria != null && !idCategoria.isEmpty()) {
	        int id = Integer.parseInt(idCategoria);
			carros = cService.listaPorCategoria(id);
	        model.addAttribute("idCategoriaSelecionada", idCategoria);
	    } else {
	        carros = cService.listarDisponiveis();
	    }
		model.addAttribute("carros", carros);
		model.addAttribute("categorias", categorias);
		return new ModelAndView("carrosdisponiveis");
	}
	private void preencherListas(ModelMap model) {
		model.addAttribute("listaCategorias", catService.listar());
		model.addAttribute("listaCambios", cService.listarCambios());
		model.addAttribute("listaCombustiveis", cService.listarCombustiveis());
	}
}