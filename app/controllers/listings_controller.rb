class ListingsController < ApplicationController
  before_action :authenticate_landlord!, only: %i[new create edit update delete]
  before_action :set_listing, only: %i[ show edit update destroy ]

  # GET /listings or /listings.json
  def index
    @listings = if params[:search].present?
      Listing.search(params[:search])
    else
      Listing.all
    end
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = current_landlord.listings.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = current_landlord.listings.new(listing_params.except(:image))

    respond_to do |format|
      if @listing.save
        if listing_params[:image].present?
          response = Cloudinary::Uploader.upload(listing_params[:image])
          @listing.update!(image_url: response['url'])
        end
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params.except(:image))
        if listing_params[:image].present?
          response = Cloudinary::Uploader.upload(listing_params[:image])
          @listing.update!(image_url: response['url'])
        end
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = current_landlord.listings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :description, :location, :landlord_id, :image)
    end
end
