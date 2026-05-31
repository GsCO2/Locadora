package edu.fzl.LocadoraVeiculos.controller;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import edu.fzl.LocadoraVeiculos.model.*;
import edu.fzl.LocadoraVeiculos.service.*;
import edu.fzl.LocadoraVeiculos.repository.*;

@Controller
public class CarroController {

    @Autowired 
    private CarroService cService;
    @Autowired 
    private CategoriaService catService;
    @Autowired 
    private TipoCambioRepository cambioRep;
    @Autowired 
    private TipoCombustivelRepository combRep;

    @RequestMapping(value = "/carro", method = RequestMethod.GET)
    public ModelAndView carroGet(ModelMap model) {
        preencherListas(model);
        model.addAttribute("carro", new Carro());
        model.addAttribute("carros", new ArrayList<Carro>());
        return new ModelAndView("carro");
    }

    @RequestMapping(value = "/carro", method = RequestMethod.POST)
    public ModelAndView carroPost(@RequestParam Map<String, String> params, ModelMap model) {
        String cmd = params.get("acao");
        Carro c = new Carro();
        String saida = "";
        String erro = "";

        try {
            c.setPlaca(params.get("placa"));
            c.setMarca(params.get("marca"));
            c.setModelo(params.get("modelo"));
            c.setCor(params.get("cor"));
            if(params.get("ano") != null && !params.get("ano").isEmpty()) 
            	c.setAno(Integer.parseInt(params.get("ano")));
            if(params.get("quilometragem") != null && !params.get("quilometragem").isEmpty()) 
            	c.setQuilometragem(Integer.parseInt(params.get("quilometragem")));
            c.setStatus(params.get("status"));

            if (cmd.equalsIgnoreCase("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {
                Categoria cat = new Categoria();
                cat.setCodigo(Integer.parseInt(params.get("id_categoria")));
                c.setCategoria(cat);

                TipoCambio cam = new TipoCambio();
                cam.setId(Integer.parseInt(params.get("id_cambio")));
                c.setTipoCambio(cam);

                TipoCombustivel com = new TipoCombustivel();
                com.setId(Integer.parseInt(params.get("id_combustivel")));
                c.setTipoCombustivel(com);
            }

            if (cmd.equalsIgnoreCase("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {
                cService.salvar(c);
                saida = "Veículo salvo com sucesso!";
            } else if (cmd.equalsIgnoreCase("Excluir")) {
                cService.excluir(c.getPlaca());
                saida = "Veículo excluído!";
            } else if (cmd.equalsIgnoreCase("Buscar")) {
                c = cService.buscar(c.getPlaca());
                if (c == null) { erro = "Placa não encontrada"; c = new Carro(); }
            }

            model.addAttribute("carros", cService.listar());

        } catch (Exception e) {
            erro = "Erro: " + e.getMessage();
        } finally {
            preencherListas(model); 
            if (!cmd.equalsIgnoreCase("Buscar")) c = new Carro();
            model.addAttribute("carro", c);
            model.addAttribute("saida", saida);
            model.addAttribute("erro", erro);
        }
        return new ModelAndView("carro");
    }

    private void preencherListas(ModelMap model) {
        model.addAttribute("listaCategorias", catService.listar());
        model.addAttribute("listaCambios", cambioRep.findAll());
        model.addAttribute("listaCombustiveis", combRep.findAll());
    }
}