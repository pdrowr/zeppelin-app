module KepplerOrders
  class PremiumItem < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'opermv'

    def self.new_order_item(item)
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
        notas: '',
        baseimpo1: 1 * item.article.precio1,
        documento: item.order.doc,
        grupo: item.article.grupo,
        codigo: item.article.codigo,
        nombre: item.article.nombre,
        costounit: item.article.costo,
        preciounit: item.article.precio1,
        preciofin: item.article.precio1,
        preciooriginal: item.article.precio1,
        montoneto: item.article.precio1 * 1,
        montototal: item.article.precio1 * 1,
        fechadoc: item.created_at.strftime('%Y-%m-%d'),
        fechayhora: item.created_at.strftime('%Y-%m-%d %H:%M:%S'),
        vendedor: item.order.user.waiter_code,
        pid: "#{now.mon}#{now.mday}#{now.seconds_since_midnight}"
      )
    end

    private

    def now
      DateTime.now
    end

  end
end
