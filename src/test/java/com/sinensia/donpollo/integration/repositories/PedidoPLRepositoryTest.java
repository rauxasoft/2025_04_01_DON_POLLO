package com.sinensia.donpollo.integration.repositories;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import com.sinensia.donpollo.integration.model.EstadoPedidoPL;
import com.sinensia.donpollo.integration.model.PedidoPL;

@DataJpaTest
@Sql(scripts= {"/data/h2/schema_testing.sql", "/data/h2/data_testing.sql"})
public class PedidoPLRepositoryTest {

	@Autowired
	PedidoPLRepository pedidoPLRepository;
	
	@Test
	void findByEstablecimientoIdTest() {
		
		List<PedidoPL> resultado = pedidoPLRepository.findByEstablecimientoId(1L);
		
		assertTrue(resultado.size() == 11);
	}
	
	@Test
	void findByFechaHoraBetweenOrderByFechaHoraTest_WithResults() throws Exception {
		
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        
        Date desde = formato.parse("17/04/2023 09:10:00");
        Date hasta = formato.parse("17/04/2023 09:40:00");
        
        List<PedidoPL> resultado = pedidoPLRepository.findByFechaHoraBetweenOrderByFechaHora(desde, hasta);
        
        assertTrue(resultado.size() == 6);
        
	}
	
	@Test
	void findByFechaHoraBetweenOrderByFechaHoraTest_EmptyResult() throws Exception {
		
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        
        Date desde = formato.parse("17/04/2023 08:10:00");
        Date hasta = formato.parse("17/04/2023 09:01:41");
        
        List<PedidoPL> resultado = pedidoPLRepository.findByFechaHoraBetweenOrderByFechaHora(desde, hasta);
        
        assertTrue(resultado.isEmpty());

	}
	
	@Test
	void getDTO1Test() {
		List<Object[]> resultado = pedidoPLRepository.getDTO1();
		Object[] primerResultado = resultado.get(0);
		
		Long numeroPedido = (Long) primerResultado[0];
		String nomEstablecimiento = (String) primerResultado[1];
		Date fecha = (Date) primerResultado[2];
		EstadoPedidoPL estado = (EstadoPedidoPL) primerResultado[3];
		String dependiente = (String) primerResultado[4];
		
        assertTrue(resultado.size() == 15);
        
		assertTrue(numeroPedido.equals(1000L));
		assertTrue(nomEstablecimiento.equals("GRAN VIA 2"));
		assertTrue(fecha.toString().equals("2023-04-17 09:01:42.069"));
		assertTrue(estado.equals(EstadoPedidoPL.ENTREGADO));
		assertTrue(dependiente.equals("PEÑA OJEDA, JOSÉ RAMÓN"));
	}
}
