package edu.fzl.LocadoraVeiculos.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.fzl.LocadoraVeiculos.model.Categoria;
import edu.fzl.LocadoraVeiculos.service.CategoriaService;

@Controller
public class CategoriaController {

	@Autowired
	private CategoriaService cService;

	@RequestMapping(name = "categoria", value = "/categoria", method = RequestMethod.GET)
	public ModelAndView categoriaGet(@RequestParam Map<String, String> params, ModelMap model) {
		Categoria c = new Categoria();
		model.addAttribute("categoria", c);
		return new ModelAndView("categoria");
	}

	@RequestMapping(name = "categoria", value = "/categoria", method = RequestMethod.POST)
	public ModelAndView categoriaPost(@RequestParam Map<String, String> params, ModelMap model) {

		String cmd = params.get("acao");
		String codigo = params.get("codigo");
		String nome = params.get("nome");
		String valor = params.get("valor");

		Categoria c = new Categoria();
		List<Categoria> categorias = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			if (!cmd.equalsIgnoreCase("Inserir") && !cmd.equalsIgnoreCase("Listar")) {
				if (codigo != null && !codigo.isEmpty()) {
					c.setCodigo(Integer.parseInt(codigo));
				} else {
					throw new Exception("Informe um ID.");
				}
			}
			
			if (cmd.equalsIgnoreCase("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {
				if(nome != null && !nome.isEmpty() && nome.length() > 2) {
					c.setNome(nome);
				} else {
					throw new Exception("Nome da categoria inválido.");
				}
				
				if (valor != null && !valor.trim().isEmpty()) {
					c.setValor(Double.parseDouble(valor.replace(",", ".")));
					if(c.getValor() < 0) {
						throw new Exception("O Valor da categoria deve ser positivo.");
					}
				} else {
					throw new Exception("Valor da categoria inválido.");
				}
			}

			if (cmd.equalsIgnoreCase("Inserir") ) {
				cService.salvar(c);
				saida = "Categoria inserida";
			} 
			else if (cmd.equalsIgnoreCase("Atualizar")) {
				cService.salvar(c);
				saida = "Categoria atualizada";
			} 
			else if (cmd.equalsIgnoreCase("Excluir")) {
				cService.excluir(c.getCodigo());
				saida = "Categoria excluida";
			} 
			else if (cmd.equalsIgnoreCase("Buscar")) {
				c = cService.buscar(c.getCodigo());
				if (c == null) {
					erro = "ID " + codigo + " não encontrado";
					c = new Categoria();
				}
			}

			categorias = cService.listar();

		} catch (Exception e) {
			e.printStackTrace();
			erro = "Erro: " + e.getMessage();
		} finally {
			if (!cmd.equalsIgnoreCase("Buscar")) {
				c = null;
			}

			if (!cmd.equalsIgnoreCase("Listar")) {
				categorias = null;
			}

			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("categoria", c);
			model.addAttribute("categorias", categorias);
		}

		return new ModelAndView("categoria");
	}
}