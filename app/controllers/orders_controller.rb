class OrdersController < InheritedResources::Base
  load_and_authorize_resource :order, through: :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to recipes_path
  end

  def index
    if current_user.is?(:admin)
      @orders = current_user.orders
    else
      @orders = current_user.orders.checked_out
    end
  end

  def new
    @order = next_order
    new!
  end

  def edit
    redirect_to new_order_url and return
  end

  def show
    show!
  end

  def check
  end

  def preparation
  end

  def pdf

    send_data(@order.generate_order_pdf.render,
    :filename    => "order_#{@order.id}.pdf",
    :disposition => 'attachment')
  end

  def export
    respond_to do |format|
      format.csv do
        send_data @order.to_csv, filename: "#{@order.report_name}.csv"
      end
      format.xls do
        set_xls_headers
        render :export
      end
    end
  end

  private
    def set_xls_headers
      response.headers['Content-Disposition'] = "attachment; filename='#{@order.report_name}.xls'"
      response.headers['Content-Transfer-Encoding'] = 'binary'
      response.headers['Content-Type'] = 'application/vnd.ms-excel; charset=utf-8;'
    end

    def checkout_notification
      cutoff   = Delivery.cutoff.strftime('%B %d, %Y at %l:%M %p')
      delivery = Delivery.next.strftime('%B %d, %Y')

      "Thanks for your order, <span>#{current_user.first}</span>!\
      Your confirmation number is <span>##{@order.id}</span>.
      You have until <span>#{cutoff}</span> to change it. \
      Otherwise, see you on <span>#{delivery}</span> between \
      <span>3PM</span> and <span>6PM</span>!".html_safe
    end
end
