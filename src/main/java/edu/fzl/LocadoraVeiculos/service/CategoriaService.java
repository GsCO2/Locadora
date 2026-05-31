package edu.fzl.LocadoraVeiculos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fzl.LocadoraVeiculos.model.Categoria;
import edu.fzl.LocadoraVeiculos.repository.CategoriaRepository;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository cRep;

    public void salvar(Categoria categoria) {
        cRep.save(categoria);
    }

    
    public Categoria buscar(int codigoCategoria) {
        return cRep.findByCodigo(codigoCategoria);
    }

    public List<Categoria> listar() {
        return cRep.findAll();
    }
    
    public void excluir(int codigoCategoria) {
        cRep.deleteById(codigoCategoria);
    }
}