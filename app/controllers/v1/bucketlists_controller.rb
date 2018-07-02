module V1
  class BucketlistsController < ApplicationController
    before_action :set_bucketlist, only: [:show, :update, :destroy]

    def index
      @bucketlists = current_user.bucketlists.paginate(page: params[:page], per_page: 20)
      json_response(@bucketlists)
    end

    def create
      @bucketlist = current_user.bucketlists.create!(bucketlist_params)
      json_response(@bucketlist, :created)
    end

    def show
      json_response(@bucketlist)
    end

    def update
      @bucketlist.update(bucketlist_params)
      head :no_content
    end

    def destroy
      @bucketlist.destroy
      head :no_content
    end

    private

    def bucketlist_params
      # whitelist params
      params.permit(:name, :created_by)
    end

    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:id])
    end
  end
end

