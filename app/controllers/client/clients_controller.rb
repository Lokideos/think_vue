# frozen_string_literal: true

class Client::ClientsController < Client::BaseController
  before_action :load_vue_pack

  def index; end

  def create
    client = Client.new(client_params)

    if client.save
      serializer = ClientSerializer.new(client)
      render json: serializer.serializable_hash, status: :created
    else
      render json: ErrorSerializer.from_model(client).to_json, status: :unprocessable_entity
    end
  end

  def clients_data
    serializer = ClientSerializer.new(Client.all)

    render json: serializer.serializable_hash, status: :ok
  end

  private

  def client_params
    params.require(:client).permit(:email, :password, :fullname, :phone)
  end

  def load_vue_pack
    @vue_pack = 'clients'
  end
end
