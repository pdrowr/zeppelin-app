module KepplerOrders
  class PremiumOrder < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'operti'

    def self.new_order(order)
      PremiumOrder.new(
        id_empresa: 'ZEPPEL',
        agencia: '001',
        tipoprecio: '1',
        estatusdoc: '0',
        estacion: '999',
        almacen: '01',
        formafis: '1',
        al_libro: '1',
        tipodoc: 'ESP',
        codcliente: '01235813',
        nombrecli: 'Cliente super especial',
        rif: 'J01235813',
        direccion: 'Punto Fijo',
        uemisor: 'WEBMENU',
        motanul: '',
        xrequest: '',
        xresponse: '',
        sector: '01',
        dbcr: '1',
        factorcamb: '1',
        multi_div: '0',
        notas: '',
        totimpuest: order.iva,
        impuesto1: order.iva,
        impuesto2: order.iva,
        orden: order.id,
        totbruto: order.subtotal,
        totneto: order.subtotal,
        totalfinal: order.subtotal,
        documento: order.doc,
        referencia: order.reference,
        ordentrab: "E#{order.table.id_consumo}",
        ampm: order.created_at.strftime('%p').eql?('AM') ? 1 : 2,
        fechacrea: order.created_at.strftime('%Y-%m-%d'),
        emision: order.created_at.strftime('%Y-%m-%d'),
        recepcion: order.created_at.strftime('%Y-%m-%d'),
        vence: order.created_at.strftime('%Y-%m-%d'),
        horadocum: order.updated_at.strftime('%I:%M'),
        fechayhora: order.created_at,
        vendedor: order.user.waiter_code,
        apa_nc: '0',
        documentolocal: ' ',
        comanda_movil: '1',
        comanda_kmonitor: '1',
        para_llevar: '0',
        notimbrar: '0',
        antipo: ' ',
        antdoc: ' ',
        parcialidad: '0',
        cedcompra: ' ',
        subcodigo: ' ',
        cprefijoserie: ' ',
        contingencia: '0',
        precta_movil: '0',
        tipodocfiscal: '0',
        cprefijodeserie: ' ',
        cserie: ' ',
        serieincluyeimpuesto: '0',
        serieauto: '0',
        opemail: ' ',
      )
    end

    # def self.update_order(orders, id)
    #   @order = Order.find(id)
    #   orders.update_all(
    #     totbruto: @order.subtotal, totneto: @order.subtotal,
    #     totalfinal: @order.subtotal, totimpuest: @order.iva,
    #     horadocum: @order.updated_at.strftime('%H:%M'),
    #     impuesto1: @order.iva, impuesto2: @order.iva
    #   )
    # end
    #
    # def order
    #   Order.find_by reference: referencia
    # end
    #
    # def items
    #   PremiumItem.where(tipodoc: 'ESP', documento: documento)
    # end
    #
    # def items_id
    #   items.map { |x| x.codigo.strip }
    # end
    #
    # def total
    #   totbruto + totimpuest
    # end

  end
end
