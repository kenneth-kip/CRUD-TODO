module V1
  class ItemsController < ApplicationController
    before_action :set_bucketlist
    before_action :set_bucketlist_item, only: [:show, :update, :destroy]

    # GET /bucketlists/:bucketlist_id/items
    def index
      json_response(@bucketlist.items)
    end

    # GET /bucketlists/:bucketlist_id/items/:id
    def show
      json_response(@bucketlist)
    end

    def create
      @bucketlist.items.create!(item_params)
      json_response(@bucketlist, :created)
    end

    # PUT /bucketlists/:bucketlist_id/items/:id
    def update
      @item.update(item_params)
      head :no_content
    end

    # DELETE /bucketlists/:bucketlist_id/items/:id
    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :done)
    end

    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:bucketlist_id])
    end

    def set_bucketlist_item
      @item = @bucketlist.items.find_by!(id: params[:id]) if @bucketlist
    end  
  end
end
  
