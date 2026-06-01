package edu.fzl.LocadoraVeiculos.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import edu.fzl.LocadoraVeiculos.model.Reparo;
import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.service.ReparoService;
import edu.fzl.LocadoraVeiculos.service.CarroService;

@Controller
public class ReparoController {

    @Autowired 
    private ReparoService rService;
    @Autowired 
    private CarroService cService;

    @RequestMapping(value = "/reparo", method = RequestMethod.GET)
    public ModelAndView abrir(ModelMap model) {
        preencherDados(model);
        return new ModelAndView("reparo");
    }

    @PostMapping("/reparo")
    public ModelAndView processar(@RequestParam Map<String, String> params, ModelMap model) {
        String acao = params.get("acao");
        String saida = "";
        String erro = "";
        try {
            if ("Registrar Reparo".equalsIgnoreCase(acao)) {
                Reparo r = new Reparo();
                Carro c = cService.buscar(params.get("placa_carro"));
                r.setCarro(c);
                r.setDataEntrada(LocalDate.now());
                r.setPrazoDias(Integer.parseInt(params.get("prazo_dias")));
                r.setDescricao(params.get("descricao"));
                r.setValorReparo(
                    Double.parseDouble(
                        params.get("valor_reparo").replace(",", ".")
                    )
                );
                rService.registrarReparo(r);
                cService.buscar(params.get("placa_carro"));
                c.setStatus("INDISPONIVEL");
                cService.salvar(c);
                saida = "Veículo em reparo";
            } else if ("Finalizar".equalsIgnoreCase(acao)) {
                int id = Integer.parseInt(params.get("id_reparo"));
                rService.finalizarReparo(id);
                saida = "Veículo liberado";
            }
        } catch (Exception e) {
            erro = "Erro: " + e.getMessage();
        }
        model.addAttribute("saida", saida);
        model.addAttribute("erro", erro);
        
        preencherDados(model);
        return new ModelAndView("reparo");
    }

    private void preencherDados(ModelMap model) {
        List<Carro> emOficina = cService.listarPorStatus("OFICINA");

        model.addAttribute("carrosOficina", emOficina);
        model.addAttribute("reparos", rService.listarTodos());
    }
}