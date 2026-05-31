package edu.fzl.LocadoraVeiculos.controller;

import java.time.LocalDate;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import edu.fzl.LocadoraVeiculos.model.Aluguel;
import edu.fzl.LocadoraVeiculos.model.Carro;
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

    @RequestMapping(name = "aluguel", value = "/aluguel", method = RequestMethod.GET)
    public ModelAndView aluguelGet(@RequestParam Map<String, String> params, ModelMap model) {
    	preencherDisponiveis(model);
        model.addAttribute("alugueis", aService.listarTodos());
        return new ModelAndView("aluguel");
    }

    @RequestMapping(name = "aluguel", value = "/aluguel", method = RequestMethod.POST)
    public ModelAndView aluguelPost(@RequestParam Map<String, String> params, ModelMap model) {
        String cmd = params.get("acao");
        String cpfBusca = params.get("cpf_locatario");
        
        String saida = "";
        String erro = "";
        Locatario locatario = null;

        try {
            if (cmd.equalsIgnoreCase("Verificar Cliente")) {
            	locatario = lService.buscarPorCpf(cpfBusca);
                if (locatario == null) {
                    return new ModelAndView("redirect:/locatario?cpf=" + cpfBusca);
                }
                saida = "Cliente verificado: " + locatario.getNome();
            } 
            
            if (cmd.equalsIgnoreCase("Confirmar Aluguel")) {
                Aluguel a = new Aluguel();
                Carro car = cService.buscar(params.get("placa_carro"));
                locatario = lService.buscarPorCpf(cpfBusca);
                
                if (locatario == null) throw new Exception("CPF não verificado.");

                a.setCarro(car);
                a.setLocatario(locatario);
                a.setDataRetirada(LocalDate.parse(params.get("data_retirada")));
                a.setQtdDias(Integer.parseInt(params.get("qtd_dias")));
                a.setTanqueCheio(params.get("tanque_cheio") != null);
                a.setStatusAluguel("ATIVO");
                
                aService.registrarLocacao(a);
                saida = "Locação registrada!";
            }
        } catch (Exception e) {
            erro = e.getMessage();
        } finally {
            model.addAttribute("saida", saida);
            model.addAttribute("erro", erro);
            model.addAttribute("locatarioEncontrado", locatario);
            preencherDisponiveis(model);
            model.addAttribute("alugueis", aService.listarTodos());
        }

        return new ModelAndView("aluguel");
    }

    private void preencherDisponiveis(ModelMap model) {
        model.addAttribute(
            "carrosDisponiveis",
            cService.listarPorStatus("DISPONIVEL")
        );
    }
}