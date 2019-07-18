module KepplerOrders
  class PremiumItem < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'opermv'

    def self.new_order_item(item)
      now = DateTime.now
      PremiumItem.new(
        id_empresa: 'ZEPPEL',
        agencia: '001',
        origen: '1',
        almacen: '01',
        proveedor: '01235813',
        timpueprc: '12',
        usaserial: '2',
        tipoprecio: '1',
        agrupado: '2',
        compuesto: '2',
        usaexist: '1',
        estacion: '999',
        se_imprimio: '0',
        tipodoc: 'ESP',
        emisor: 'WEBMENU',
        se_guardo: '0',
        aux1: '1',
        enviado_kmonitor: '0',
        cantidad: '1',
        notas: item.parsed_observations,
        baseimpo1: 1 * item.dish.precio1,
        documento: item.order.account.doc,
        grupo: item.dish.grupo,
        codigo: item.dish.codigo,
        nombre: item.dish.nombre,
        costounit: item.dish.costo,
        preciounit: item.dish.precio1,
        preciofin: item.dish.precio1,
        preciooriginal: item.dish.precio1,
        montoneto: item.dish.precio1 * 1,
        montototal: item.dish.precio1 * 1,
        fechadoc: item.created_at.strftime('%Y-%m-%d'),
        fechayhora: item.created_at.strftime('%Y-%m-%d %H:%M:%S'),
        vendedor: item.order.account.waiter.id,
        pid: "#{now.mon}#{now.mday}#{now.seconds_since_midnight}"
      )
    end
  end
end
